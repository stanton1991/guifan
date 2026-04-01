const express = require("express");
const cors = require("cors");
const dotenv = require("dotenv");
const jwt = require("jsonwebtoken");
const bcrypt = require("bcryptjs");
const { createClient } = require("@supabase/supabase-js");

dotenv.config();

const app = express();
const PORT = process.env.PORT || 3000;
const JWT_SECRET = process.env.JWT_SECRET || "dev_jwt_secret_change_me";
const SUPABASE_URL = process.env.SUPABASE_URL;
const SUPABASE_SERVICE_ROLE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY;
const FRONTEND_ORIGIN = process.env.FRONTEND_ORIGIN || "*";

if (!SUPABASE_URL || !SUPABASE_SERVICE_ROLE_KEY) {
  console.error(
    "Missing SUPABASE_URL or SUPABASE_SERVICE_ROLE_KEY in backend/.env"
  );
  process.exit(1);
}

const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY);

app.use(
  cors({
    origin: FRONTEND_ORIGIN === "*" ? true : FRONTEND_ORIGIN,
    credentials: true,
  })
);
app.use(express.json());

function signToken(user) {
  return jwt.sign(
    { uid: user.id, username: user.username },
    JWT_SECRET,
    { expiresIn: "7d" }
  );
}

function authMiddleware(req, res, next) {
  const authHeader = req.headers.authorization || "";
  const token = authHeader.startsWith("Bearer ")
    ? authHeader.slice(7)
    : null;

  if (!token) {
    return res.status(401).json({ message: "未登录或 token 缺失" });
  }

  try {
    req.user = jwt.verify(token, JWT_SECRET);
    next();
  } catch (_error) {
    return res.status(401).json({ message: "token 无效或已过期" });
  }
}

app.get("/api/health", (_req, res) => {
  res.json({ ok: true });
});

app.post("/api/auth/register", async (req, res) => {
  try {
    const { username, password } = req.body || {};
    if (!username || !password) {
      return res.status(400).json({ message: "用户名和密码不能为空" });
    }
    if (password.length < 6) {
      return res.status(400).json({ message: "密码长度至少 6 位" });
    }

    const { data: existingUser, error: selectError } = await supabase
      .from("app_users")
      .select("id")
      .eq("username", username)
      .maybeSingle();

    if (selectError) {
      return res.status(500).json({ message: "查询用户失败", detail: selectError.message });
    }

    if (existingUser) {
      return res.status(409).json({ message: "用户名已存在" });
    }

    const password_hash = await bcrypt.hash(password, 10);
    const { data: insertedUser, error: insertError } = await supabase
      .from("app_users")
      .insert({ username, password_hash })
      .select("id, username, created_at")
      .single();

    if (insertError) {
      return res.status(500).json({ message: "注册失败", detail: insertError.message });
    }

    const token = signToken(insertedUser);
    return res.status(201).json({
      message: "注册成功",
      token,
      user: insertedUser,
    });
  } catch (error) {
    return res.status(500).json({ message: "服务器错误", detail: error.message });
  }
});

app.post("/api/auth/login", async (req, res) => {
  try {
    const { username, password } = req.body || {};
    if (!username || !password) {
      return res.status(400).json({ message: "用户名和密码不能为空" });
    }

    const { data: user, error: userError } = await supabase
      .from("app_users")
      .select("id, username, password_hash, created_at")
      .eq("username", username)
      .maybeSingle();

    if (userError) {
      return res.status(500).json({ message: "查询用户失败", detail: userError.message });
    }

    if (!user) {
      return res.status(401).json({ message: "用户名或密码错误" });
    }

    const passMatched = await bcrypt.compare(password, user.password_hash);
    if (!passMatched) {
      return res.status(401).json({ message: "用户名或密码错误" });
    }

    const token = signToken(user);
    return res.json({
      message: "登录成功",
      token,
      user: {
        id: user.id,
        username: user.username,
        created_at: user.created_at,
      },
    });
  } catch (error) {
    return res.status(500).json({ message: "服务器错误", detail: error.message });
  }
});

function sanitizeIlikeFragment(text) {
  return String(text || "")
    .replace(/%/g, "")
    .replace(/,/g, " ")
    .trim();
}

app.get("/api/knowledge/standards", authMiddleware, async (_req, res) => {
  try {
    const { data, error } = await supabase
      .from("building_codes")
      .select("code_name");

    if (error) {
      return res.status(500).json({ message: "获取规范列表失败", detail: error.message });
    }

    const names = [...new Set((data || []).map((r) => r.code_name).filter(Boolean))].sort(
      (a, b) => a.localeCompare(b, "zh-CN")
    );

    return res.json({ items: names });
  } catch (error) {
    return res.status(500).json({ message: "服务器错误", detail: error.message });
  }
});

app.get("/api/knowledge/search", authMiddleware, async (req, res) => {
  try {
    const qRaw = (req.query.q || "").trim();
    const codeFilter = (req.query.code || "").trim();
    if (!qRaw) {
      return res.status(400).json({ message: "请输入关键词或问题" });
    }

    const safe = sanitizeIlikeFragment(qRaw);
    if (!safe) {
      return res.status(400).json({ message: "请输入有效的关键词或问题" });
    }

    const orClause = codeFilter
      ? `title.ilike.%${safe}%,content.ilike.%${safe}%,keywords.ilike.%${safe}%`
      : `code_name.ilike.%${safe}%,title.ilike.%${safe}%,content.ilike.%${safe}%,keywords.ilike.%${safe}%`;

    let query = supabase
      .from("building_codes")
      .select("id, code_name, clause_no, title, content, keywords, updated_at");

    if (codeFilter) {
      query = query.eq("code_name", codeFilter);
    }

    const { data, error } = await query
      .or(orClause)
      .order("updated_at", { ascending: false })
      .limit(20);

    if (error) {
      return res.status(500).json({ message: "查询知识库失败", detail: error.message });
    }

    return res.json({
      query: qRaw,
      code: codeFilter || null,
      count: data.length,
      items: data,
    });
  } catch (error) {
    return res.status(500).json({ message: "服务器错误", detail: error.message });
  }
});

app.listen(PORT, "0.0.0.0", () => {
  console.log(`Backend running on http://0.0.0.0:${PORT}`);
});

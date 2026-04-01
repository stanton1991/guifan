const fs = require("fs");
const path = require("path");
const dotenv = require("dotenv");
const { createClient } = require("@supabase/supabase-js");

dotenv.config({ path: path.resolve(__dirname, "../.env") });

const SUPABASE_URL = process.env.SUPABASE_URL;
const SUPABASE_SERVICE_ROLE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!SUPABASE_URL || !SUPABASE_SERVICE_ROLE_KEY) {
  console.error("Missing SUPABASE_URL or SUPABASE_SERVICE_ROLE_KEY in backend/.env");
  process.exit(1);
}

const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY);

// Match formats like:
// 5.5.23 疏散楼梯最小净宽度 公共建筑疏散楼梯...
const CLAUSE_LINE_RE = /^(\d+\.\d+\.\d+)\s+(.+?)\s+(.+)$/;

function parseLines(lines) {
  const rows = [];
  let current = null;

  for (const rawLine of lines) {
    const line = String(rawLine || "").trim();
    if (!line) continue;

    const m = line.match(CLAUSE_LINE_RE);
    if (m) {
      if (current) {
        current.content = current.content.trim();
        if (current.content) rows.push(current);
      }

      current = {
        code_name: "GB 50016-2014（2018年版）",
        clause_no: m[1],
        title: m[2],
        content: `${m[3]}\n`,
        keywords: "",
      };
    } else if (current) {
      current.content += `${line}\n`;
    }
  }

  if (current) {
    current.content = current.content.trim();
    if (current.content) rows.push(current);
  }

  return rows;
}

async function upsertBatches(rows, batchSize) {
  for (let i = 0; i < rows.length; i += batchSize) {
    const batch = rows.slice(i, i + batchSize);
    const { error } = await supabase
      .from("building_codes")
      .upsert(batch, { onConflict: "code_name,clause_no,title" });
    if (error) {
      throw new Error(`Upsert failed at ${i + 1}-${i + batch.length}: ${error.message}`);
    }
    console.log(`Upserted ${i + 1}-${i + batch.length}`);
  }
}

async function main() {
  const txtPath = process.argv[2];
  const batchSize = Number(process.argv[3] || 200);

  if (!txtPath) {
    console.log(
      "Usage:\n  node backend/scripts/import-gb50016.js <txt-file-path> [batch-size]\n\nExample:\n  node backend/scripts/import-gb50016.js \"D:/codes/GB50016-2014-2018.txt\" 200"
    );
    process.exit(1);
  }

  const absPath = path.resolve(txtPath);
  if (!fs.existsSync(absPath)) {
    console.error(`File not found: ${absPath}`);
    process.exit(1);
  }

  const text = fs.readFileSync(absPath, "utf8");
  const lines = text.split(/\r?\n/);
  const rows = parseLines(lines);

  if (!rows.length) {
    console.error("No clauses parsed. Check TXT formatting and regex in script.");
    process.exit(1);
  }

  console.log(`Parsed ${rows.length} clauses from ${absPath}`);
  await upsertBatches(rows, batchSize);
  console.log("Import completed.");
}

main().catch((err) => {
  console.error(err.message || err);
  process.exit(1);
});

# 建筑规范知识库查询系统（Vue + Supabase）

这个项目包含：
- 前端：Vue 3 + Vite
- 后端：Node.js + Express（对接 Supabase）
- 功能：注册、登录、登录后建筑规范知识库查询

## 1. 准备 Supabase

1. 在 Supabase 创建项目。
2. 打开 SQL Editor，执行 `backend/supabase_schema.sql`，创建表并插入示例数据。
3. 在 Supabase 项目设置中获取：
   - `SUPABASE_URL`
   - `SUPABASE_SERVICE_ROLE_KEY`

## 2. 配置环境变量

### 后端

1. 复制 `backend/.env.example` 为 `backend/.env`
2. 填写真实值：

```env
PORT=3000
FRONTEND_ORIGIN=*
JWT_SECRET=replace_with_your_jwt_secret
SUPABASE_URL=https://your-project-ref.supabase.co
SUPABASE_SERVICE_ROLE_KEY=your_service_role_key
```

### 前端

1. 复制 `frontend/.env.example` 为 `frontend/.env`
2. 根据后端地址修改：

```env
VITE_API_BASE_URL=http://localhost:3000
```

## 3. 启动项目（局域网可访问）

### 启动后端

```bash
cd backend
npm install
npm run dev
```

后端监听 `0.0.0.0:3000`。

### 启动前端

```bash
cd frontend
npm install
npm run dev
```

前端监听 `0.0.0.0:5173`。

## 4. 局域网访问

在运行机器上执行 `ipconfig`，找到局域网 IP（如 `192.168.1.20`）。

同一局域网其他设备访问：
- 前端：`http://192.168.1.20:5173`
- 后端 API：`http://192.168.1.20:3000`

如果前端在其他设备访问，记得把 `frontend/.env` 里的 `VITE_API_BASE_URL` 改成该局域网 IP，并重启前端。

## 5. 接口说明

- `POST /api/auth/register` 注册
- `POST /api/auth/login` 登录
- `GET /api/knowledge/search?q=关键词` 查询规范（需要 `Authorization: Bearer <token>`）

<script setup>
import { computed, ref } from "vue";

const API_BASE = import.meta.env.VITE_API_BASE_URL || "http://localhost:3000";
const mode = ref("login");
const loading = ref(false);
const queryLoading = ref(false);
const message = ref("");
const token = ref(localStorage.getItem("token") || "");
const user = ref(localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user")) : null);
const authForm = ref({ username: "", password: "" });
const searchText = ref("");
const searchResult = ref([]);
const isLoggedIn = computed(() => !!token.value && !!user.value);

function getThemeClass(codeName) {
  const text = String(codeName || "");
  if (text.includes("防火") || text.includes("GB 50016")) return "theme-fire";
  if (text.includes("结构") || text.includes("JGJ") || text.includes("抗震")) return "theme-structure";
  return "theme-architecture";
}

function getThemeLabel(codeName) {
  const text = String(codeName || "");
  if (text.includes("防火") || text.includes("GB 50016")) return "消防";
  if (text.includes("结构") || text.includes("JGJ") || text.includes("抗震")) return "结构";
  return "建筑";
}

function setSession(sessionToken, sessionUser) {
  token.value = sessionToken;
  user.value = sessionUser;
  localStorage.setItem("token", sessionToken);
  localStorage.setItem("user", JSON.stringify(sessionUser));
}

function clearSession() {
  token.value = "";
  user.value = null;
  localStorage.removeItem("token");
  localStorage.removeItem("user");
}

async function submitAuth() {
  message.value = "";
  loading.value = true;
  try {
    const endpoint = mode.value === "register" ? "/api/auth/register" : "/api/auth/login";
    const resp = await fetch(`${API_BASE}${endpoint}`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(authForm.value),
    });
    const data = await resp.json();
    if (!resp.ok) throw new Error(data.message || "请求失败");
    setSession(data.token, data.user);
    message.value = data.message || "操作成功";
  } catch (error) {
    message.value = error.message || "请求失败";
  } finally {
    loading.value = false;
  }
}

async function searchKnowledge() {
  message.value = "";
  if (!searchText.value.trim()) {
    message.value = "请输入关键词或问题";
    return;
  }
  queryLoading.value = true;
  try {
    const resp = await fetch(`${API_BASE}/api/knowledge/search?q=${encodeURIComponent(searchText.value)}`, {
      headers: { Authorization: `Bearer ${token.value}` },
    });
    const data = await resp.json();
    if (!resp.ok) throw new Error(data.message || "查询失败");
    searchResult.value = data.items || [];
    if (!searchResult.value.length) message.value = "没有匹配的规范条目";
  } catch (error) {
    message.value = error.message || "查询失败";
  } finally {
    queryLoading.value = false;
  }
}
</script>

<template>
  <main class="page">
    <div class="blueprint-layer" aria-hidden="true"></div>
    <section class="card">
      <header class="header">
        <h1>建筑规范知识库查询</h1>
        <p>支持关键词检索，快速定位规范条文内容</p>
      </header>
      <template v-if="!isLoggedIn">
        <div class="tabs">
          <button :class="{ active: mode === 'login' }" @click="mode = 'login'" type="button">登录</button>
          <button :class="{ active: mode === 'register' }" @click="mode = 'register'" type="button">注册</button>
        </div>
        <form @submit.prevent="submitAuth" class="auth-form">
          <label>
            用户名
            <input v-model.trim="authForm.username" required />
          </label>
          <label>
            密码
            <input v-model="authForm.password" type="password" minlength="6" required />
          </label>
          <button type="submit" :disabled="loading">
            {{ loading ? "提交中..." : mode === "register" ? "注册并登录" : "登录" }}
          </button>
        </form>
      </template>
      <template v-else>
        <div class="toolbar">
          <span class="user-badge">当前用户：{{ user.username }}</span>
          <button type="button" class="btn-secondary" @click="clearSession">退出登录</button>
        </div>
        <div class="search-box">
          <input v-model.trim="searchText" placeholder="输入关键词或问题，例如：疏散楼梯净宽度" @keyup.enter="searchKnowledge" />
          <button class="btn-primary" @click="searchKnowledge" :disabled="queryLoading">{{ queryLoading ? "查询中..." : "查询" }}</button>
        </div>
        <p class="result-count" v-if="searchResult.length">共找到 {{ searchResult.length }} 条相关条文</p>
        <div v-else class="empty-state">
          <p>输入关键词开始查询，例如：防火分区、安全出口、疏散楼梯。</p>
        </div>
        <div class="result-list">
          <article v-for="item in searchResult" :key="item.id" class="result-item" :class="getThemeClass(item.code_name)">
            <h3>{{ item.title }}</h3>
            <p class="meta">
              <span class="tag-module">{{ getThemeLabel(item.code_name) }}</span>
              {{ item.code_name }} / 条文 {{ item.clause_no || "-" }}
            </p>
            <p>{{ item.content }}</p>
            <p class="tags">关键词：{{ item.keywords || "-" }}</p>
          </article>
        </div>
      </template>
      <p v-if="message" class="message">{{ message }}</p>
    </section>
  </main>
</template>

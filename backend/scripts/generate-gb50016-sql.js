const fs = require("fs");
const path = require("path");

// Match line format:
// 5.5.23 疏散楼梯最小净宽度 公共建筑疏散楼梯...
const CLAUSE_LINE_RE = /^(\d+\.\d+\.\d+)\s+(.+?)\s+(.+)$/;

function sqlEscape(str) {
  return String(str || "").replace(/'/g, "''");
}

function parseLines(lines, codeName) {
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
        code_name: codeName,
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

function toSql(rows) {
  const lines = [];
  lines.push("-- Auto-generated SQL for GB 50016 full text import");
  lines.push("-- Ensure unique constraint exists:");
  lines.push("-- alter table public.building_codes add constraint uq_building_codes_code_clause_title unique (code_name, clause_no, title);");
  lines.push("");
  lines.push("begin;");
  lines.push("");

  const batchSize = 300;
  for (let i = 0; i < rows.length; i += batchSize) {
    const batch = rows.slice(i, i + batchSize);
    lines.push("insert into public.building_codes (code_name, clause_no, title, content, keywords)");
    lines.push("values");
    batch.forEach((r, idx) => {
      const rowSql = `  ('${sqlEscape(r.code_name)}', '${sqlEscape(r.clause_no)}', '${sqlEscape(r.title)}', '${sqlEscape(r.content)}', '${sqlEscape(r.keywords)}')`;
      lines.push(idx === batch.length - 1 ? `${rowSql}` : `${rowSql},`);
    });
    lines.push("on conflict (code_name, clause_no, title)");
    lines.push("do update set");
    lines.push("  content = excluded.content,");
    lines.push("  keywords = excluded.keywords,");
    lines.push("  updated_at = now();");
    lines.push("");
  }

  lines.push("commit;");
  lines.push("");
  return lines.join("\n");
}

function main() {
  const txtPath = process.argv[2];
  const outputPathArg = process.argv[3];
  const codeNameArg = process.argv[4];

  if (!txtPath) {
    console.log(
      "Usage:\n  node backend/scripts/generate-gb50016-sql.js <txt-file-path> [output-sql-path] [code-name]\n\nExample:\n  node backend/scripts/generate-gb50016-sql.js \"D:/codes/GB50016-2014-2018.txt\" \"backend/sql/gb50016_full.sql\" \"GB 50016-2014（2018年版）\""
    );
    process.exit(1);
  }

  const absTxtPath = path.resolve(txtPath);
  if (!fs.existsSync(absTxtPath)) {
    console.error(`TXT file not found: ${absTxtPath}`);
    process.exit(1);
  }

  const outputPath = outputPathArg
    ? path.resolve(outputPathArg)
    : path.resolve(__dirname, "../sql/gb50016_full.sql");
  const codeName = codeNameArg || "GB 50016-2014（2018年版）";

  const text = fs.readFileSync(absTxtPath, "utf8");
  const rows = parseLines(text.split(/\r?\n/), codeName);
  if (!rows.length) {
    console.error("No clauses parsed. Check source TXT formatting.");
    process.exit(1);
  }

  const sql = toSql(rows);
  fs.mkdirSync(path.dirname(outputPath), { recursive: true });
  fs.writeFileSync(outputPath, sql, "utf8");

  console.log(`Parsed clauses: ${rows.length}`);
  console.log(`SQL generated: ${outputPath}`);
}

main();

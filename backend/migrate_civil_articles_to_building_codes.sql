-- 将 civil_building_articles 迁移为当前检索使用的 building_codes 数据结构
-- 执行前请确保：
-- 1) 已执行 GB50352_2019_civil_building_standard_v3.sql
-- 2) 已存在 public.building_codes 表

-- 推荐：先加唯一约束，避免重复导入
alter table public.building_codes
add constraint uq_building_codes_code_clause_title
unique (code_name, clause_no, title);

insert into public.building_codes (code_name, clause_no, title, content, keywords)
select
  'GB 50352-2019《民用建筑设计统一标准》' as code_name,
  a.article_number as clause_no,
  coalesce(c.chapter_title, '未分类') || ' - ' || a.article_number as title,
  a.article_content as content,
  trim(
    both ',' from
    concat_ws(
      ',',
      'GB50352-2019',
      coalesce(c.chapter_title, ''),
      case when a.is_mandatory then '强制性条文' else '一般性条文' end,
      coalesce(a.article_type, '')
    )
  ) as keywords
from public.civil_building_articles a
left join public.civil_building_chapters c on c.id = a.chapter_id
where a.article_content is not null
  and length(trim(a.article_content)) > 0
on conflict (code_name, clause_no, title)
do update set
  content = excluded.content,
  keywords = excluded.keywords,
  updated_at = now();

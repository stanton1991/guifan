-- 将 GB50016_2018_fire_code.sql 生成的数据迁移到当前检索表 building_codes
-- 适配源表：
--   public.fire_code_chapters
--   public.fire_code_articles
-- 执行本文件后，前端 /api/knowledge/search 可直接检索到 GB 50016 数据

-- 1) 确保唯一约束存在（避免重复导入）
do $$
begin
  if not exists (
    select 1
    from pg_constraint
    where conname = 'uq_building_codes_code_clause_title'
  ) then
    alter table public.building_codes
      add constraint uq_building_codes_code_clause_title
      unique (code_name, clause_no, title);
  end if;
end
$$;

-- 2) 迁移并 upsert 到检索表
with source_rows as (
  select
    'GB 50016-2014（2018年版）建筑设计防火规范' as code_name,
    a.article_number as clause_no,
    coalesce(c.chapter_title, '未分类') || ' - ' || a.article_number as title,
    a.article_content as content,
    trim(
      both ',' from
      concat_ws(
        ',',
        'GB50016-2018',
        coalesce(c.chapter_title, ''),
        case when a.is_mandatory then '强制性条文' else '一般性条文' end,
        coalesce(a.article_type, ''),
        case
          when pg_typeof(a.keywords)::text = 'text[]' then array_to_string(a.keywords, ',')
          else null
        end
      )
    ) as keywords,
    a.id as source_id
  from public.fire_code_articles a
  left join public.fire_code_chapters c on c.id = a.chapter_id
  where a.article_content is not null
    and length(trim(a.article_content)) > 0
),
deduped_rows as (
  select distinct on (code_name, clause_no, title)
    code_name,
    clause_no,
    title,
    content,
    keywords
  from source_rows
  order by code_name, clause_no, title, source_id desc
)
insert into public.building_codes (code_name, clause_no, title, content, keywords)
select code_name, clause_no, title, content, keywords
from deduped_rows
on conflict (code_name, clause_no, title)
do update set
  content = excluded.content,
  keywords = excluded.keywords,
  updated_at = now();

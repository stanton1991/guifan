create table if not exists public.app_users (
  id bigserial primary key,
  username text not null unique,
  password_hash text not null,
  created_at timestamptz not null default now()
);

create table if not exists public.building_codes (
  id bigserial primary key,
  code_name text not null,
  clause_no text,
  title text not null,
  content text not null,
  keywords text,
  updated_at timestamptz not null default now()
);

insert into public.building_codes (code_name, clause_no, title, content, keywords)
values
  (
    'GB 50016-2014（2018年版）',
    '5.5.23',
    '疏散楼梯最小净宽度',
    '公共建筑疏散楼梯的净宽度不应小于1.10m，高层公共建筑中设置自动喷水灭火系统时，应按规范要求校核疏散能力。',
    '疏散,楼梯,净宽度,消防'
  ),
  (
    'GB 50016-2014（2018年版）',
    '5.5.29',
    '安全出口数量',
    '除符合规范规定可设置1个安全出口的建筑外，其他建筑每个防火分区或楼层安全出口不应少于2个。',
    '安全出口,防火分区,消防'
  ),
  (
    'JGJ 3-2010',
    '3.4.1',
    '结构体系规则性',
    '高层建筑结构布置应尽量规则，避免平面和竖向不规则导致地震作用下受力不利。',
    '高层建筑,抗震,结构'
  );

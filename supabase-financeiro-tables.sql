-- ============================================================
-- ATHENA FINANCEIRO — Tabelas Supabase
-- Execute no SQL Editor do Supabase
-- ============================================================

-- 1. RENEGOCIAÇÕES
create table if not exists fin_renegociacoes (
  id            text primary key,
  nome          text,
  ficha         text,
  data          date,
  valor_total   numeric,
  valor_entrada numeric default 0,
  num_reneg     int default 1,
  situacao      text,
  contato       text,
  motivo_cancelamento text,
  parcelas      jsonb default '[]',
  updated_at    timestamptz default now()
);

-- 2. NEGATIVAÇÕES
create table if not exists fin_negativacoes (
  id                text primary key,
  reneg_id          text,
  nome              text,
  ficha             text,
  valor_total       numeric,
  status            text,
  data_negativacao  date,
  data_pagamento    date,
  parcelas          jsonb default '[]',
  protestos         jsonb default '[]',
  updated_at        timestamptz default now()
);

-- 3. DESATIVAÇÕES
create table if not exists fin_desativacoes (
  id           text primary key,
  nome         text,
  ficha        text,
  tipo         text,
  valor        numeric default 0,
  status       text,
  data         date,
  data_exclusao date,
  motivo       text,
  updated_at   timestamptz default now()
);

-- 4. COBRANÇAS
create table if not exists fin_cobrancas (
  id         text primary key,
  nome       text,
  ficha      text,
  data       date,
  valor      numeric default 0,
  etapa      text,
  obs        text,
  updated_at timestamptz default now()
);

-- Habilitar acesso público (mesma política das outras tabelas)
alter table fin_renegociacoes enable row level security;
alter table fin_negativacoes  enable row level security;
alter table fin_desativacoes  enable row level security;
alter table fin_cobrancas     enable row level security;

create policy "public read"  on fin_renegociacoes for select using (true);
create policy "public write" on fin_renegociacoes for all    using (true);

create policy "public read"  on fin_negativacoes  for select using (true);
create policy "public write" on fin_negativacoes  for all    using (true);

create policy "public read"  on fin_desativacoes  for select using (true);
create policy "public write" on fin_desativacoes  for all    using (true);

create policy "public read"  on fin_cobrancas     for select using (true);
create policy "public write" on fin_cobrancas     for all    using (true);

-- Sleep Research Think Tank local SQLite schema.
-- Phase 9C creates structure only: no real paper data, fake citations,
-- model results, external API, Sleep-EDF processing, or UI connection.

PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS research_domains (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  description TEXT NOT NULL,
  parent_domain TEXT,
  key_concepts TEXT NOT NULL DEFAULT '[]',
  related_methods TEXT NOT NULL DEFAULT '[]',
  related_datasets TEXT NOT NULL DEFAULT '[]'
);

CREATE TABLE IF NOT EXISTS papers (
  id TEXT PRIMARY KEY,
  title TEXT NOT NULL,
  authors TEXT NOT NULL DEFAULT '[]',
  year INTEGER,
  journal TEXT,
  doi TEXT,
  url TEXT,
  research_domain TEXT,
  tags TEXT NOT NULL DEFAULT '[]',
  main_question TEXT NOT NULL DEFAULT '',
  methods TEXT NOT NULL DEFAULT '',
  key_finding TEXT NOT NULL DEFAULT '',
  limitation TEXT NOT NULL DEFAULT '',
  relevance_score REAL,
  status TEXT NOT NULL CHECK (status IN ('to-read', 'summarised', 'important', 'used-in-writing')),
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL,
  FOREIGN KEY (research_domain) REFERENCES research_domains(id)
);

CREATE TABLE IF NOT EXISTS datasets (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  source TEXT,
  file_format TEXT NOT NULL,
  signal_types TEXT NOT NULL DEFAULT '[]',
  annotation_type TEXT NOT NULL,
  epoch_length TEXT,
  task TEXT NOT NULL,
  status TEXT NOT NULL,
  notes TEXT
);

CREATE TABLE IF NOT EXISTS model_results (
  id TEXT PRIMARY KEY,
  model_name TEXT NOT NULL,
  dataset_name TEXT NOT NULL,
  input_signals TEXT NOT NULL DEFAULT '[]',
  split_type TEXT NOT NULL,
  accuracy REAL,
  macro_f1 REAL,
  balanced_accuracy REAL,
  status TEXT NOT NULL,
  notes TEXT,
  created_at TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS weekly_logs (
  id TEXT PRIMARY KEY,
  week_start TEXT NOT NULL,
  completed TEXT NOT NULL DEFAULT '[]',
  in_progress TEXT NOT NULL DEFAULT '[]',
  blocked TEXT NOT NULL DEFAULT '[]',
  literature_added TEXT NOT NULL DEFAULT '[]',
  dataset_progress TEXT NOT NULL DEFAULT '',
  coding_progress TEXT NOT NULL DEFAULT '',
  decisions TEXT NOT NULL DEFAULT '[]',
  next_actions TEXT NOT NULL DEFAULT '[]'
);

CREATE TABLE IF NOT EXISTS decisions (
  id TEXT PRIMARY KEY,
  date TEXT NOT NULL,
  decision TEXT NOT NULL,
  reason TEXT NOT NULL,
  related_phase TEXT,
  related_module TEXT
);

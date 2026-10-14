-- ========================================================================
-- InternHub API — SQLite Database Schema
-- Table: internships
-- Description: Stores persistent internship listings with constraints,
--              defaults, indexes, and automatic timestamp updates.
-- ========================================================================

CREATE TABLE IF NOT EXISTS internships (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL CHECK(length(trim(title)) > 0 AND length(title) <= 150),
  company TEXT NOT NULL CHECK(length(trim(company)) > 0 AND length(company) <= 120),
  domain TEXT NOT NULL CHECK(length(trim(domain)) > 0 AND length(domain) <= 100),
  location TEXT NOT NULL CHECK(length(trim(location)) > 0 AND length(location) <= 150),
  work_mode TEXT NOT NULL CHECK(work_mode IN ('Remote', 'Hybrid', 'On-site')),
  duration TEXT NOT NULL CHECK(length(trim(duration)) > 0 AND length(duration) <= 50),
  stipend INTEGER NOT NULL CHECK(stipend >= 0),
  description TEXT NOT NULL CHECK(length(trim(description)) >= 10 AND length(description) <= 5000),
  skills TEXT NOT NULL, -- JSON-encoded array of skill strings, e.g. ["JavaScript","Express","SQLite"]
  apply_url TEXT NULL,  -- Optional valid URL or NULL
  created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Optimize search and filtering queries
CREATE INDEX IF NOT EXISTS idx_internships_domain ON internships(domain);
CREATE INDEX IF NOT EXISTS idx_internships_work_mode ON internships(work_mode);
CREATE INDEX IF NOT EXISTS idx_internships_created_at ON internships(created_at);

-- Trigger to automatically refresh updated_at on record updates
CREATE TRIGGER IF NOT EXISTS trg_internships_updated_at
AFTER UPDATE ON internships
FOR EACH ROW
BEGIN
  UPDATE internships SET updated_at = CURRENT_TIMESTAMP WHERE id = OLD.id;
END;

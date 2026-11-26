# PostgreSQL Beginner DBA Curriculum

Target: **Debian trixie** · PostgreSQL 16/17

---

## ✅ Phase 0: Persiapan (Done)

- [x] 00-Install — Install PostgreSQL via apt
- [x] 002-Role — Buat database & role dasar

---

## 📚 Phase 1: Dasar-Dasar Operasional

**Folder:** `01-Basics/`

| # | Topik | File | Status |
|---|-------|------|--------|
| 1 | Koneksi & `psql` basics | `01-connect.sql` | ⬜ |
| 2 | Database, Schema, Tablespace | `02-objects.sql` | ⬜ |
| 3 | Tipe data & DDL (CREATE/ALTER/DROP TABLE) | `03-ddl.sql` | ⬜ |
| 4 | DML (INSERT/UPDATE/DELETE/SELECT) | `04-dml.sql` | ⬜ |
| 5 | Constraint (PK, FK, UNIQUE, CHECK, NOT NULL) | `05-constraints.sql` | ⬜ |
| 6 | Index dasar (B-tree, Hash, GIN, GiST) | `06-index.sql` | ⬜ |

---

## 🔧 Phase 2: Administrasi Harian

**Folder:** `02-Admin/`

| # | Topik | File | Status |
|---|-------|------|--------|
| 7 | `pg_hba.conf` & autentikasi | `01-auth.conf` | ⬜ |
| 8 | `postgresql.conf` — memory, WAL, planner | `02-config.conf` | ⬜ |
| 9 | Backup & Restore (`pg_dump`, `pg_basebackup`, PITR) | `03-backup.sh` | ⬜ |
| 10 | Monitoring: `pg_stat_*`, `pg_stat_activity` | `04-monitor.sql` | ⬜ |
| 11 | Vacuum & Autovacuum tuning | `05-vacuum.sql` | ⬜ |
| 12 | Log & error reporting | `06-logging.conf` | ⬜ |

---

## 👥 Phase 3: User & Access Control

**Folder:** `03-Access/`

| # | Topik | File | Status |
|---|-------|------|--------|
| 13 | Role inheritance, group roles | `01-roles.sql` | ⬜ |
| 14 | GRANT/REVOKE column-level, RLS | `02-grants.sql` | ⬜ |
| 15 | Row Level Security (RLS) policies | `03-rls.sql` | ⬜ |
| 16 | Audit logging (pg_audit) | `04-audit.conf` | ⬜ |

---

## ⚡ Phase 4: Performa & Tuning

**Folder:** `04-Performance/`

| # | Topik | File | Status |
|---|-------|------|--------|
| 17 | `EXPLAIN` / `EXPLAIN ANALYZE` reading | `01-explain.sql` | ⬜ |
| 18 | Index lanjutan: partial, expression, covering | `02-index-adv.sql` | ⬜ |
| 19 | Partitioning (range, list, hash) | `03-partition.sql` | ⬜ |
| 20 | Connection pooling (PgBouncer) | `04-pgbouncer.ini` | ⬜ |
| 21 | Work_mem, maintenance_work_mem, effective_cache_size | `05-memory.conf` | ⬜ |

---

## 🔄 Phase 5: High Availability & Replication

**Folder:** `05-HA/`

| # | Topik | File | Status |
|---|-------|------|--------|
| 22 | Streaming Replication (Primary/Standby) | `01-streaming.conf` | ⬜ |
| 23 | Logical Replication & Publications | `02-logical.sql` | ⬜ |
| 24 | Failover & Patroni/Repmgr basics | `03-failover.sh` | ⬜ |
| 25 | Backup verification & restore drill | `04-drill.sh` | ⬜ |

---

## 🛠 Phase 6: Tooling & Ekosistem

**Folder:** `06-Tooling/`

| # | Topik | File | Status |
|---|-------|------|--------|
| 26 | `pg_dump`/`pg_restore` format custom/directory | `01-dump-fmt.sh` | ⬜ |
| 27 | Extensions: `pg_stat_statements`, `uuid-ossp`, `citext`, `pgcrypto` | `02-extensions.sql` | ⬜ |
| 28 | Migration tools (Flyway, Liquibase, golang-migrate) | `03-migrate.sh` | ⬜ |
| 29 | Monitoring stack: Prometheus + pg_exporter + Grafana | `04-prometheus.yml` | ⬜ |

---

## 📦 Phase 7: Mini Project (Capstone)

**Folder:** `07-Capstone/`

| # | Deliverable | File | Status |
|---|-------------|------|--------|
| 30 | Desain schema aplikasi sederhana (e-commerce / blog) | `01-schema.sql` | ⬜ |
| 31 | Migration scripts versioned | `02-migrations/` | ⬜ |
| 32 | Backup strategy doc + cron | `03-backup-strategy.md` | ⬜ |
| 33 | Monitoring dashboard dasar | `04-dashboard.json` | ⬜ |
| 34 | Failover test dokumentasi | `05-failover-test.md` | ⬜ |

---

## 📖 Referensi Cepat

- [PostgreSQL 16 Docs](https://www.postgresql.org/docs/16/)
- [Debian PostgreSQL Wiki](https://wiki.debian.org/PostgreSQL)
- `man 5 pg_hba.conf` / `man 5 postgresql.conf`
- `psql` meta-commands: `\l`, `\dt`, `\d+`, `\du`, `\x`, `\timing`

---

> **Catatan**: Setiap folder berisi `install.sh` + `*.sql` + `README.md` singkat. Jalankan urut dari Phase 1.
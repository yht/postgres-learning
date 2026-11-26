# Phase 6: Tooling & Ekosistem

**Folder:** `06-Tooling/`

Target: Dump format, extensions, migration tools, monitoring stack.

---

## 📋 Daftar File

| File | Deskripsi |
|------|-----------|
| `01-dump-fmt.sh` | `pg_dump -Fc` (custom), `-Fd` (directory), `pg_restore -j` parallel, selective restore |
| `02-extensions.sql` | `pg_stat_statements`, `uuid-ossp`, `citext`, `pgcrypto`, `btree_gin`, `btree_gist` |
| `03-migrate.sh` | Migration tool comparison: Flyway, Liquibase, golang-migrate, dbmate |
| `04-prometheus.yml` | Prometheus scrape config + `postgres_exporter`, Grafana dashboard JSON |

---

## 🚀 Cara Jalankan

```bash
# Dump format
chmod +x 01-dump-fmt.sh
./01-dump-fmt.sh

# Extensions
sudo apt-get install -y postgresql-16-pg-stat-statements postgresql-16-uuid-ossp postgresql-16-pgcrypto
sudo -u postgres psql -f 02-extensions.sql

# Migration tools (pilih satu)
# Flyway: download binary, conf/flyway.conf, migrations/V1__init.sql
# golang-migrate: go install -tags 'postgres' github.com/golang-migrate/migrate/v4/cmd/migrate@latest
chmod +x 03-migrate.sh
./03-migrate.sh

# Monitoring stack
# Install postgres_exporter
sudo apt-get install -y prometheus-postgres-exporter
# Edit /etc/default/prometheus-postgres-exporter: DATA_SOURCE_NAME
sudo systemctl restart prometheus-postgres-exporter
# Prometheus scrape config
sudo cp 04-prometheus.yml /etc/prometheus/prometheus.yml
sudo systemctl reload prometheus
# Import Grafana dashboard dari 04-dashboard.json (di Phase 7)
```

---

## 📝 Catatan Penting

- **Custom format (`-Fc`)** = compressed, parallel restore (`-j`), selective table restore
- **Directory format (`-Fd`)** = parallel dump + restore, file per table
- `pg_stat_statements` wajib untuk query performance analysis — `shared_preload_libraries`
- `uuid-ossp` → `uuid_generate_v4()`; PostgreSQL 13+ punya `gen_random_uuid()` built-in (pgcrypto)
- `citext` = case-insensitive text type (indexable)
- Migration tools: **versioned, repeatable, checksummed** — jangan manual ALTER di prod
- `postgres_exporter` butuh `pg_stat_statements` untuk query-level metrics
- Grafana dashboard: import JSON, set datasource = Prometheus

---

## ✅ Checklist

- [ ] Bisa dump/restore custom & directory format parallel
- [ ] Bisa enable & query `pg_stat_statements` untuk top queries
- [ ] Paham extension umum & kapan dipakai
- [ ] Bisa setup migration tool untuk CI/CD
- [ ] Bisa deploy monitoring stack Prometheus + Grafana
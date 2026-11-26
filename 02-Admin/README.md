# Phase 2: Administrasi Harian

**Folder:** `02-Admin/`

Target: Konfigurasi server, backup/restore, monitoring, vacuum, logging.

---

## 📋 Daftar File

| File | Deskripsi |
|------|-----------|
| `01-auth.conf` | Contoh `pg_hba.conf`: local, host, SSL, peer, md5, scram-sha-256 |
| `02-config.conf` | `postgresql.conf` tuning: memory, WAL, planner, checkpoint |
| `03-backup.sh` | Script backup: `pg_dump`, `pg_basebackup`, PITR setup |
| `04-monitor.sql` | Query monitoring: `pg_stat_activity`, `pg_stat_database`, `pg_stat_user_tables` |
| `05-vacuum.sql` | Vacuum manual, autovacuum config, `pg_stat_progress_vacuum` |
| `06-logging.conf` | `log_*`, `log_min_duration_statement`, `log_line_prefix`, CSV/JSON log |

---

## 🚀 Cara Jalankan

```bash
# Config files — copy ke /etc/postgresql/16/main/ lalu reload
sudo cp 01-auth.conf /etc/postgresql/16/main/pg_hba.conf
sudo cp 02-config.conf /etc/postgresql/16/main/postgresql.conf
sudo systemctl reload postgresql

# Backup script
chmod +x 03-backup.sh
sudo -u postgres ./03-backup.sh

# Monitoring queries
sudo -u postgres psql -f 04-monitor.sql

# Vacuum & logging config
sudo -u postgres psql -f 05-vacuum.sql
sudo cp 06-logging.conf /etc/postgresql/16/main/postgresql.conf.d/logging.conf
sudo systemctl reload postgresql
```

---

## 📝 Catatan Penting

- **Selalu backup config asli** sebelum edit: `cp pg_hba.conf pg_hba.conf.bak`
- Reload config: `SELECT pg_reload_conf();` atau `systemctl reload postgresql`
- `pg_hba.conf` urutan aturan **penting** — paling spesifik di atas
- PITR butuh `wal_level = replica` + `archive_mode = on`
- Autovacuum default sudah baik; tuning hanya untuk workload khusus
- Log format JSON (`log_destination = 'csvlog'` + `logging_collector = on`) memudah parsing

---

## ✅ Checklist

- [ ] Paham `pg_hba.conf` urutan & tipe autentikasi
- [ ] Bisa tuning `shared_buffers`, `work_mem`, `effective_cache_size`, `maintenance_work_mem`
- [ ] Bisa setup backup harian + PITR
- [ ] Bisa query monitoring aktifitas & bloat
- [ ] Paham kapan vacuum manual vs autovacuum
- [ ] Bisa konfigurasi logging terstruktur
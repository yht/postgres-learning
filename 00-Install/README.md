# 00-Install: Install PostgreSQL

Target: Install PostgreSQL 16/17 di Debian trixie via apt.

---

## 📋 File

| File | Deskripsi |
|------|-----------|
| `install.sh` | Script install non-interaktif + enable/start systemd |

---

## 🚀 Jalankan

```bash
chmod +x install.sh
sudo ./install.sh
```

---

## ✅ Verifikasi

```bash
# Cek service
systemctl status postgresql

# Cek version
sudo -u postgres psql -c "SELECT version();"

# Cek port
ss -ltnp | grep 5432
```

---

## 📝 Catatan

- Debian trixie = testing/unstable, PostgreSQL version mengikuti repo (biasanya 16 atau 17)
- `DEBIAN_FRONTEND=noninteractive` untuk CI/CD
- `postgresql-client` include `psql`, `pg_dump`, `pg_restore`, `pg_basebackup`
- Data directory default: `/var/lib/postgresql/16/main/`
- Config: `/etc/postgresql/16/main/postgresql.conf` & `pg_hba.conf`
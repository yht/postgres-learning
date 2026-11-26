# 002-Role: Database & Role Dasar

Target: Buat database `yht` dan role `yht` dengan full privileges.

---

## 📋 File

| File | Deskripsi |
|------|-----------|
| `01-tambah-db.sql` | `DROP DATABASE IF EXISTS yht; CREATE DATABASE yht;` |
| `01-tambah-db.sh`  | Wrapper jalankan SQL sebagai user postgres |
| `02-tambah-hak.sql` | `DROP ROLE IF EXISTS yht; CREATE ROLE yht WITH LOGIN; GRANT ALL PRIVILEGES ON DATABASE yht TO yht;` |
| `02-tambah-hak.sh`  | Wrapper jalankan SQL sebagai user postgres |

---

## 🚀 Jalankan

```bash
chmod +x 01-tambah-db.sh 02-tambah-hak.sh
./01-tambah-db.sh
./02-tambah-hak.sh
```

---

## ✅ Verifikasi

```bash
# Cek database
sudo -u postgres psql -c "\l"

# Cek role
sudo -u postgres psql -c "\du"

# Test koneksi sebagai role yht
psql -U yht -d yht -h localhost -c "SELECT current_user, current_database();"
```

---

## 📝 Catatan

- Script menggunakan `sudo su postgres -c 'psql < file.sql'` — butuh akses sudo
- Role `yht` dibuat dengan `LOGIN` tapi **tanpa password** (peer auth lokal)
- Untuk password: `ALTER ROLE yht WITH PASSWORD 'secret';` lalu update `pg_hba.conf` ke `md5`/`scram-sha-256`
- `GRANT ALL PRIVILEGES ON DATABASE` ≠ grant pada schema/tabel di dalamnya
- Untuk akses tabel: `GRANT ALL ON ALL TABLES IN SCHEMA public TO yht;`
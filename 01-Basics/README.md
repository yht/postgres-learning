# Phase 1: Dasar-Dasar Operasional

**Folder:** `01-Basics/`

Target: Paham struktur database, koneksi, DDL/DML dasar, constraint, index.

---

## 📋 Daftar File

| File | Deskripsi |
|------|-----------|
| `01-connect.sql` | Koneksi psql, meta-commands (`\l`, `\dt`, `\d+`, `\du`, `\x`) |
| `02-objects.sql` | CREATE/DROP DATABASE, SCHEMA, TABLESPACE |
| `03-ddl.sql` | Tipe data, CREATE/ALTER/DROP TABLE, SERIAL/IDENTITY |
| `04-dml.sql` | INSERT, UPDATE, DELETE, SELECT, RETURNING |
| `05-constraints.sql` | PK, FK, UNIQUE, CHECK, NOT NULL, EXCLUSION |
| `06-index.sql` | CREATE INDEX, tipe index (B-tree, Hash, GIN, GiST), partial index |

---

## 🚀 Cara Jalankan

```bash
# Masuk sebagai user postgres
sudo -u postgres psql -f 01-connect.sql
sudo -u postgres psql -f 02-objects.sql
# ... dst
```

Atau jalankan semua sekaligus:
```bash
for f in *.sql; do sudo -u postgres psql -f "$f"; done
```

---

## 📝 Catatan Penting

- Selalu gunakan `sudo -u postgres` untuk akses superuser
- Database default: `postgres` (untuk admin), buat DB sendiri untuk latihan
- `psql` meta-commands diawali backslash `\` — bukan SQL
- Gunakan `\timing` untuk ukur performa query
- `\x` toggle expanded display (vertikal) untuk output lebar

---

## ✅ Checklist

- [ ] Bisa connect & navigi psql
- [ ] Bisa buat/drop database, schema, tablespace
- [ ] Bisa definisikan tabel dengan tipe data yang tepat
- [ ] Bisa CRUD dasar
- [ ] Paham constraint & kapan dipakai
- [ ] Bisa buat index & paham tipe index
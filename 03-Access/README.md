# Phase 3: User & Access Control

**Folder:** `03-Access/`

Target: Role management, privilege system, RLS, audit.

---

## 📋 Daftar File

| File | Deskripsi |
|------|-----------|
| `01-roles.sql` | CREATE ROLE, GROUP ROLE, INHERIT, NOINHERIT, SET ROLE, ROLE membership |
| `02-grants.sql` | GRANT/REVOKE pada database, schema, table, column, sequence, function |
| `03-rls.sql` | Row Level Security: `ALTER TABLE ... ENABLE ROW LEVEL SECURITY`, POLICY |
| `04-audit.conf` | `pg_audit` extension config: session, object, DDL, SELECT audit |

---

## 🚀 Cara Jalankan

```bash
# Role & grants
sudo -u postgres psql -f 01-roles.sql
sudo -u postgres psql -f 02-grants.sql

# RLS (butuh superuser untuk enable)
sudo -u postgres psql -f 03-rls.sql

# pg_audit — install extension dulu
sudo apt-get install -y postgresql-16-pgaudit
# tambah ke postgresql.conf: shared_preload_libraries = 'pgaudit'
sudo systemctl restart postgresql
sudo -u postgres psql -c "CREATE EXTENSION pgaudit;"
sudo cp 04-audit.conf /etc/postgresql/16/main/pgaudit.conf
# include di postgresql.conf: include 'pgaudit.conf'
sudo systemctl reload postgresql
```

---

## 📝 Catatan Penting

- **Role = user + group** di PostgreSQL (tidak ada user/role terpisah)
- `INHERIT` default — role member mewarisi privilege group role
- `GRANT ... ON ALL TABLES IN SCHEMA` hanya berlaku untuk tabel **existing**
- Gunakan `ALTER DEFAULT PRIVILEGES` untuk tabel future
- RLS: policy `USING` (visible rows) vs `WITH CHECK` (rows allowed to insert/update)
- `pg_audit` butuh restart (shared_preload_libraries)
- Audit log bisa besar — rotasi & retensi wajib diatur

---

## ✅ Checklist

- [ ] Bisa buat role hierarchy (group → member)
- [ ] Bisa grant/revoke privilege granular (column-level)
- [ ] Paham default privileges vs existing objects
- [ ] Bisa implementasi RLS untuk multi-tenant
- [ ] Bisa setup pg_audit untuk compliance
# Phase 4: Performa & Tuning

**Folder:** `04-Performance/`

Target: Query planning, index advanced, partitioning, pooling, memory tuning.

---

## 📋 Daftar File

| File | Deskripsi |
|------|-----------|
| `01-explain.sql` | `EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)`, scan types, join types |
| `02-index-adv.sql` | Partial index, expression index, covering index (INCLUDE), BRIN, Bloom |
| `03-partition.sql` | Partitioning: RANGE, LIST, HASH; partition pruning, attachment/detachment |
| `04-pgbouncer.ini` | PgBouncer config: pool_mode, max_client_conn, default_pool_size |
| `05-memory.conf` | `work_mem`, `maintenance_work_mem`, `effective_cache_size`, `random_page_cost` |

---

## 🚀 Cara Jalankan

```bash
# EXPLAIN & index
sudo -u postgres psql -f 01-explain.sql
sudo -u postgres psql -f 02-index-adv.sql

# Partitioning
sudo -u postgres psql -f 03-partition.sql

# PgBouncer
sudo apt-get install -y pgbouncer
sudo cp 04-pgbouncer.ini /etc/pgbouncer/pgbouncer.ini
sudo systemctl restart pgbouncer
# Connect via pgbouncer: psql -p 6432 -h localhost

# Memory tuning
sudo cp 05-memory.conf /etc/postgresql/16/main/conf.d/memory.conf
sudo systemctl reload postgresql
```

---

## 📝 Catatan Penting

- **Selalu `EXPLAIN ANALYZE`** — tidak `EXPLAIN` saja (tanpa actual rows)
- `BUFFERS` flag penting untuk lihat I/O (shared hit/read/dirtied)
- Partial index: `WHERE status = 'active'` — ukuran kecil, cepat
- Expression index: `CREATE INDEX ON t (lower(email))` untuk case-insensitive
- Covering index (`INCLUDE`) — index-only scan tanpa heap fetch
- Partitioning: **partition key harus bagian dari PK/UNIQUE**
- PgBouncer `pool_mode = transaction` default aman; `session` untuk prepared statements
- `work_mem` per operation (sort/hash) — jangan terlalu besar (OOM risk)
- `effective_cache_size` = OS cache + shared_buffers (estimasi, tidak alokasi)

---

## ✅ Checklist

- [ ] Baca & interpretasi `EXPLAIN ANALYZE` output
- [ ] Bisa buat partial/expression/covering index
- [ ] Paham partitioning strategy & maintenance (detach old)
- [ ] Bisa setup PgBouncer untuk connection pooling
- [ ] Bisa tuning memory parameter untuk workload spesifik
# Phase 7: Mini Project (Capstone)

**Folder:** `07-Capstone/`

Target: End-to-end project — schema design, migration, backup strategy, monitoring, failover test.

---

## 📋 Daftar File

| File | Deskripsi |
|------|-----------|
| `01-schema.sql` | Schema aplikasi e-commerce: users, products, orders, order_items, payments |
| `02-migrations/` | Folder migration versioned (V1__init.sql, V2__add_idx.sql, ...) |
| `03-backup-strategy.md` | Dokumentasi: jadwal, retensi, RTO/RPO, lokasi offsite, encryption |
| `04-dashboard.json` | Grafana dashboard JSON: connection, TPS, latency, cache hit, replication lag |
| `05-failover-test.md` | Laporan drill failover: tanggal, durasi, hasil, temuan, action items |

---

## 🚀 Cara Jalankan

```bash
# 1. Deploy schema
sudo -u postgres psql -d yht -f 01-schema.sql

# 2. Migration tool (contoh golang-migrate)
migrate -path 02-migrations/ -database "postgres://yht@localhost/yht?sslmode=disable" up

# 3. Backup strategy — implementasikan script dari Phase 2
#    Tambah cron: 0 2 * * * /path/to/backup.sh >> /var/log/pg_backup.log 2>&1

# 4. Monitoring — import dashboard
#    Grafana UI → Dashboards → Import → Upload 04-dashboard.json

# 5. Failover drill (quarterly)
#    Ikuti 05-HA/04-drill.sh, catat hasil di 05-failover-test.md
```

---

## 📝 Schema Overview (01-schema.sql)

```sql
-- users
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email CITEXT UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    full_name TEXT,
    created_at TIMESTAMPTZ DEFAULT now()
);

-- products
CREATE TABLE products (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    sku TEXT UNIQUE NOT NULL,
    name TEXT NOT NULL,
    description TEXT,
    price_cents INTEGER NOT NULL CHECK (price_cents > 0),
    stock INTEGER NOT NULL DEFAULT 0 CHECK (stock >= 0),
    created_at TIMESTAMPTZ DEFAULT now()
);

-- orders
CREATE TABLE orders (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES users(id),
    status TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending','paid','shipped','cancelled')),
    total_cents INTEGER NOT NULL,
    created_at TIMESTAMPTZ DEFAULT now()
);

-- order_items
CREATE TABLE order_items (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    order_id UUID NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
    product_id UUID NOT NULL REFERENCES products(id),
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    unit_price_cents INTEGER NOT NULL
);

-- payments
CREATE TABLE payments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    order_id UUID NOT NULL REFERENCES orders(id),
    provider TEXT NOT NULL,
    provider_ref TEXT,
    amount_cents INTEGER NOT NULL,
    status TEXT NOT NULL DEFAULT 'pending',
    created_at TIMESTAMPTZ DEFAULT now()
);

-- Indexes
CREATE INDEX idx_orders_user_id ON orders(user_id);
CREATE INDEX idx_orders_status_created ON orders(status, created_at);
CREATE INDEX idx_order_items_order_id ON order_items(order_id);
CREATE INDEX idx_payments_order_id ON payments(order_id);
```

---

## 📝 Catatan Penting

- **UUID PK** — distribusi lebih baik, cocok untuk sharding/replication
- `CITEXT` (citext extension) untuk email case-insensitive
- `price_cents` integer — hindari floating point untuk uang
- `CHECK` constraint di level DB — defense in depth
- Migration versioning: `V1__description.sql`, `V2__...` — urutan lexical
- Backup strategy doc harus include: **restore procedure tested**
- Grafana dashboard: set `refresh = 30s`, variables untuk `datname`, `client_addr`
- Failover test: catat **waktu mulai, waktu selesai, data loss (RPO), downtime (RTO)**

---

## ✅ Checklist Capstone

- [ ] Schema deploy & migrasi berjalan tanpa error
- [ ] Backup cron aktif + restore test berhasil
- [ ] Monitoring dashboard live & alerting dasar (ex: replication lag > 1GB)
- [ ] Failover drill dilakukan & terdokumentasi
- [ ] Semua Phase 1-6 checklist ✅
- [ ] Dokumentasi lengkap di folder ini
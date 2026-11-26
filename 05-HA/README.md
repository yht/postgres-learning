# Phase 5: High Availability & Replication

**Folder:** `05-HA/`

Target: Streaming replication, logical replication, failover, backup drill.

---

## 📋 Daftar File

| File | Deskripsi |
|------|-----------|
| `01-streaming.conf` | Primary & standby config: `wal_level`, `max_wal_senders`, `hot_standby`, `primary_slot_name` |
| `02-logical.sql` | Publication/Subscription: `CREATE PUBLICATION`, `CREATE SUBSCRIPTION`, conflict handling |
| `03-failover.sh` | Script promote standby, `pg_ctl promote`, Patroni/Repmgr intro |
| `04-drill.sh` | Restore drill: `pg_basebackup` + PITR, verification checksum, RTO/RPO test |

---

## 🚀 Cara Jalankan

```bash
# Streaming replication (butuh 2 server/VM)
# Primary:
sudo cp 01-streaming.conf /etc/postgresql/16/main/postgresql.conf.d/streaming.conf
sudo systemctl restart postgresql
sudo -u postgres psql -c "SELECT pg_create_physical_replication_slot('slot_standby1');"

# Standby:
sudo systemctl stop postgresql
sudo -u postgres pg_basebackup -h <primary-ip> -D /var/lib/postgresql/16/main -R -S slot_standby1 -P
sudo systemctl start postgresql

# Logical replication
sudo -u postgres psql -f 02-logical.sql

# Failover test
chmod +x 03-failover.sh
./03-failover.sh

# Backup drill (quarterly)
chmod +x 04-drill.sh
./04-drill.sh
```

---

## 📝 Catatan Penting

- **Streaming replication** = physical (block-level), read-only standby
- **Logical replication** = logical (row-level), bisa subset table, cross-version
- `hot_standby = on` wajib di standby untuk query read-only
- Replication slot (`pg_create_physical_replication_slot`) mencegah WAL recycle sebelum standby ambil
- Logical replication: **tidak replicate DDL** — manual sync schema
- Failover: **promote standby** = `pg_ctl promote` atau `SELECT pg_promote();`
- Patroni/Repmgr: otomatisasi failover + consensus (etcd/consul) — production recommended
- **Backup drill wajib** — backup yg tidak di-test = tidak ada backup
- RTO (Recovery Time Objective) & RPO (Recovery Point Objective) definisikan SLA

---

## ✅ Checklist

- [ ] Bisa setup streaming replication primary-standby
- [ ] Bisa setup logical replication untuk subset tabel
- [ ] Paham perbedaan physical vs logical replication
- [ ] Bisa failover manual & paham risiko split-brain
- [ ] Bisa restore dari backup + PITR ke titik waktu tertentu
- [ ] Dokumentasi RTO/RPO & drill schedule
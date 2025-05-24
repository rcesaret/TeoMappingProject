Below is a complete, end-to-end workflow for creating and populating **four** PostgreSQL databases from `.sql` files, based on the pattern you provided (i.e. a “_create” DDL script plus a data-load script for each database). 

You’ll get:

1. **Directory structure**  
2. A parameterized **`.env.example`** (and instructions for `.env`)  
3. **`requirements.txt`**  
4. A single Python driver script (`setup_databases.py`) that:  
   - Creates each database (if it doesn’t already exist)  
   - Runs its `_create.sql` DDL file  
   - Runs its `.sql` data file  
5. A brief **analysis** of your attached `.sql` files and how the script uses them  

---


## Analysis of your `.sql` files

- **`TMP_DF9_create.sql`**  
  Contains all your DDL: `CREATE TABLE` statements, constraints, indexes, triggers, etc.  
- **`TMP_DF9.sql`**  
  Contains the `INSERT`-style DML to populate those tables.

Our Python script will:

1. Connect to the “postgres” system database  
2. For each target DB name (e.g. `TMP_DF8`, `TMP_DF9`, `TMP_DF10`, `TMP_REAN_DF2`):  
   - Check `pg_database` – CREATE if missing  
   - Connect to that DB and run the matching `_create.sql` → build the schema  
   - Then run the matching `.sql` → load the data  

By mirroring the naming convention (`<DB_NAME>_create.sql` + `<DB_NAME>.sql`), the script is fully generic.

## `.env` file

> **Next step:**  
> Copy this `.env.example` file to `.env` and fill in your real values.  
> Ensure `.env` is added to your `.gitignore`.


## `setup_databases.py` script

- **Key points on `setup_databases.py`**
  - Uses **`python-dotenv`** to load your `.env`.  
  - Connects first to `postgres` to run `CREATE DATABASE`.  
  - Uses **`sqlparse`** to safely split multi-statement SQL.  
  - Wraps each file in a single transactional block (`engine.begin()`).  

---

## `README.md` (excerpt)

---



# Project Setup

## 1. Prerequisites

- PostgreSQL installed & running
- `psql` CLI **optional** (we use SQLAlchemy + psycopg2 in Python)
- Python 3.8+ environment

## 2. Clone & install

```bash
git clone git@github.com:rcesaret/TeoMappingProject.git
cd TeoMappingProject
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

## 3. Configure

```bash
cp .env.example .env
# then open .env and fill in your PG credentials & DB_NAMES
```

## 4. Run

```bash
python phases/01_LegacyDB/src/setup_databases.py
```
This will:

1. Create each database listed in `DB_NAMES`  
2. Execute its `<DB>_create.sql`  
3. Execute its `<DB>.sql`  
4. Report progress to the console  

---

## 7. Next Steps & Best Practices

- **Rotate** credentials regularly.  
- For production, consider a managed secrets store (Vault, AWS Secrets Manager, etc.).  
- Keep your `.env` out of version control.  
- Review logs for any errors during DDL or data loading.

---

With this in place you have a fully reproducible, 4-database setup that:

- **Separates** secrets from code  
- **Automates** creation & population  
- **Scales** simply by editing `DB_NAMES` and dropping in new SQL files  

Let me know if you need any further customization!
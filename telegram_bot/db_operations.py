import sqlite3
from datetime import datetime, timezone, timedelta

DB_FILE = 'temperature_data.db'

def init_db():
    conn = sqlite3.connect(DB_FILE)
    c = conn.cursor()
    c.execute('''CREATE TABLE IF NOT EXISTS temperature_data
                 (timestamp TEXT, temperature REAL, PRIMARY KEY(timestamp, temperature))''')
    conn.commit()
    conn.close()

def save_data_to_db(data):
    conn = sqlite3.connect(DB_FILE)
    c = conn.cursor()
    timestamp = (datetime.now(timezone.utc) + timedelta(hours=2)).isoformat()
    c.execute("INSERT INTO temperature_data (timestamp, temperature) VALUES (?, ?)", (timestamp, data))
    conn.commit()
    conn.close()

def get_min_temperature():
    conn = sqlite3.connect(DB_FILE)
    c = conn.cursor()
    c.execute("SELECT MIN(temperature), COUNT(*) FROM temperature_data")
    result = c.fetchone()
    conn.close()
    return result

def get_max_temperature():
    conn = sqlite3.connect(DB_FILE)
    c = conn.cursor()
    c.execute("SELECT MAX(temperature), COUNT(*) FROM temperature_data")
    result = c.fetchone()
    conn.close()
    return result

def get_avg_temperature():
    conn = sqlite3.connect(DB_FILE)
    c = conn.cursor()
    c.execute("SELECT AVG(temperature), COUNT(*) FROM temperature_data")
    result = c.fetchone()
    conn.close()
    return result

def get_last_n_measurements(n):
    conn = sqlite3.connect(DB_FILE)
    c = conn.cursor()
    c.execute("SELECT * FROM temperature_data ORDER BY timestamp DESC LIMIT ?", (n,))
    result = c.fetchall()
    conn.close()
    return result

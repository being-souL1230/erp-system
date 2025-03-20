import pymysql  
import json  

# ✅ Config.json se credentials read karna  
with open('config.json') as config_file:  
    config = json.load(config_file)  

try:  
    # ✅ MySQL connection  
    conn = pymysql.connect(  
        host=config['host'],  
        user=config['user'],  
        password=config['password']  
    )  
    cursor = conn.cursor()  

    # ✅ Database create karna  
    cursor.execute(f"CREATE DATABASE IF NOT EXISTS {config['database']}")  
    print(f"✅ Database '{config['database']}' checked/created successfully.")  

    # ✅ Database se connect karna  
    conn.select_db(config['database'])  

    # ✅ Students table create  
    cursor.execute('''  
    CREATE TABLE IF NOT EXISTS students (  
        id INT AUTO_INCREMENT PRIMARY KEY,  
        name VARCHAR(100),  
        email VARCHAR(100),  
        password VARCHAR(100),  
        attendance INT DEFAULT 0  
    )  
    ''')  
    print("✅ Students table checked/created successfully.")  

    # ✅ Faculty table create  
    cursor.execute('''  
    CREATE TABLE IF NOT EXISTS faculty (  
        id INT AUTO_INCREMENT PRIMARY KEY,  
        name VARCHAR(100),  
        email VARCHAR(100),  
        password VARCHAR(100)  
    )  
    ''')  
    print("✅ Faculty table checked/created successfully.")  

    conn.commit()  

except Exception as e:  
    print(f"❌ Error: {e}")  

finally:  
    cursor.close()  
    conn.close()
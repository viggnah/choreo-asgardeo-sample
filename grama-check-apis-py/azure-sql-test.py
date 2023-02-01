import pyodbc
from flask import Flask, request
import os

app = Flask(__name__)

server = os.environ.get("server")
database = os.environ.get("database")
username = os.environ.get("username")
password = os.environ.get("password")
driver = os.environ.get("driver")

@app.route('/national_id/verify', methods=['POST'])
def verify_national_id():
    data = request.get_json()
    national_id = data.get('national_id')
    print("Received National ID = ", national_id)
    
    if national_id is None:
        return {"message": "Bad Request: Missing national_id parameter"}, 400

    if check_azure_sql_db(national_id):
        return {"message": f"National ID {national_id} exists"}, 200
    else:
        return {"message": f"National ID {national_id} does not exist"}, 404

def check_azure_sql_db(national_id):
    with pyodbc.connect('DRIVER='+driver+';SERVER=tcp:'+server+';PORT=1433;DATABASE='+database+';UID='+username+';PWD='+ password+';Encrypt=yes;TrustServerCertificate=no;Connection Timeout=30;') as conn:
        with conn.cursor() as cursor:
            cursor.execute("SELECT NationalId FROM NATIONAL_ID WHERE NationalId=?", national_id)
            return cursor.fetchone()

from flask import Flask,jsonify,request 
from fortune import fortune
import re
app = Flask(__name__) 

@app.route('/healthcheck', methods = ['GET']) 
def healthcheck(): 
    if(request.method == 'GET'):
        return  '', 200

@app.route('/fortune', methods = ['GET']) 
def fortuner(): 
    if(request.method == 'GET'):

        raw_fortune = fortune()  # This likely contains literal \n and \t
        cleaned = re.sub(r'[\n\t\\"]', ' ', raw_fortune).strip()
        response = {
            "Fortune": cleaned
        }

        response= jsonify(response)
        return response
    
if __name__=='__main__': 
    app.run(host='0.0.0.0', port=8000, debug=True)

from flask import Flask, jsonify, request
from flask_cors import CORS

# =====================================================================
# config
# =====================================================================
app = Flask(__name__)
CORS(app)


# =====================================================================
# route
# =====================================================================


@app.route('/test', methods=['GET'])
def test():

    return jsonify({'result': 'text'})


@app.route('/process', methods=['POST', 'GET'])
def process():
    #shopID = 1
    #itemID = 1
    shopID = request.form.get('shopID')
    itemID = request.form.get('itemID')

    try:
        return jsonify({
            'itemID': itemID,
            'shopID': shopID
        })
    except:
        return {'error': 'error'}, 404



# =====================================================================
# main
# =====================================================================
if __name__ == '__main__':
    app.run(host='0.0.0.0', port='12038', debug=True, threaded=True)
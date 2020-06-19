from flask import Flask, jsonify, request

app = Flask(__name__)


@app.route('/test', methods=['GET'])
def test():
    return jsonify({'result': 'text'})


@app.route('/process', methods=['GET'])
def process():
    return jsonify({'result': 'processing data...'})


if __name__ == '__main__':
    app.run(host='0.0.0.0', port='12038', debug=True, threaded=True)
from flask import Flask, jsonify, request
from flask_cors import CORS
from concurrent.futures import ThreadPoolExecutor
import concurrent.futures

import time

from command.forecast import forecast

# =====================================================================
# config
# =====================================================================
app = Flask(__name__)
CORS(app)


# =====================================================================
# variables
# =====================================================================

thread_list = []


# =====================================================================
# route
# =====================================================================


@app.route('/test', methods=['GET'])
def test():

    return jsonify({'result': 'text'})


@app.route('/process', methods=['POST', 'GET'])
def process():
    shop_id = request.form.get('shopID')
    item_id = request.form.get('itemID')

    do_predict(shop_id, item_id)

    return {'result':'success'}

# =====================================================================
# function
# =====================================================================


def test(a, b):
    print(a, b)

    time.sleep(10)


def do_predict(shop_id, item_id):
    with ThreadPoolExecutor(max_workers=8) as executor:
        thread_list.append(executor.submit(test, shop_id, item_id))

        for execution in concurrent.futures.as_completed(thread_list):

            print(shop_id, item_id, 'is done')
            execution.result()
            execution.done()


def do_process():
    pass


# =====================================================================
# main
# =====================================================================
if __name__ == '__main__':
    app.run(host='0.0.0.0', port='12038', debug=True, threaded=True)
from flask import Flask, jsonify, request
from flask_cors import CORS
from concurrent.futures import ThreadPoolExecutor
import concurrent.futures

import time

import threading

from command.forecast import forecast
from model.request import requestDAO

# =====================================================================
# config
# =====================================================================
app = Flask(__name__)
CORS(app)

current_request_id = -1
current_shop_id = -1
current_item_id = -1

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


@app.route('/process', methods=['POST'])
def process():
    shop_id = request.form.get('shopID')
    item_id = request.form.get('itemID')

    request_id = requestDAO.add(shop_id, item_id)

    global current_shop_id
    global current_item_id
    global current_request_id

    current_request_id = request_id
    current_shop_id = shop_id
    current_item_id = item_id

    return {'result': 'success'}


@app.teardown_request
def teardown_request(response):
    global current_shop_id
    global current_item_id
    global current_request_id

    do_predict(current_shop_id, current_item_id, current_request_id)

    current_request_id = -1
    current_shop_id = -1
    current_item_id = -1

    return response


# =====================================================================
# function
# =====================================================================
def do_predict(shop_id, item_id, request_id):
    with ThreadPoolExecutor(max_workers=2) as executor:
        thread_list.append(executor.submit(do_process, shop_id, item_id, request_id))

        for execution in concurrent.futures.as_completed(thread_list):
            execution.result()
            execution.done()


def do_process(shop_id, item_id, request_id):

    try:
        forecast.start_predict(shop_id, item_id)

        requestDAO.setState(request_id, '완료')
    except:
        requestDAO.setState(request_id, '오류 발생')


# =====================================================================
# main
# =====================================================================
if __name__ == '__main__':
    app.run(host='0.0.0.0', port='12038', debug=True, threaded=True)

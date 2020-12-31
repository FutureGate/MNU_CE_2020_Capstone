from flask import Flask, jsonify, request
from flask_cors import CORS
from concurrent.futures import ThreadPoolExecutor
import concurrent.futures

import time

import threading

from command.forecast import forecast
from command.statistics import statistics

from model.request import requestDAO
from model.forecast import forecastDAO

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


@app.route('/process', methods=['POST'])
def process():
    shop_id = request.form.get('shopID')
    item_id = request.form.get('itemID')

    # print(shop_id, item_id)

    check = do_check(shop_id, item_id)

    if check is 0:
        return {'error': 'error'}, 578
    elif check is -1:
        return {'error': 'error'}, 577
    elif check is -2:
        return {'error': 'error'}, 576

    request_id = requestDAO.add(shop_id, item_id)

    do_predict(shop_id, item_id, request_id)

    return {'result': 'success'}


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
        statistics.start_stat(shop_id, item_id, request_id)

        forecast.start_predict(shop_id, item_id, request_id)

        requestDAO.setState(request_id, '완료')
    except:
        requestDAO.setState(request_id, '오류 발생')


def do_check(shop_id, item_id):
    return forecastDAO.check_base_date(shop_id, item_id)


# =====================================================================
# main
# =====================================================================
if __name__ == '__main__':
    app.run(host='0.0.0.0', port='12038', debug=True, threaded=True)

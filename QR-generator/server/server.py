from bottle import route, run, error
import random
import string
import time


@route('/api/seed')
def seed():
    return {
        'data': get_seed(),
        'expiredAt': get_expiration_date(),
    }


def get_seed():
    return ''.join(random.choices(string.ascii_lowercase + string.digits, k=32))


def get_expiration_date():
    # will expire in 1 minute
    return int(round(time.time() * 1000)) + 60 * 1000


@error(404)
def handle404(error):
    return 'Nothing here, try "/api/seed" ?'


run(host='localhost', port=2333)

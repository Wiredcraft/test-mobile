/**
 * Created by jhonny on 16/5/17.
 */


var errRespond = function (req, next, msg) {
    var respondObj = {
        'status': 0,
        'msg': msg,
        'data': null
    };
    req.respondObj = respondObj;
    next();
};

var normalRespond = function (req, next, data) {
    var respondObj = {
        'status': 1,
        'msg': 'success',
        'data': data
    };
    req.respondObj = respondObj;
    next();
};

module.exports.err = errRespond;
module.exports.normal = normalRespond;

module.exports.serverErr = function (req, next) {
    errRespond(req, next, 'server error');
};
/**
 * Blockinfo.js
 *
 * @description :: TODO: You might write a short summary of how this model works and what it represents here.
 * @docs        :: http://sailsjs.org/#!documentation/models
 */

module.exports = {
    attributes: {
        name: {
            type: "string"
        },
        newspaper: {
            model: 'releasenewspapers'
        }

    }, beforeCreate: function (values, next) {
        if (!!!values.order) {
            Blockinfo.count().exec(function (error, count) {
                    if (error) return next(error);
                    values.order  =  count +1;
                    next();
            });
        }
        else
            next();
    }
};


/**
 * User.js
 *
 * @description :: TODO: You might write a short summary of how this model works and what it represents here.
 * @docs        :: http://sailsjs.org/#!documentation/models
 */
// var bcrypt = require('bcrypt');//TODO: test to work in this place. see in http://www.geektantra.com/2013/08/implement-passport-js-authentication-with-sails-js/ 
module.exports = {
    connection: 'someMongodbServer', // "localMysqlServer", //"localPostgresqlServer",//
    schema: true,
    attributes: {
        name: {
            type: "string",
            required: true
        },
        login: {
            type: "string"
        },
        email: {
            type: 'string',
            email: true,
            unique: true,
            required: true
        },
        password: {
            type: 'string',
            required: true,
            minLength: 6
        },
        encryptedPassword: {
            type: "string"
        },
        // clear model data 
        toJSON: function () {
            var obj = this.toObject();
            delete obj.password;
            delete obj.confirmation;
            delete obj.encryptedPassword;
            delete obj._csrf;
            return obj;
        },
        // real-time attribute controll
        online: {
            type: "boolean",
            defaultsTo: false
        },
        admin: {
            type: "boolean",
            defaultsTo: false
        },
        role: {
            model: "roles"
        }
    },
    beforeValidate: function(attrs, next){
        console.log(attrs);
        if (!!attrs.admin){
            if(attrs.admin === 'unchecked'){
                attrs.admin = false;
            }else if (attrs.admin[1]=== 'on'){
                attrs.admin = true;
            }
        }
        next();
    }, 
    /**
     * Controll attribute before create 
     * @param {type} attrs
     * @param {type} next
     * @returns {unresolved} 
     */
    beforeCreate: function (attrs, next) {
        //This  checks to make sure the password and password confirmation match before creating record
        if (!attrs.password || attrs.password != attrs.confirmation) {
            return next({err: ["Пароль и подтверждение пароля не совпадают!"]});
        }
        console.log(attrs);
//        var bcrypt = require('bcrypt');
//
//        bcrypt.genSalt(10, function (err, salt) {
//            if (err)
//                return next(err);
//
//            bcrypt.hash(attrs.password, salt, function (err, hash) {
//                if (err)
//                    return next(err); 
//                attrs.password = hash;
//                attrs.encryptedPassword = hash;
        //        next();//TODO: test next(null, attrs);
//            });
//        });

        next();//TODO: test next(null, attrs);
    }

};


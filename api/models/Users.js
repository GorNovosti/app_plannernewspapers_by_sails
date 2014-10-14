/**
 * Users.js
 *
 * @description :: TODO: You might write a short summary of how this model works and what it represents here.
 * @docs        :: http://sailsjs.org/#!documentation/models
 */

module.exports = {
    connection: 'someMongodbServer',
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
    //        password: {
    //            type: 'string',
    //            required: true,
    //            minLength: 6
    //        },
    //        encryptedPassword: {
    //            type: "string"
    //        },
        // clear model data 
        toJSON: function () {
            var obj = this.toObject();
            delete obj.password;
            delete obj.confirmation;
            delete obj.encryptedPassword;
            delete obj._csrf;
            return obj;
        },
        role: {
            model: "roles"
        }
    }
};


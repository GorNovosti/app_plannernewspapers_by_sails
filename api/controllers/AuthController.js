/**
 * AuthController
 *
 * @description :: Server-side logic for managing auths
 * @help        :: See http://links.sailsjs.org/docs/controllers
 */
var passport = require('passport');

module.exports = {
    login: function (req, res) {
        res.view(null, {
            title: "Вход"
        });
    },
    process: function (req, res, next) {
        console.log('next',next);
        passport.authenticate('local', function (err, user, info) {
            if ((err) || (!user)) {
                return res.send({message: "Login faild"});
                res.send(err);
            }
            req.logIn(user, function (err) {
                if (err) res.send(err);
                return res.send({message: "Login succesful!"});
            });
        })(req,res);
    },
    logout: function (req, res) {
        req.logout();
        req.send('logout successful');

    }
};


/**
 * admin
 *
 * @module      :: Policy
 * @description :: Admin message controll
 * @docs        :: http://sailsjs.org/#!documentation/policies
 *
 */
module.exports = function (req, res, next) {

    if (req.session.User && req.session.User.admin) {
        return next();
    } else {
        var requireAdminError = {name: "requireAdminError", message: "Доступно только администратору. Пожалуйста авторизуйтесь как адиминистратор системы."};
        req.session.flash = {
            err: [requireAdminError]
        };

        res.redirect('/session/new');
        return;
    }
};


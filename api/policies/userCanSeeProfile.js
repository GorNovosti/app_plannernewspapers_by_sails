/**
 * userCanSeeProfile
 *
 * @module      :: Policy
 * @description :: User Can See Profile
 * @docs        :: http://sailsjs.org/#!documentation/policies
 *
 */
module.exports = function (req, res, next) {
    var sessionUserMatchesId = (req.session.User.id === req.param('id'));
    var isAdmin = req.session.User.admin;

    if (!(sessionUserMatchesId || isAdmin)) {
        var noRigthsError = {name: "noRigthsError", message: "Доступно только администратору. Пожалуйста авторизуйтесь как адиминистратор системы."};
        req.session.flash = {
            err: [noRigthsError]
        };
        res.redirect('/session/new');
        return;
    }
    next(); 
};


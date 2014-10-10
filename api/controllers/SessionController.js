/**
 * SessionController
 *
 * @description :: Server-side logic for managing sessions
 * @help        :: See http://links.sailsjs.org/docs/controllers
 */
/*example https://github.com/irlnathan/activityoverlord/blob/master/api/controllers/SessionController.js */
//var bcrypt = require('bcrypt');
module.exports = {
    /***
     * Create new session a work 
     * @param {type} req
     * @param {type} res
     * @returns {undefined}
     */
    'new': function (req, res) {
//        var oldDate = new Date();
//        var newDateObj = new Date(oldDate.getTime() + 60000);
//        req.session.cookie.expires = newDateObj;
//        req.session.authenticated = true;
//        console.log(req.session);
        res.view(null, {
            title: "Авторизоваться"
        });
    },
    /**
     * 
     * @param {type} req
     * @param {type} res
     * @param {type} next
     * @returns {undefined}
     */
    create: function (req, res, next) {
        // Check requered params 
        if (!req.param('email') || !req.param('password')) {
            req.session.flash = {
                err: [
                    {name: 'usernamePasswordRequired', message: "Неверно указаны пароль и e-mail"}
                ]
            };
            res.redirect('/session/new');
            return;
        }
        User.findOneByEmail(req.param('email')).exec(function foundUser(err, user) {
            if (!err)
                next(err);
            if (!user) {
                var noAccountError = {name: "noAccount", massage: "Пользователь с адресом " + req.param('email') + " не найден"};
                req.session.flash = {err: [noAccountError]};
                res.redirect('/session/new');
                return;
            }
            //TODO: debug on Linuk bcrypt like http://www.youtube.com/watch?v=AooPVuYGnuU&list=PLWsZeJCry-F4K4iRImeB3-i0S5mw9Ak-W&index=16
            //            bcrypt.compare(req.param('password'), user.encryptedPassword, function (err, match) {
            //                if (err)
            //                    res.json({error: 'Server error'}, 500);
            //
            //                if (match) {
            //                    // password match
            //                    req.session.user = user.id;
            //                    res.json(user);
            //                } else {
            //                    // invalid password
            //                    if (req.session.user)
            //                        req.session.user = null;
            //                    res.json({error: 'Invalid password'}, 400);
            //                }
            //            });
            // 
            var match = (req.param('password') === user.password);
            if (!match) {
                var usernamePasswordMismatchError = {name: "usernamePasswordMismatch", message: "Неверно указан логин или пароль"};
                req.session.flash = {
                    err: [usernamePasswordMismatchError]
                };
                res.redirect('/session/new');
                return;
            }
            req.session.authenticated = true;
            req.session.User = user;
            // Change status to online
            user.online = true;
            user.save(function (err, user) {
                if (err)
                    return next(err);
                // Inform other sockets (e.g. connected sockets that are subscribed) that this user is now logged in
                User.publishUpdate(user.id, {
                    loggedIn: true,
                    id: user.id,
                    name: user.name,
                    action: ' has logged in.'
                });
////TODO: fix error redirect  
////                // If the user is also an admin redirect to the user list (e.g. /views/user/index.ejs)
////                // This is used in conjunction with config/policies.js file
////                if (req.session.User.admin) {
////                    res.redirect('/user');
////                    return;
////                }
//
//                //Redirect to their profile page (e.g. /views/user/show.ejs) 
//                res.redirect('/user/show/' + _user.id);
                return;
            });
            res.redirect('/user/show/' + user.id);
        });
        return;
    },
    destroy: function (req, res, next) {
        //https://github.com/irlnathan/activityoverlord/blob/master/api/controllers/SessionController.js
        User.findOne(req.session.User.id, function foundUser(err, user) {

            var userId = req.session.User.id;

            if (user) {
                // The user is "logging out" (e.g. destroying the session) so change the online attribute to false.
                User.update(userId, {
                    online: false
                }, function (err) {
                    if (err)
                        return next(err);

                    // Inform other sockets (e.g. connected sockets that are subscribed) that the session for this user has ended.
                    User.publishUpdate(userId, {
                        loggedIn: false,
                        id: userId,
                        name: user.name,
                        action: ' has logged out.'
                    });

                    // Wipe out the session (log out)
                    req.session.destroy();

                    // Redirect the browser to the sign-in screen
                    res.redirect('/session/new');
                });
            } else {

                // Wipe out the session (log out)
                req.session.destroy();

                // Redirect the browser to the sign-in screen
                res.redirect('/session/new');
            }
        });

    }
};


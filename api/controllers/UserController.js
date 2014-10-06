/**
 * UserController
 *
 * @description :: Server-side logic for managing users
 * @help        :: See http://links.sailsjs.org/docs/controllers
 */

module.exports = {
    /**
     * Add New User Form
     * @param {type} req
     * @param {type} res
     * @returns {undefined}
     */
    'new': function (req, res) {
        // res.locals.flash = _.clone(req.session.flash);
        res.view(null, {
            title: "Регистрация пользователя"
        });
        //req.session.flash = {};
    },
    /**
     * Create new User 
     * @param {type} req
     * @param {type} res
     * @param {type} next
     * @returns {undefined} 
     */
    create: function (req, res, next) {
        //Create User with params send from the sing-up form --> user/new.ejs 
        User.create(req.params.all(), function userCreated(err, user) {
            //  get error
            if (err) {
                //NOTE: no need see return next(err);
                console.log(err);
                // if error redirect back to form sing-up page
                req.session.flash = {
                    err: err
                };
                return res.redirect('/user/new');
            }
            // success creating the user 
            // Log usr in 
            req.session.authenticated = true;
            req.session.User = user;
            // Change status to online
            user.online = true;
            user.save(function (err, user) {
                if (err)
                    return next(err);
                // redirect to the action
                res.redirect('user/show/' + user.id);
            });
            //TODO: delete --> res.json(user);
            //TODO: delete - no need anymore --> req.session.flash = {};
        });
    },
    /**
     * Show user info
     * @param {type} req
     * @param {type} res
     * @param {type} next
     * @returns {undefined}
     */
    show: function (req, res, next) {
        console.log('-0', req.param('id'));
        User.findOne(req.param('id'), function foundUser(err, user) {
            if ((err) || (!user))
                return next(err);
            res.view(null, {
                user: user,
                title: "Пользователь - " + user.name
            });

        });

    },
    /**
     * Show list of users
     * @param {type} req
     * @param {type} res
     * @param {type} next
     * @returns {undefined}
     */
    index: function (req, res, next) {
        User.find(function foundUser(err, users) {
            if (err)
                return next(err);
            //pass the array down to the /views/index.ejs page
            res.view(null, {
                users: users,
                title: "Список пользователей"
            });
        });
    },
    /***
     * Edit User Information
     * @param {type} req
     * @param {type} res
     * @param {type} next
     * @returns {undefined}
     */
    edit: function (req, res, next) {
        User.findOne(req.param('id'), function foundUser(err, user) {
            if ((err) || (!user))
                return next(err);
            res.view({
                user: user,
                title: "Редактирование пользователь - " + user.name
            });

        });

    },
    /***
     * Update user information
     * @param {type} req
     * @param {type} res
     * @param {type} next
     * @returns {undefined}
     */
    update: function (req, res, next) {
        var param = req.params.all();

        var objData = {
            name: param["name"],
            title: param["title"],
            email: param["email"],
            admin: param["admin"],
            password: param["password"]
        };

        if (req.session.User.admin) {
            delete objData["admin"];
        } else {

        }
        User.update(req.param('id'), objData, function userUpdate(err) {
            if (err) {
                return res.redirect('/user/edit/' + req.param('id'));
            }
            res.redirect('/user/show/' + req.param('id'));
        });
    },
    /*** 
     * Delete User information
     * @param {type} req
     * @param {type} res
     * @param {type} next
     * @returns {undefined}
     */
    destroy: function (req, res, next) {
        User.findOne(req.param('id'), function (err, user) {
            if (err)
                return next(err);
            if (!user)
                return next('Пользователь не найден');
            User.destroy(req.param('id'), function userDestroyed(err) {
                if (err)
                    return next(err);
            });
            res.redirect('/user');
        });
    },
    login: function (req, res) {
        //var bcrypt = require('bcrypt');
        console.log(req.body);
        //console.log('User',User);
        User.findOneByEmail(req.body.email).exec(function (err, user) {
            //     User.findOne({ where: { email: req.body.email }}).exec(function (err, user) {     

            if (err)
                res.json({error: 'DB error'}, 500);

            if (user) {
//                bcrypt.compare(req.body.password, user.password, function (err, match) {
//                    if (err)
//                        res.json({error: 'Server error'}, 500);
//
//                    if (match) {
//                        // password match
//                        req.session.user = user.id;
//                        res.json(user);
//                    } else {
//                        // invalid password
//                        if (req.session.user)
//                            req.session.user = null;
//                        res.json({error: 'Invalid password'}, 400);
//                    }
//                });
                if (match = (req.body.password === user.password)) {
                    // password match
                    req.session.user = user;
                    res.json(user);
                } else {
                    // invalid password
                    if (req.session.user)
                        req.session.user = null;
                    res.json({error: 'Invalid password'}, 400);
                }

            } else {
                res.json({error: 'User not found'}, 404);
            }
        });
    },
    logout: function (req, res) {
        req.session.user = null;
        res.send("Successfully logged out");
    }
};


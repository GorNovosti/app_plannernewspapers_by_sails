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
            // redirect to the action
            res.json(user);
            req.session.flash = {};
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


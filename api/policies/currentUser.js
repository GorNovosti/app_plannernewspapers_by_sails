/**
 * Gets the current user from session, or returns 403
 */
module.exports = function (req, res, next) {
    console.log(req.body);
    console.log(req.session);
    // User is allowed, proceed to controller
    if (req.session.user) {
        req.body.user = req.session.user;
        return next(); 
    }

    // User is not allowed
    else {
        return res.forbidden('You are not permitted to perform this action.');//NOTE: old version: send("You are not permitted to perform this action.", 403);
    }
};

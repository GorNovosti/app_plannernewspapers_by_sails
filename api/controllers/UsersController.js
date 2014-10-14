/**
 * UsersController
 *
 * @description :: Server-side logic for managing users
 * @help        :: See http://links.sailsjs.org/docs/controllers
 */

module.exports = {
    count: function (req, res) {
        Users.count().exec(function (error, count) {
            //res.header("Access-Control-Allow-Origin:*");
            return res.json({
                count: count
            });
        });
    },
    find: function (req, res, next) {
        Users.findOne()
                .exec(function (error, data) {
                    if (error)
                        return next(error);
                    return res.json(data);
                });

    },
    index: function (req, res) {
        var page = req.param("page", 1);
        var limit = req.param("limit", 10);
        if (page && limit)
        {
            Users.count().exec(function (error, count) {
                if (!error) {
                    //res.header('X-Prism-Total-Items-Count', count);//"Access-Control-Allow-Origin:*"); 

//            return res.json({
//                count: count,
//            });
//        });
                    Users.find().populate('role').paginate({page: page, limit: limit})
                            .exec(function (_error, data) {
                                console.log(count, data);
                                res.setHeader('X-Prism-Total-Items-Count', count);//"Access-Control-Allow-Origin:*"); 
                                res.json(data);
                                return;
                            });
                }
//        else {
//            Users.find().exec(function (error, data) {
//                return res.json(data);
//            });
//        }
            });
        } else {
            return res.json([]);
        }
    },
    update: function (req, res) {
        console.log('Users update', req.params.all());
        Users.update(req.param('id'), req.params.all(), function (err, data) {
            if (err) {
                res.status(500);
                res.json(err);
                return;
            }
            Users.find().populate('role').exec(function (_error, data) {
                res.json(data[0]);
            });
        });

    },
    create: function (req, res, next) {
        var params = req.params.all();
        console.log('Users cretae', params);
        Users.create(params, function (err, data) {
            if (err)
                return next(err);
            res.status(201);
            console.log('Users was created ', data);
            res.json(data);

        });
        //res.json({"res":"oKKKK"});
    }
};


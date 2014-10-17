/**
 * ReleasenewspapersController
 *
 * @description :: Server-side logic for managing releasenewspapers
 * @help        :: See http://links.sailsjs.org/docs/controllers
 */

module.exports = {
    index: function (req, res) {
        var page = req.param("page", 1);
        var limit = req.param("limit", 10);
        if (page && limit)
        {
            Releasenewspapers.count().exec(function (error, count) {
                if (!error) {
                    Releasenewspapers.find().paginate({page: page, limit: limit})
                            .exec(function (_error, data) {
                                console.log(count, data);
                                res.setHeader('X-Prism-Total-Items-Count', count);//"Access-Control-Allow-Origin:*"); 
                                res.json(data);
                                return;
                            });
                }
            });
        } else {
            res.status(500);
            return res.json([]);
        }
    },
    update: function (req, res) {
        console.log('test', req.params.all());
        Releasenewspapers.update(req.param('id'), req.params.all(),
                function (err, data) {
                    res.json(data[0]);
                } 
        );
        //  res.json({"result": "test Ok", "name": req.param('name')});
    },
    create: function (req, res, next) {
        var params = req.params.all();
        console.log('Releasenewspapers cretae', params);
        Releasenewspapers.create(params, function (err, data) {
            if (err)
                return next(err);
            res.status(201);
            console.log('Releasenewspapers was created ', data);
            res.json(data);

        });
    }
};


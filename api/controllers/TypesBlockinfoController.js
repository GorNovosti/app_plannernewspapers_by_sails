/**
 * TypesBlockinfoController
 *
 * @description :: Server-side logic for managing Typesblockinfoes - Типы информационных блоков 
 * @help        :: See http://links.sailsjs.org/docs/controllers
 */

module.exports = {
    index: function (req, res) {
        var page = req.param("page", 1);
        var limit = req.param("limit", 10);
        if (page && limit)
        {
            TypesBlockinfo.count().exec(function (error, count) {
                if (!error) {
                    TypesBlockinfo.find().paginate({page: page, limit: limit})
                            .exec(function (_error, data) {
                                console.log(count, data);
                                res.setHeader('X-Prism-Total-Items-Count', count);//"Access-Control-Allow-Origin:*"); 
                                res.json(data);
                                return;
                            });
                }
            });
        } else {
            return res.json([]);
        }
    },
    update: function (req, res) {
        console.log('Users update', req.params.all());
        var param = req.params.all();

        TypesBlockinfo.update(req.param('id'), req.params.all(), function (err, data) {
            if (err) {
                res.status(500);
                res.json(err);
                return;
            }
            TypesBlockinfo.find({id: req.param('id')}).limit(1).exec(function (_error, data) {
                res.json(data[0]);
            });
        });

    },
    create: function (req, res, next) {
        var params = req.params.all();
        console.log('TypesBlockinfo cretae', params);
        TypesBlockinfo.create(params, function (err, data) {
            if (err)
                return next(err);
            res.status(201);
            console.log('TypesBlockinfo was created ', data);
            res.json(data);

        }); 
    }
};


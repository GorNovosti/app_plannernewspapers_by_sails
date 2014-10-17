/**
 * BlockinfoController
 *
 * @description :: Server-side logic for managing Blockinfoes
 * @help        :: See http://links.sailsjs.org/docs/controllers
 */

module.exports = {
    index: function (req, res) {
        var page = req.param("page", 1);
        var limit = req.param("limit", 10);
        if (page && limit)
        {
            Blockinfo.count().exec(function (error, count) {
                if (!error) {
                    Blockinfo.find().paginate({page: page, limit: limit})
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
        console.log('Users update', req.params.all());
        var param = req.params.all();

        Blockinfo.update(req.param('id'), req.params.all(), function (err, data) {
            if (err) {
                res.status(500);
                res.json(err);
                return;
            }
            Blockinfo.find({id: req.param('id')}).limit(1).exec(function (_error, data) {
                res.json(data[0]);
            });
        });

    },
    create: function (req, res, next) {
        var params = req.params.all();
        console.log('Blockinfo cretae', params);
        Blockinfo.create(params, function (err, data) {
            if (err)
                return next(err);
            res.status(201);
            console.log('Blockinfo was created ', data);
            res.json(data);

        });
    }
};


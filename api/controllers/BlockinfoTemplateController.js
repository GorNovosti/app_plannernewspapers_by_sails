/**
 * BlockinfoTemplateController
 *
 * @description :: Server-side logic for managing Blockinfotemplates
 * @help        :: See http://links.sailsjs.org/docs/controllers
 */
module.exports = {
    index: function (req, res) {
        var page = req.param("page", 1);
        var limit = req.param("limit", 10);
        if (page && limit)
        {
            BlockinfoTemplate.count().exec(function (error, count) {
                if (!error) {
                    BlockinfoTemplate.find().paginate({page: page, limit: limit})
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
    find: function (req, res, next) {
        BlockinfoTemplate.findOne()
                .exec(function (error, data) {
                    if (error)
                        return next({raw: error});
                    return res.json(data);
                });

    },
    update: function (req, res) {
        console.log('Users update', req.params.all());
        var param = req.params.all();

        BlockinfoTemplate.update(req.param('id'), req.params.all(), function (err, data) {
            if (err) {
                res.status(500);
                res.json(err);
                return;
            }
            BlockinfoTemplate.find({id: req.param('id')}).limit(1).exec(function (_error, data) {
                res.json(data[0]);
            });
        });

    },
    create: function (req, res, next) {
        var params = req.params.all();
        console.log('BlockinfoTemplate cretae', params);
        BlockinfoTemplate.create(params, function (err, data) {
            if (err)
                return next(err);
            res.status(201);
            console.log('BlockinfoTemplate was created ', data);
            res.json(data);

        });
    }, /*** 
     * Delete BlockinfoTemplate  
     * @param {type} req
     * @param {type} res
     * @param {type} next
     * @returns {undefined}
     */
    destroy: function (req, res, next) {
        BlockinfoTemplate.findOne(req.param('id'), function (err, data) {
            if (err)
                return next(err);
            return BlockinfoTemplate.destroy(req.param('id'), function (err) {
                if (err)
                    return next(err);
                res.status(200);  
                return res.json('ok');
            });             
        });
    }
};


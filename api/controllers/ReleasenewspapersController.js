/**
 * ReleasenewspapersController
 *
 * @description :: Server-side logic for managing releasenewspapers
 * @help        :: See http://links.sailsjs.org/docs/controllers
 */

module.exports = {
    //  list:
    update: function (req, res) {
        console.log('test', req.param('name'));
        Releasenewspapers.update(req.param('id'),req.params.all(),
            function(err,data){
                res.json(data[0]); 
            }
        
        );
      //  res.json({"result": "test Ok", "name": req.param('name')});
    }
};


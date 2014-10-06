/**
 * NewspapersController
 *
 * @description :: Server-side logic for managing newspapers
 * @help        :: See http://links.sailsjs.org/docs/controllers
 */

module.exports = {
    /**
     * 
     * @param {type} req
     * @param {type} res
     * @param {type} next
     * @returns {undefined}
     */
    
    index: function (req, res,next) {
        Newspapers.find(function(err, newspapers) {
            if (err)
                return next(err);
            //pass the array down to the /views/index.ejs page
            res.view({
                newspapers: newspapers,
                title: "Список выпусков(номеров) газет"
            });
        });
    },
    
    add: function (req, res) {
        res.view(null, {
            title: "Добавление выпуск(номер) газеты"
        });
    }
};


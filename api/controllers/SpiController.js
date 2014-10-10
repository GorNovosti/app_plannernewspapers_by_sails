/**
 * SpiController
 *
 * @description :: Server-side logic for managing spis
 * @help        :: See http://links.sailsjs.org/docs/controllers
 */

module.exports = {
    index: function (req, res) {
        res.view('spi/index', {
            page_name: "newspapers"
        });
    }
};


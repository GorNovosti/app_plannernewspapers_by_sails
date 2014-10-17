/**
 * TypesBlockinfo.js
 *
 * @description :: TODO: You might write a short summary of how this model works and what it represents here.
 * @docs        :: http://sailsjs.org/#!documentation/models
 */

module.exports = {
    attributes: {
        name: {
            type: "string"
        },
        width: {
            type: "integer",
            defaultsTo: 200
        },
        height: {
            type: "integer",
            defaultsTo: 200
        },
        blocksinfo:{
            collection:'Blockinfo',
            via:"owner"
        }
    }
};


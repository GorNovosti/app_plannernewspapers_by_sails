/**
* Blocks.info.js
*
* @description :: TODO: You might write a short summary of how this model works and what it represents here.
* @docs        :: http://sailsjs.org/#!documentation/models
*/

module.exports = {
    connection: 'someMongodbServer',
    attributes: {
        name:{
            type:"String"
        },
        typeBlockId:{
            type:"integer",
            enum:[1,2,3,4]            
        }
   

  }
};

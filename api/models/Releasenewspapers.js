/**
* Releasenewspapers.js
*
* @description :: TODO: You might write a short summary of how this model works and what it represents here.
* @docs        :: http://sailsjs.org/#!documentation/models
*/

module.exports = {
  connection: 'someMongodbServer',
  
  attributes: {
      name:{
          type:"string"
      },
      pagesCount:{
          type:"integer",
          defaultsTo: 1
      }
//      ,
//      pages:{
//          collection: 'pagesnewspapers',
//          via:'newspaper'
//      }
  }
};


const mongoose = require("mongoose");


const noteSchema = new mongoose.Schema({
    title : {
        type : String ,
        required : true,
    },

    incidents : {
        type : String,
        required : true
    },
    createdAt : {
        type : String,
        required : true
    },
    userId : {
        type : String,
        required : true
    }

});


module.exports = mongoose.model('notes',noteSchema);
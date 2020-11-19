const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const History = Schema({
  username: String, //buyer
  seller:String, //seller
  buyer: String,
  title: String,//name of items
  stock : Number,//number of want-to-buy item
  body: String,//description of item
  address : String,//address of buyer
  district: {
    type: String,
    default: "District 1"
  },
  time:Date,// buyer press button buy
  selled: {
      type:Boolean,
      default: false
      },
  status: String ,
  telephone: String
});

module.exports = mongoose.model("History", History);
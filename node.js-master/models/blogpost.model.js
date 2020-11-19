const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const BlogPost = Schema({
  username: String,
  title: String,//name of item
  body: String,//description
  sex: String,
  price: Number,
  color : {
    default: "none",
    type: String
  },
  size: {
    default: "none",
    type: String
  },
  stock: Number,
  material: String,
  hastag : {
    type: Array,
    default: []
  },
  image: {
    type: Array,
    default: []
  },
  district: {
    default: "District 1",
    type: String
  },
  lat: {
    type: Number,
    default: 0
  },
  lng:{
    type: Number,
    default: 0
  },
  address: {
    type: String,
    default: ""
  }
});

module.exports = mongoose.model("BlogPost", BlogPost);
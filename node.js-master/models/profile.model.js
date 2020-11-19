const mongoose = require("mongoose");

const Schema = mongoose.Schema;

const Profile = Schema(
  {
    username: {
      type: String,
      required: true,
      unique: true,
    },
    phone: Number,
    name: String,
    profession: String,
    DOB: String,
    titleline: String,
    about: String,
    hastag: {
      default: [],
      type: Array
    },
    img: {
      type: String,
      default: "",
    },
  },
  {
    timestamp: true,
  }
);

module.exports = mongoose.model("Profile", Profile);
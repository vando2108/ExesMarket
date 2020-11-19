const express = require("express");
const router = express.Router();
const History = require("../models/history.model");
const middleware = require("../middleware");
const multer = require("multer");

router.route("/add").post(middleware.checkToken, (req, res) => {
    const history = History({
      username: req.decoded.username,
      buyer: req.decoded.username ,
      seller: req.body.seller,
      title: req.body.title,
      body: req.body.body,
      stock: req.body.stock,
      address: req.body.address,
      district: req.body.district,
      time: req.body.time,
      selled: req.body.selled,
      status: req.body.status, //buy
      telephone: req.body.telephone
    });
    history.save().then((result) => {
      return res.json({ msg: "Item has been add successfully to history database", data: result });
    }).catch((err) => {
      console.log(err);
      return res.json({ err: err });
    });
  });

  router.route("/addSellUser").post(middleware.checkToken, (req, res) => {
    const history = History({
      username: req.body.seller,
      seller: req.body.seller,
      buyer: req.decoded.username,
      title: req.body.title,
      body: req.body.body,
      stock: req.body.stock,
      address: req.body.address,
      district: req.body.district,
      time: req.body.time,
      selled: req.body.selled,
      status: req.body.status,
      telephone: req.body.telephone
    });
    history.save().then((result) => {
      return res.json({ msg: "Item has been add successfully to history database", data: result });
    }).catch((err) => {
      console.log(err);
      return res.json({ err: err });
    });
  });

//get all of your history, based on buy or sell (status).this would be displayed in your wall account
router.route("/getAllBuy").post(middleware.checkToken, (req, res) => {
    History.find({ $and : [{username: req.decoded.username}, {status: req.body.status}] }, (err, result) => {
      if (err) return res.json(err);
      else {
        return res.json({ data: result });
      }
    });
  });

//update item (from seller)
router.route("/update/:id").patch(middleware.checkToken, async (req, res) => {
    let history = {};
    await History.findOne({$and: [{ username: req.decoded.username }, { _id: req.params.id }] }, (err, result) => {
      if (err) {
        history = {};
      }
      if (result != null) {
        history = result;
      }
    });
    History.findOneAndUpdate(
      
      { $and: [{ username: req.decoded.username }, { _id: req.params.id }] },
      {
        $set: {
          title: req.body.title ? req.body.title : history.title,
          body: req.body.body ? req.body.body : history.body,
          address: req.body.address ? req.body.address : history.address,
          district: req.body.district ? req.body.district : history.district,
          status: req.body.status ? req.body.status : history.status,
          selled : req.body.selled ? req.body.selled : history.selled
        },
      },
      { new: true },
      (err, result) => {
        if (err) return res.json({ err: err });
        if (result == null) return res.json({ data: [] });
        else return res.json({ data: result });
      }
    );
  });

module.exports = router;
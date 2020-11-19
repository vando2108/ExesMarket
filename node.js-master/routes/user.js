const express = require("express");
const User = require("../models/users.model");
const config = require("../config");
const jwt =  require("jsonwebtoken");
const router = express.Router();
const middleware = require("../middleware");


router.route("/:username").get((req,res) =>{
    User.findOne({username: req.params.username}, (err, result)=> {
        if (err) return res.status(500).json({msg: err});
        else res.json(
            {
                data: result,
                username: req.params.username,
            }
        );
    });
});

router.route("/checkusername/:username").get((req, res) => {
    User.findOne({ username: req.params.username }, (err, result) => {
      if (err) return res.status(500).json({ msg: err });
      if (result !== null) {
        return res.json({
          Status: true,
        });
      } else
        return res.json({
          Status: false,
        });
    });
  });

router.route("/login").post((req, res) =>{
    User.findOne({username: req.body.username}, (err, result)=> {
        if (err) return res.status(500).json({msg: err});
        if (result == null){
            return res.status(403).json("Username incorrect");
        }
        if (result.password == req.body.password){
            let token = jwt.sign({username: req.body.username}, config.key, {});

            return res.status(200).json({token: token, msg:"Ok"});
        }
        else{
            return res.status(403).json("password is incorrect");
        }
    });
});

router.route("/register").post((req, res) => {
    
    const user = new User({
        username: req.body.username,
        password: req.body.password,
        email: req.body.email,
    });
    user
    .save()
    .then(() => {
      return res.json({ msg: "profile successfully stored" });
    })
    .catch((err) => {
      return res.status(400).json({ err: err });
    });
});

router.route("/update/:username").patch((req, res) => {
    User.findOneAndUpdate(
        { username: req.params.username },
        { $set: { password: req.body.password } },
        (err, result) => {
            if (err) return res.status(500).json({ msg: err });
            const mag = {
                msg: "password successfully updated",
                username: req.params.username,
            };
            return res.json(msg);
        }
    );
});

router.route("/delete/:username").delete((req, res) => {
    User.findOneAndDelete({ username: req.params.username },
        (err, result) => {
            if (err) return res.status(500).json({ msg: err });
            const msg = {
                msg: "username deleted",
                username: req.params.username
            };
            return res.json(msg);
        }
    );
});
module.exports = router;
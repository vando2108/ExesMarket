const express = require("express");
const router = express.Router();
const BlogPost = require("../models/blogpost.model");
const middleware = require("../middleware");
const multer = require("multer");

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "./uploads");
  },
  filename: (req, file, cb) => {
    cb(null, req.params.id + ".jpg");
  },
});

const upload = multer({
  storage: storage,
  limits: {
    fileSize: 1024 * 1024 * 6,
  },
});

router
  .route("/add/coverImage/:id")
  .patch(middleware.checkToken, upload.single("img"), (req, res) => {
    BlogPost.findOneAndUpdate(
      { _id: req.params.id },
      {
        $set: {
          coverImage: req.file.path,
        },
      },
      { new: true },
      (err, result) => {
        if (err) return res.json(err);
        return res.json(result);
      }
    );
  });
router.route("/Add").post(middleware.checkToken, (req, res) => {
  const blogpost = BlogPost({
    username: req.decoded.username,
    title: req.body.title,
    body: req.body.body,
    color: req.body.color,
    hastag: req.body.hastag,
    image: req.body.image,
    size: req.body.size,
    stock: req.body.stock,
    material: req.body.material,
    sex: req.body.sex,
    price: req.body.price,
    district: req.body.district,
    lat: req.body.lat,
    lng: req.body.lng,
    address: req.body.address
  });
  blogpost.save().then((result) => {
    return res.json({ msg: "Product successfully stored", data: result });
  }).catch((err) => {
    console.log(err);
    return res.json({ err: err });
  });
});

router.route("/update/:id").patch(middleware.checkToken, async (req, res) => {
  let blogpost = {};
  await BlogPost.findOne({$and: [{ username: req.decoded.username }, { _id: req.params.id }] }, (err, result) => {
    if (err) {
      blogpost = {};
    }
    if (result != null) {
      blogpost = result;
    }
  });
  BlogPost.findOneAndUpdate(
    
    { $and: [{ username: req.decoded.username }, { _id: req.params.id }] },
    {
      $set: {
        title: req.body.title ? req.body.title : blogpost.title,
        body: req.body.body ? req.body.body : blogpost.body,
        color: req.body.color ? req.body.color : blogpost.color,
        size: req.body.size ? req.body.size : blogpost.size,
        stock: req.body.stock ? req.body.stock : blogpost.stock,
        hastag: req.body.hastag ? req.body.hastag : blogpost.hastag, 
        image: req.body.image ? req.body.image : blogpost.image,
        material: req.body.material ? req.body.material : blogpost.material,
        price: req.body.price ? req.body.price : blogpost.price,
        sex: req.body.sex ? req.body.sex : blogpost.sex,
        lat: req.body.lat ? req.body.lat : blogpost.lat,
        lng: req.body.lng ? req.body.lng : blogpost.lng,
        address: req.body.address ? req.body.address : blogpost.address,
        district: req.body.district ? req.body.district : blogpost.district,

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

router.route("/getAll").get(middleware.checkToken, (req, res) => {
  BlogPost.find((err, result) => {
    if (err) return res.json(err);
    else {
      return res.json({ data: result });
    }
  });
});

//get all of your blog post.this would be displayed in your wall account
router.route("/getOwnBlog").get(middleware.checkToken, (req, res) => {
  BlogPost.find({ username: req.decoded.username }, (err, result) => {
    if (err) return res.json(err);
    else {
      return res.json({ data: result });
    }
  });
});

//get all of your post base on district
router.route("/getSome").post(middleware.checkToken, (req, res) => {
  BlogPost.find({ district : req.body.district }, (err, result) => {
    if (err) return res.json(err);
    else {
      return res.json({ data: result });
    }
  });
});

function find(lat1, lon1, lat2, lon2) {
  const R = 6371e3; // metres
  const φ1 = lat1 * Math.PI/180; // φ, λ in radians
  const φ2 = lat2 * Math.PI/180;
  const Δφ = (lat2-lat1) * Math.PI/180;
  const Δλ = (lon2-lon1) * Math.PI/180;

  const a = Math.sin(Δφ/2) * Math.sin(Δφ/2) +
          Math.cos(φ1) * Math.cos(φ2) *
          Math.sin(Δλ/2) * Math.sin(Δλ/2);
  const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));

  const d = R * c; // in metres
  return d;
}
//get some with distance
router.route("/getSome/Distance").post(middleware.checkToken, (req, res) => {
  BlogPost.find({ district : req.body.district }, (err, result) => {
    if (err) return res.json(err);
    else {
      var distance = req.body.distance;
      var lat =  req.body.lat;
      var lng =  req.body.lng;
      var mylist = [];
      for (var i = 0; i < result.length; i++) {
        if (find(lat, lng, result[i].lat, result[i].lng) <= distance*distance ){
          mylist.push(result[i]);
        }
      }
      return res.json({ data: mylist });
    }
  });
});

//get all of your post base on interest
router.route("/getSomeFun").post(middleware.checkToken, (req, res) => {
  BlogPost.find({ hastag : req.body.hastag }, (err, result) => {
    if (err) return res.json(err);
    else {
      return res.json({ data: result });
    }
  });
});

router.route("/getSomeFunny").post(middleware.checkToken, (req, res) => {
  BlogPost.find({ sex : req.body.sex }, (err, result) => {
    if (err) return res.json(err);
    else {
      return res.json({ data: result });
    }
  });
});

//get blogs not yours
router.route("/getOtherBlog").get(middleware.checkToken, (req, res) => {
  BlogPost.find({ username: { $ne: req.decoded.username } }, (err, result) => {
    if (err) return res.json(err);
    else {
      console.log(result);
      return res.json({ data: result });
    }
  });
});

//get a specific store / user
router.route("/getOne").post(middleware.checkToken, (req, res) => {
  BlogPost.find({username: req.body.username}, (err, result) => {
    if (err) return res.json(err);
    else {
      console.log(result);
      return res.json({ data: result });
    }
  });
});

//delete a post 
router.route("/delete/:id").delete(middleware.checkToken, (req, res) => {
  BlogPost.findOneAndDelete(
    {
      $and: [{ username: req.decoded.username }, { _id: req.params.id }],
    },
    (err, result) => {
      if (err) return res.json(err);
      else if (result) {
        console.log(result);
        return res.json({msg: "item deleted", data: result});
      }
      return res.json("item not deleted");
    }
  );
});

module.exports = router;
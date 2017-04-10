var Post = require('../models/post');
var User = require('../models/user');
var express = require('express');
var router = express.Router();

var multer = require('multer');
var fs = require('fs');
var path = require('path');

var storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, __dirname +'/uploads')
  },
  filename: function (req, file, cb) {
    cb(null, file.originalname)
  }
})
var upload = multer({ storage: storage })

// get feed which have all posts 
router.route('/feeds').get(function (req, res) {
    Post.find(function(err, feeds) {
        if (err) {
            return res.send(err);
        }
        res.send({ "feeds": feeds } );
    });
});

//Add post
router.route('/post')
    .post(function(req, res) {
        var newPost = new Post();
        newPost.user = req.body.user;
        newPost.photoId = req.body.photoId;
        newPost.createdAt = req.body.createdAt;
        newPost.isLiked = req.body.isLiked;
        newPost.likeCount = req.body.likeCount;
        newPost.message = req.body.message;
        newPost.save(function(err) {
            if (err) {
                return res.send(err);
            }
            res.send({ message: 'Post Added' });
        });
    });

router.route('/post/:id', function(req, res) {
    res.send(req.params.id);
});

router.route('/user/register').post(function(req, res) {
    // 중복 유저 검사
    User.find({email: req.body.email}, function(err, user) {
        if (err) {
            return res.send({ message: 'error'});
        }
        console.log("user", user.length);
        if (user.length > 0) {
            return res.send({message: 0});
        } else {
            var newUser = new User();
            newUser.email = req.body.email;
            newUser.password = req.body.password;
            newUser.profilePhoto = req.body.profilePhoto;
            newUser.save(function(err) {
                if (err) {
                    return res.send({ message: 'Error' });
                }
                res.send({ message: 1 });
            });
        }
    });
    // todo: 중복 유저에 대한 대응 
});

router.route('/user/login').post(function(req, res) {
    User.find({email: req.body.email, password: req.body.password}, function(err, user) {
        if (err) {
            return res.send({ message: 'error'});
        }
        if (user.length == 1) {
            return res.send({message: 1});
        } else {
            return res.send({message: 0});
        }
    });
});

module.exports = router;
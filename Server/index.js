var express = require('express');
var bodyParser = require('body-parser');
var mongoose = require('mongoose');
var routes = require('./routes');
var morgan = require('morgan');
var uuid = require('uuid');
var aws = require('aws-sdk');
var multer = require('multer');
var fs = require('fs');
var path = require('path');

var Post = require('./models/post');

var config = require('./config');

var s3 = new aws.S3();
s3.config.update({accessKeyId: config.accessKeyId, secretAccessKey: config.secretAccessKey});

function getSignedURL(req, res, next) {
  var params = {
    Bucket: 'tnv-bucket',
    Key: uuid.v4(),
    Expires: 100,
    ContentType: 'image/jpeg'
  };
  s3.getSignedUrl('putObject', params, function(err, signedURL) {
    if (err) {
      console.log(err);
      return next(err);
    } else {
      return res.json({postURL: signedURL, getURL: signedURL.split("?")[0]});
    }
  });
}

var app = express()
var router = express.Router();

router.route('')
// connect to our database
var connectionString = 'mongodb://localhost:27017/tnv';
mongoose.connect(connectionString);

app.use(bodyParser.json())
app.use(bodyParser.urlencoded({ extended: true}));
app.use('/api', routes);

app.use(express.static('uploads')) // /snape.jpg

var storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, __dirname +'/uploads')
  },
  filename: function (req, file, cb) {
    cb(null, Date.now() + path.extname(file.originalname))
  }
})
var upload = multer({ storage: storage })

app.post('/api/upload', upload.single('image'), function(req, res, next) {
  if (req.file) {
    console.log(req.body);
    // return res.end(req.file.filename);
    return res.json({"ok": req.file.filename})
  }
  res.sendStatus(404);
});

module.exports = app;

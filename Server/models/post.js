var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var postSchema = new Schema({
    user: String,
    photoId: String,
    createdAt: String,
    isLiked: Boolean,
    likeCount: Number,
    message: String
});

module.exports = mongoose.model('Post', postSchema);
var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var userSchema = new Schema({
    email: String,
    password: String,
    profilePhoto: String
});

module.exports = mongoose.model('User', userSchema);
// * id: UUID
// * email: String
// * password: String
// * profilePhoto: String
const mongoose = require('mongoose');

const espSchema = new mongoose.Schema({
    name: String,
    drySoil: Number,
});

module.exports = espSchema;
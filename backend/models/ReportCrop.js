const mongoose = require('mongoose');

const reportCropSchema = new mongoose.Schema({
    description: String,
    date: String,
    value: Number
  });

  module.exports = reportCropSchema;
const mongoose = require('mongoose');

const reportIrrigationSchema = new mongoose.Schema({
    description: String,
    date: String,
    cropUsed: String,
    waterSpended: Number,
    energySpended: Number,
    nutrientSpended: Number,
    totalSpended: Number
  });

  module.exports = reportIrrigationSchema;
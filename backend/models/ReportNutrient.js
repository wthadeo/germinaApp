const mongoose = require('mongoose');

const reportNutrientSchema = new mongoose.Schema({
    description: String,
    date: String,
    value: Number
  });

  module.exports = reportNutrientSchema;
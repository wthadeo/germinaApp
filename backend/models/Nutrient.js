const mongoose = require('mongoose');

const nutrientSchema = new mongoose.Schema({
    name: String,
    price: Number,
    totalAmount: Number,
    buysNutrient: [{
      quantAdd: Number,
      price: Number,
      date: String
    }]
  });

  module.exports = nutrientSchema;
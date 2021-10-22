const mongoose = require('mongoose');

const nutrientSchema = new mongoose.Schema({
    name: String,
    price: Number,
    totalAmount: Number,
  });

  module.exports = nutrientSchema;
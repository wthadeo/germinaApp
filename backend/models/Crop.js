const mongoose = require('mongoose');

const cropSchema = new mongoose.Schema({
    name: String,
    age: String,
    qntOfPlants: Number,
    isActive: Boolean,
    notesCrop: [{
        name: String,
        description: String,
        date: String
    }]
  });

  module.exports = cropSchema;
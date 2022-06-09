const mongoose = require('mongoose');

const cropSchema = new mongoose.Schema({
    name: String,
    dateOfCreation: String,
    age: String,
    qntOfPlants: Number,
    costOfCrop: Number,
    isActive: Boolean,
    notesCrop: [{
        name: String,
        description: String,
        date: String
    }]
  });

  module.exports = cropSchema;
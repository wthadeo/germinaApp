const mongoose = require('mongoose');

const irrigationSchema = new mongoose.Schema({
  name: String,
  dateOfCreation: String,
  startHour: String,
  timeToUse: Number,
  waterPrice: Number,
  flowRate: Number,
  energyPrice: Number,
  crop:
    [{
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
    }],
  device: [{
    name: String,
    uri: String,
    protocol: String,
    sensors: [{
      name: String,
      protocol: String,
      uri: String,
      category: String
    }],
    longitude: String,
    latitude: String
  }],
  nutrient: [{
    name: String,
    price: Number,
    totalAmount: Number,
    buysNutrient: [{
      quantAdd: Number,
      price: Number,
      date: String
    }]
  }],
  state: Boolean,
  isFinished: Boolean,
  listOfNotifications: [{
    notification: String,
    description: String,
    date: String
  }]
});

module.exports = irrigationSchema;
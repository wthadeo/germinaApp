const mongoose = require('mongoose');

const irrigationSchema = new mongoose.Schema({
  name: String,
  startHour: Number,
  startMinutes: Number,
  timeToUse: Number,
  flowRate: Number,
  energy: Number,
  crop:
    [{
      name: String,
      age: String,
      qntOfPlants: Number,
      isActive: Boolean,
      notesCrop: [{
          name: String,
          description: String,
          date: String
      }]
    }],
  sensor: [{
    name: String,
    protocol: String,
    uri: String,
    category: String
  }],
  nutrient: [{
    name: String,
    price: Number,
    totalAmount: Number,
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
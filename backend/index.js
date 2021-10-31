const express = require('express');
const cors = require('cors');
const app = express();
const mongoose = require('mongoose');
const nutrientModel = require('./models/Nutrient');
const cropModel = require('./models/Crop');
const irrigationModel = require('./models/Irrigation');

mongoose.connect('mongodb://localhost:27017/germina').then(() => {
    console.log('Database connected');
});

const Nutrient = mongoose.model('Nutrient', nutrientModel);
const Crop = mongoose.model('Crop', cropModel);
const Irrigation = mongoose.model('Irrigation', irrigationModel);

app.use(cors());
app.use(express.urlencoded())
app.use(express.json());

app.get('/nutrients', (req, res) => {
    Nutrient.find().then(nutrients => {
        res.json(nutrients);
    }).catch(error => {
        res.send('Erro ao carregar os dados');
    });
});

app.post('/nutrients', (req, res) => {
    console.log(req.body);
    let name = req.body.name;
    let price = req.body.price;
    let totalAmount = req.body.totalAmount;

    let newNutrient = new Nutrient({
        name, price, totalAmount
    });

    newNutrient.save().then(response => {
        res.send('OK 200');
    }).catch(error => {
        console.log(error);
        res.send('Erro: ' + error);
    });
});

app.put('/nutrients', (req, res) => {

});

app.get('/crops', (req, res) => {
    Crop.find().then(crops => {
        res.json(crops);
    }).catch(error => {
        res.send('Erro ao carregar os dados');
    });
});

app.post('/crops', (req, res) => {
    let name = req.body.name;
    let age = req.body.age;
    let qntOfPlants = req.body.qntOfPlants;
    let isActive = req.body.isActive;
    let notesCrop = req.body.notesCrop;

    let newCrop = new Crop({
        name, age, qntOfPlants, isActive, notesCrop
    });

    newCrop.save().then(response => {
        res.send('OK 200');
    }).catch(error => {
        console.log(error);
        res.send('Erro: ' + error);
    });
});

app.get('/irrigations', (req, res) => {
    Irrigation.find().then(irrigations => {
        res.json(irrigations);
    }).catch(error => {
        res.send('Erro ao carregar os dados');
    });
});

app.post('/irrigations', (req, res) => {
    console.log(req.body);
    let name = req.body.name;
    let startHour = req.body.startHour;
    let startMinutes = req.body.startMinutes;
    let timeToUse = req.body.timeToUse;
    let flowRate = req.body.flowRate;
    let energy = req.body.energy;
    let crop = req.body.crop;
    let sensor = req.body.sensor;
    let nutrient = req.body.nutrient;
    let state = req.body.state;
    let listOfNotifications = req.body.listOfNotifications;

    let newIrrigation = new Irrigation({
        name,
        startHour,
        startMinutes,
        timeToUse,
        flowRate,
        energy,
        crop,
        sensor,
        nutrient,
        state,
        listOfNotifications
    });

    newIrrigation.save().then(response => {
        res.send('OK 200');
    }).catch(error => {
        console.log(error);
        res.send('Erro: ' + error);
    });
});

app.listen(3000, () => console.log('Server rodando'));
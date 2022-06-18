/*const express = require('express');
const router = express.Router();

const mongoose = require('mongoose');
const nutrientModel = require('../models/Nutrient');
const cropModel = require('../models/Crop');
const irrigationModel = require('../models/Irrigation');
const reportCropModel = require('../models/ReportCrop');
const reportNutrientModel = require('../models/ReportNutrient');
const reportIrrigationModel = require('../models/ReportIrrigation');
const espModel = require('../models/Esp');

mongoose.connect('mongodb://localhost:27017/germina').then(() => {
    console.log('Database connected');
});

const Nutrient = mongoose.model('Nutrient', nutrientModel);
const Crop = mongoose.model('Crop', cropModel);
const Irrigation = mongoose.model('Irrigation', irrigationModel);
const ReportCrop = mongoose.model('ReportCrop', reportCropModel);
const ReportNutrient = mongoose.model('ReportNutrient', reportNutrientModel);
const ReportIrrigation = mongoose.model('ReportIrrigation', reportIrrigationModel);
const Esp = mongoose.model('Esp', espModel);


router.get('/esp32', (req, res)=>{
    Esp.find().then(esp => {
        res.json(esp);
    }).catch(error => {
        res.send('Erro ao carregar os dados');
    });
});

router.post('/esp32', (req, res) => {
    console.log(req.body);
    let name = req.body.name;
    let drySoil = req.body.drySoil;

    let newEsp = new Esp({
        name, drySoil
    });

    newEsp.save().then(response => {
        res.send('OK 200');
    }).catch(error => {
        console.log(error);
        res.send('Erro: ' + error);
    });
});

router.put('/esp32', (req, res) => {
    console.log(req.body);
    Esp.findOne({name: req.body.name}).then(esp=>{
        esp.drySoil = req.body.drySoil;
        esp.save();
        res.send(esp);
    }).catch(error => {
        res.send('Erro ao carregar o cultivo');
    });
});

router.get('/nutrients', (req, res) => {
    Nutrient.find().then(nutrients => {
        res.json(nutrients);
    }).catch(error => {
        res.send('Erro ao carregar os dados');
    });
});

router.post('/nutrients', (req, res) => {
    console.log(req.body);
    let name = req.body.name;
    let price = req.body.price;
    let totalAmount = req.body.totalAmount;
    let buysNutrient = req.body.buysNutrient;

    let newNutrient = new Nutrient({
        name, price, totalAmount, buysNutrient
    });

    newNutrient.save().then(response => {
        res.send('OK 200');
    }).catch(error => {
        console.log(error);
        res.send('Erro: ' + error);
    });
});

router.put('/nutrients', (req, res) => {
    console.log(req.body);
    Nutrient.findOne({name: req.body.name}).then(nutrient=>{
        nutrient.price = req.body.price;
        nutrient.totalAmount = req.body.totalAmount;
        nutrient.buysNutrient = req.body.buysNutrient;
        nutrient.save();
        res.send(nutrient);
    }).catch(error => {
        res.send('Erro ao carregar o cultivo');
    });
});

router.put('/crops/conclude', (req, res) => {
    Crop.findOne({name: req.body.name}).then(crop=>{
        crop.isActive = false;
        crop.save();
        res.send(crop);
    }).catch(error => {
        res.send('Erro ao carregar o cultivo');
    });
});

router.put('/crops/addNote', (req, res) => {
    Crop.findOne({name: req.body.name}).then(crop=>{
        crop.notesCrop = req.body.notesCrop;
        crop.save();
        res.send(crop);
    }).catch(error => {
        res.send('Erro ao carregar o cultivo');
    });
});

router.put('/crops/changeValue', (req, res) => {
    console.log(req.body);
    Crop.findOne({name: req.body.name}).then(crop=>{
        crop.costOfCrop = req.body.costOfCrop;
        crop.save();
        res.send(crop);
    }).catch(error => {
        res.send('Erro ao carregar o cultivo');
    });
});

router.get('/crops', (req, res) => {
    Crop.find().then(crops => {
        res.json(crops);
    }).catch(error => {
        res.send('Erro ao carregar os dados');
    });
});

router.post('/crops', (req, res) => {
    let name = req.body.name;
    let dateOfCreation = req.body.dateOfCreation;
    let age = req.body.age;
    let qntOfPlants = req.body.qntOfPlants;
    let costOfCrop = req.body.costOfCrop;
    let isActive = req.body.isActive;
    let notesCrop = req.body.notesCrop;

    let newCrop = new Crop({
        name, dateOfCreation, age, qntOfPlants, costOfCrop, isActive, notesCrop
    });

    newCrop.save().then(response => {
        res.send('OK 200');
    }).catch(error => {
        console.log(error);
        res.send('Erro: ' + error);
    });
});

router.get('/irrigations', (req, res) => {
    Irrigation.find().then(irrigations => {
        res.json(irrigations);
    }).catch(error => {
        res.send('Erro ao carregar os dados');
    });
});

router.post('/irrigations', (req, res) => {
    let name = req.body.name;
    let dateOfCreation = req.body.dateOfCreation;
    let startHour = req.body.startHour;
    let timeToUse = req.body.timeToUse;
    let waterPrice = req.body.waterPrice;
    let flowRate = req.body.flowRate;
    let energyPrice = req.body.energyPrice;
    let crop = req.body.crop;
    let device = req.body.device;
    let nutrient = req.body.nutrient;
    let state = req.body.state;
    let isFinished = req.body.isFinished;
    let listOfNotifications = req.body.listOfNotifications;

    let newIrrigation = new Irrigation({
        name,
        dateOfCreation,
        startHour,
        timeToUse,
        waterPrice,
        flowRate,
        energyPrice,
        crop,
        device,
        nutrient,
        state,
        isFinished,
        listOfNotifications
    });

    newIrrigation.save().then(response => {
        res.send('OK 200');
    }).catch(error => {
        console.log(error);
        res.send('Erro: ' + error);
    });
});

//################################## REPORTS #################################################

router.get('/reportCrop', (req, res) => {
    ReportCrop.find().then(reportCrop => {
        res.json(reportCrop);
    }).catch(error => {
        res.send('Erro ao carregar os dados');
    });
});

router.post('/reportCrop', (req, res)=>{
    let description = req.body.description;
    let date = req.body.date;
    let value = req.body.value;

    let newReportCrop = new ReportCrop({
        description, date, value
    });

    newReportCrop.save().then(response => {
        res.send('OK 200');
    }).catch(error => {
        res.send('Erro' + error);
    });
});

router.get('/reportNutrient', (req, res) => {
    ReportNutrient.find().then(reportNutrient => {
        res.json(reportNutrient);
    }).catch(error => {
        res.send('Erro ao carregar os dados');
    });
});

router.post('/reportNutrient', (req, res)=>{
    let description = req.body.description;
    let date = req.body.date;
    let value = req.body.value;

    let newReportNutrient = new ReportNutrient({
        description, date, value
    });

    newReportNutrient.save().then(response => {
        res.send('OK 200');
    }).catch(error => {
        res.send('Erro' + error);
    });
});

router.get('/reportIrrigation', (req, res) => {
    ReportIrrigation.find().then(reportIrrigation => {
        res.json(reportIrrigation);
    }).catch(error => {
        res.send('Erro ao carregar os dados');
    });
});

router.post('/reportIrrigation', (req, res)=>{
    let description = req.body.description;
    let date = req.body.date;
    let cropUsed = req.body.cropUsed;
    let waterSpended = req.body.waterSpended;
    let energySpended = req.body.energySpended;
    let nutrientSpended = req.body.nutrientSpended;
    let totalSpended = req.body.totalSpended;

    let newReportIrrigation = new ReportIrrigation({
        description, date, cropUsed, waterSpended, energySpended, nutrientSpended, totalSpended
    });

    newReportIrrigation.save().then(response => {
        res.send('OK 200');
    }).catch(error => {
        res.send('Erro' + error);
    });
});

module.exports = router;*/
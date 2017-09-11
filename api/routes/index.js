var express = require('express');
var router = express.Router();

var ctrlData = require('../controllers/data.controllers.js');

router
    .route('/remarkable')
    .get(ctrlData.getTableRemarkable);

router
    .route('/metrics')
    .get(ctrlData.getTableMetrics);


module.exports = router;
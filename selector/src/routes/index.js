const express = require('express');
const router = express.Router();

router.get('/', (req, res) => {
//    res.send('Servidor OK!');
//    res.redirect('/signin');
    res.render('index');
});

module.exports = router;

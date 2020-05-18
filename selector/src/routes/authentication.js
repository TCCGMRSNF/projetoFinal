const express = require('express');
const router = express.Router();
const helpers = require('../lib/helpers');


const passport = require('passport');
const { isLoggedIn, isNotLoggedIn } = require('../lib/auth');

router.get('/signin', isNotLoggedIn, (req, res) => {
    res.render('auth/signin');
});

router.post('/signin', isNotLoggedIn, (req, res, next) => {
    passport.authenticate('local.signin', {
    successRedirect: '/landing/master',
    failureRedirect: '/signin',
    failureFlash: true
    })(req, res, next);
});

router.get('/signup', isLoggedIn, (req, res) => {
    const usuario = helpers.fakeUser('pt_BR');
    console.log(usuario);
    res.render('auth/signup', {usuario: usuario});
//    res.render('auth/signup');
});

router.post('/signup', isLoggedIn, passport.authenticate('local.signup', {
        successRedirect: '/landing/master',
        failureRedirect: '/signup',
        failureFlash: true
}));

// Rota /profile está protegida, verificando se está logado
router.get('/profile', isLoggedIn, (req, res) => {
    res.render('profile');
});

router.get('/landing/master', isLoggedIn, (req, res) => {
    res.render('landing/master');
});

router.get('/logout', isLoggedIn, (req, res) => {
    req.logOut();
    res.redirect('/');
});

module.exports = router;
const passport = require('passport');
const LocalStrategy = require('passport-local').Strategy;

const pool = require('../database');
const helpers = require('../lib/helpers');

passport.use('local.signin', new LocalStrategy({
    usernameField: 'email',
    passwordField: 'senha',
    passReqToCallback: true
}, async (req, email, senha, done) => {
    console.log(req.body);
    // Verifica se usuario existe
    const rows = await pool.query('SELECT * FROM usuarios WHERE email = ?', [email]);
    console.log(rows);
    console.log(rows.length);
    if (rows.length > 0) {
        const user = rows[0];
        const validPassword = await helpers.matchPassword(senha, user.senha);
        console.log(validPassword);
        if (validPassword) {
            user.admin = user.admin === 'Y';
            console.log(user);
//            done(null, user, req.flash('success', 'Bem-vindo ' + user.nome));
            done(null, user);
        } else {
            done(null, false, req.flash('message', 'Senha incorreta!'));
        }
    } else {
        return done(null, false, req.flash('message', 'Email não cadastrado!'));
    }
}));





passport.use('local.signup', new LocalStrategy({
    usernameField: 'email',
    passwordField: 'senha',
    passReqToCallback: true
}, async (req, email, senha, done) => {
    const { nome } = req.body;
    const newUser = {
        email,
        senha,
        nome
    };

    newUser.senha = await helpers.encryptPassword(senha);
    const result = await pool.query('INSERT INTO usuarios SET ?', [newUser]);
    newUser.id = result.insertId;
    return done(null, newUser);
}));

passport.serializeUser((user, done) => {
    done(null, user.id);
});

passport.deserializeUser(async (id, done) => {
    const rows = await pool.query('SELECT * FROM usuarios WHERE id = ?', [id]);
    done(null, rows[0]);
});
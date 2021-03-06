const express = require('express');
const morgan = require('morgan');
const exphbs = require('express-handlebars');
const path = require('path');
const flash = require('connect-flash');
const session = require('express-session');
const MySQLStore = require('express-mysql-session');
const passport = require('passport');



const { database } = require('./keys');


// Initializations
const app = express();
require('./lib/passport');
snf = new Array (true, false, false, false);




// Settings
app.set('port', process.env.PORT || 3000);   // Umbler tem que ser porta 3000
app.set('views', path.join(__dirname, 'views'));
app.engine('.hbs', exphbs({
    defaultLayout: 'main',
    layoutsDir: path.join(app.get('views'), 'layouts'),
    partialsDir: path.join(app.get('views'), 'partials'),
    extname: '.hbs',
    helpers: require('./lib/handlebars')
}));
app.set('view engine', '.hbs');

// Middlewares
app.use(session({
    secret: 'senacrstcc2020',
    resave: false,
    saveUninitialized: false,
    store: new MySQLStore(database)
}));
app.use(flash());
app.use(morgan('dev'));
app.use(express.urlencoded({ extended: false }));
app.use(express.json());
app.use(passport.initialize());
app.use(passport.session());





// Global Variables
app.use((req, res, next) => {
    app.locals.success = req.flash('success');
    app.locals.message = req.flash('message');
    app.locals.authUser = req.user;
    app.locals.funcao = req.funcao;
    next();
});


// Routes
app.use(require('./routes'));     // index.js está implícito
app.use(require('./routes/authentication'));
app.use('/links', require('./routes/links'));
app.use('/usuarios', require('./routes/usuarios'));
app.use('/eventos', require('./routes/eventos'));
app.use('/notas', require('./routes/notas'));




// Public
app.use(express.static(path.join(__dirname, 'pub')));

// Starting the server
app.listen(app.get('port'), () => {
    console.log('Servidor ativo na porta ', app.get('port'));
});

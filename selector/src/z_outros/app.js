const express = require('express');
const app = express();
const fs = require('fs');
const logger = require('morgan');
const mongoose = require('mongoose');
const path = require('path');

//User Controller para verificar token
const userController = require('./controllers/usuariosController')

//Importa Rotas
const rotasAuth    = require('./routes/authRoutes');
const rotasUsuario = require('./routes/usuariosRoutes');
const rotasAutor   = require('./routes/autoresRoutes');
const rotasObra    = require('./routes/obrasRoutes');

app.use(express.json()) // for parsing application/json
app.use(express.urlencoded({ extended: true })) // for parsing application/x-www-form-urlencoded

//Configuração do Mongoose
mongoose.set('useNewUrlParser', true);

mongoose.connect('mongodb://localhost/app-projetos')
  .then(()=> {
    console.log('BD MONGO conectado!');
  })
  .catch((error)=> {
    console.log('Error ao conectar ao BD');
  });
mongoose.Promise = global.Promise;

//Log
var accessLogStream = fs.createWriteStream(path.join(__dirname, 'access.log'), { flags: 'a' })
app.use(logger('combined', { stream: accessLogStream }))

//Middleware
app.use('/api/usuarios',userController.validaToken);
app.use('/api/autores',userController.validaToken);
app.use('/api/obras',userController.validaToken);

//Uso das rotas
app.use('/api/auth', rotasAuth);
app.use('/api/usuarios', rotasUsuario);
app.use('/api/autores', rotasAutor);
app.use('/api/obras', rotasObra);

app.listen(3000, function () {
  console.log('Executando servidor na porta 3000!');
  console.log('Diretório Base: '+__dirname);
});
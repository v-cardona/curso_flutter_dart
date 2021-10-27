const express = require('express');
require('dotenv').config();

const app = express();

//body parser
app.use(express.urlencoded({ extended: true }));

// ruta
app.use('/', require('./routes/auth.js'));

app.listen(process.env.PORT || 3000, () => {
    var port = process.env.PORT || 3000;
    console.log('servidor corriendo en el puerto', port);
});
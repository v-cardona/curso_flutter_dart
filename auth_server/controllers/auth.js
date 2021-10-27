const { response } = require('express');
const { validarGoogleIdToken } = require('../helpers/google-very-token');

const googleAuth = async(req, res = response) => {
    const token = req.body.token;

    // se deberia validar como en chat app
    if (!token) {
        return res.json({
            ok: false,
            msg: 'No hay token en la peticion'
        });
    }

    // realizar comprobacion del token
    const googleUser = await validarGoogleIdToken(token);

    if (!googleUser) {
        return res.status(400).json({
            ok: false
        });
    }

    // en este punto el usuario ya esta validado

    res.json({
        ok: true,
        googleUser
    });
}

module.exports = {
    googleAuth
}
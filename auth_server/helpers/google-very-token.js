const { OAuth2Client } = require('google-auth-library');
// TODO
// credencial de web client authO en developer console credenciales
const CLIENT_ID = ''
const client = new OAuth2Client(CLIENT_ID);

const validarGoogleIdToken = async(token) => {
    try {
        const ticket = await client.verifyIdToken({
            idToken: token,
            audience: [
                CLIENT_ID,
                //TODO
                // credencial de auth para android para que se valide el token
                // tambien en el developer console credenciales
                ''
            ], // Specify the CLIENT_ID of the app that accesses the backend
            // Or, if multiple clients access the backend:
            //[CLIENT_ID_1, CLIENT_ID_2, CLIENT_ID_3]
        });
        const payload = ticket.getPayload();
        //const userid = payload['sub'];
        // If request specified a G Suite domain:
        // const domain = payload['hd'];
        //console.log(payload);
        return {
            name: payload['name'],
            picture: payload['picture'],
            email: payload['email'],
        };
    } catch (error) {
        return null;
    }
}

module.exports = {
    validarGoogleIdToken
}

// Crea los usuarios y te redirecciona a iniciar sesión
app.post('/register', express.urlencoded({ extended: false }), async (req, res) => {
    const { nombre_usuario, email, contrasenia} = req.body
    const contrasenia_hash = CryptoJS.SHA256(contrasenia).toString(CryptoJS.enc.Hex);

    const usuarioEnBD = await User.findOne({ where: {username : nombre_usuario}})

    if (!usuarioEnBD) {
        await User.create({ username: nombre_usuario, email: email, password: contrasenia_hash })
        res.render('login', {mensaje : '¡Registro realizado con éxito!'})
    } else {
        res.render ('register', { mensaje_register : 'Nombre de usuario existente'})
    }
    
})
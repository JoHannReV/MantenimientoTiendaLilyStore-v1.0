<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>LoginSupp</title>
    <link rel="stylesheet" href="css/LoginAdmin.css">
    <script>
        // Función para mostrar un mensaje de alerta
        function mostrarAlerta(mensaje) {
            alert(mensaje);
        }

        // Verificar si hay un parámetro de URL 'error'
        var urlParams = new URLSearchParams(window.location.search);
        if (urlParams.has('error')) {
            var error = urlParams.get('error');
            if (error === 'incorrect') {
                mostrarAlerta("Usuario o contraseña incorrectos.");
            } else if (error === 'empty') {
                mostrarAlerta("Por favor, ingresa un usuario y contraseña.");
            }
        }
    </script>
</head>
<body>
<% if (request.getParameter("message") != null && "loggedout".equals(request.getParameter("message"))) { %>
    <div class="alert alert-success">Has cerrado sesión exitosamente.</div>
<% } %>

    <div class="login-box">
        <img src="IMG/LogoLogin.png" class="avatar" alt="Avatar Image">
        <h1>BIENVENIDO ADMINISTRADOR</h1>
        
        <form class="form-sign" action="controladorUsuario" method="post">
            <label for="username">USUARIO</label> 
            <input type="text" placeholder="Ingrese Usuario" name="txtUsuario" required>
            
            <label for="password">CONTRASEÑA</label> 
            <input type="password" placeholder="Ingrese Contraseña" name="txtPassword" required> 
            
            <button id="boton" type="submit" name="accion" value="Ingresar">Ingresar</button>
        </form>
    </div>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>LoginSupp</title>
    <link rel="stylesheet" href="css/LoginAdmin.css">
    <script>
        // Función para mostrar una alerta
        function mostrarAlerta() {
            alert("Usuario o contraseña incorrectos");
        }

        // Función para validar el formulario antes de enviarlo
        function validarFormulario() {
            var usuario = document.getElementsByName("txtUsuario")[0].value;
            var contraseña = document.getElementsByName("txtPassword")[0].value;

            // Verifica si el usuario y la contraseña están vacíos
            if (usuario.trim() === "" || contraseña.trim() === "") {
                alert("Por favor, ingresa un usuario y contraseña.");
                return false; // Evita el envío del formulario
            }

            // Si todo está bien, permite el envío del formulario
            return true;
        }

        // Verificar si hay un parámetro de URL 'error' con valor 'incorrect'
        var urlParams = new URLSearchParams(window.location.search);
        if (urlParams.has('error')) {
            var error = urlParams.get('error');
            if (error === 'incorrect') {
                mostrarAlerta();
            } else if (error === 'empty') {
                alert("Por favor, ingresa un usuario y contraseña.");
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
        
        <!-- Cambié el action a "controladorUsuario" -->
        <form class="form-sign" action="controladorUsuario" method="post" onsubmit="return validarFormulario()">
            <label for="username">USUARIO</label> 
            <input type="text" placeholder="Ingrese Usuario" name="txtUsuario" required>
            
            <label for="password">CONTRASEÑA</label> 
            <input type="password" placeholder="Ingrese Contraseña" name="txtPassword" required> 
            
            <button id="boton" type="submit" name="accion" value="Ingresar">Ingresar</button>
        </form>
    </div>
</body>
</html>

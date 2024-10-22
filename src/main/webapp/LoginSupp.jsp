<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>LoginSupp</title>
    <link rel="stylesheet" href="css/LoginAdmin.css">
    <script>
        // Funci�n para mostrar una alerta
        function mostrarAlerta() {
            alert("Usuario o contrase�a incorrectos");
        }

        // Funci�n para validar el formulario antes de enviarlo
        function validarFormulario() {
            var usuario = document.getElementsByName("txtUsuario")[0].value;
            var contrase�a = document.getElementsByName("txtPassword")[0].value;

            // Verifica si el usuario y la contrase�a est�n vac�os
            if (usuario.trim() === "" || contrase�a.trim() === "") {
                alert("Por favor, ingresa un usuario y contrase�a.");
                return false; // Evita el env�o del formulario
            }

            // Si todo est� bien, permite el env�o del formulario
            return true;
        }

        // Verificar si hay un par�metro de URL 'error' con valor 'incorrect'
        var urlParams = new URLSearchParams(window.location.search);
        if (urlParams.has('error')) {
            var error = urlParams.get('error');
            if (error === 'incorrect') {
                mostrarAlerta();
            } else if (error === 'empty') {
                alert("Por favor, ingresa un usuario y contrase�a.");
            }
        }
    </script>
</head>
<body>
<% if (request.getParameter("message") != null && "loggedout".equals(request.getParameter("message"))) { %>
    <div class="alert alert-success">Has cerrado sesi�n exitosamente.</div>
<% } %>


    <div class="login-box">
        <img src="IMG/LogoLogin.png" class="avatar" alt="Avatar Image">
        <h1>BIENVENIDO ADMINISTRADOR</h1>
        
        <!-- Cambi� el action a "controladorUsuario" -->
        <form class="form-sign" action="controladorUsuario" method="post" onsubmit="return validarFormulario()">
            <label for="username">USUARIO</label> 
            <input type="text" placeholder="Ingrese Usuario" name="txtUsuario" required>
            
            <label for="password">CONTRASE�A</label> 
            <input type="password" placeholder="Ingrese Contrase�a" name="txtPassword" required> 
            
            <button id="boton" type="submit" name="accion" value="Ingresar">Ingresar</button>
        </form>
    </div>
</body>
</html>

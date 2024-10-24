<%@page import="model.EmpleadoDTO"%>
<%@page contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://cdn.jsdelivr.net/gh/eyelidlessness/fireworks.js/dist/fireworks.min.js"></script>
    <meta charset="ISO-8859-1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/gh/robertleeplummerjr/fireworks-js@latest/dist/fireworks.min.js"></script>
    
    <title>Tienda Lili</title>
</head>

<style>
body {
   font-family: Arial, sans-serif;
    background-image: url('https://img.freepik.com/vector-gratis/fondo-social-abstracto-tono-blanco-memphis_53876-114373.jpg?t=st=1729578453~exp=1729582053~hmac=a28c6d1cbeeb0350aa48867d5e2de800196d37347743edbb8a7d6ac059ce89f2&w=900');
    background-size: cover; /* Asegura que la imagen cubra todo el fondo sin distorsión */
    background-position: center; /* Centra la imagen en el fondo */
    background-repeat: no-repeat; /* Evita que la imagen se repita */
    min-height: 100vh; /* Asegura que el body tenga al menos la altura de la ventana */
    margin: 0; /* Elimina márgenes por defecto */

}
.card-container {
    margin-top: 80px;
    display: flex;
    justify-content: center;
    align-items: center;
}
.card {
    margin: 0 1rem; /* Espacio entre las tarjetas */
    width: 20rem; /* Ancho de las tarjetas */
}
.imagen {
    width: 100%; 
    height: auto; 
    max-height: 400px; 
    object-fit: cover; 
}
.card-text {
    font-size: 1.2em; 
    font-weight: bold;
    font-family: Arial, sans-serif;
}
.container {
    margin-top: 90px;
    txt-align: center;
    font-size: 17px; 
    font-weight: bold;
    font-family: Arial, sans-serif;
}
.welcome-message {
    font-size: 1.5rem; /* Aumenta el tamaño de la fuente */
    color: #FFD700; /* Color dorado */
    font-weight: bold; /* Texto en negrita */
    padding: 10px; /* Espaciado alrededor del texto */
    border-radius: 5px; /* Bordes redondeados */
    margin-bottom: 10px; /* Margen inferior */
}
</style>

<body>
<nav class="navbar navbar-dark bg-dark fixed-top">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">LilyStore</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasDarkNavbar" aria-controls="offcanvasDarkNavbar" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="offcanvas offcanvas-end text-bg-dark" tabindex="-1" id="offcanvasDarkNavbar" aria-labelledby="offcanvasDarkNavbarLabel">
            <div class="offcanvas-header">
                <h5 class="offcanvas-title" id="offcanvasDarkNavbarLabel">LilyStore</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas" aria-label="Close"></button>
            </div>
            
                            
            <div class="offcanvas-body">
                <ul class="navbar-nav justify-content-end flex-grow-1 pe-3">
                <% 
                    EmpleadoDTO empleado = (EmpleadoDTO) session.getAttribute("empleadoDTO"); 
                    if (empleado != null) {
                        String cargo = empleado.getCargo();
                        // Agregar salida de depuración
                        out.println("<!-- Valor del cargo: " + cargo + " -->");
                %>
                    <li class="nav-item">
                        <span class="nav-link welcome-message">BIENVENIDO <%= empleado.getNombre() + " " + empleado.getApellido() + " (" + cargo + ")" %></span>
                    </li>

                    

                    <% 
                    // Mostrar opciones según el cargo
                    if ("vendedor".equalsIgnoreCase(cargo)) { // Cargo 1
                    %>
                            <li class="nav-item">
                                <a class="nav-link" href="ControladorVenta?menu=Venta&accion=Listar">REALIZA VENTA</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="controladorCliente?menu=Cliente&accion=Listar">GESTION CLIENTE</a>
                            </li>
                    <% 
                    } else if ("supervisor".equalsIgnoreCase(cargo)) { // Cargo 2
                    %>
                            <li class="nav-item">
                                <a class="nav-link" href="controladorCliente?menu=Cliente&accion=Listar">GESTION CLIENTE</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="controladorEmpleado?menu=Empleado&accion=Listar">GESTION EMPLEADO</a>
                            </li>
                            
                    <% 
                    } else if ("almacenero".equalsIgnoreCase(cargo)) { // Cargo 3
                    %>
                            <li class="nav-item">
                                <a class="nav-link" href="controladorProducto?menu=Producto&accion=Listar">GESTION PRODUCTO</a>
                            </li>
                    <% 
                    } else if ("administrador".equalsIgnoreCase(cargo)) { // Cargo 4
                    %>
                            <li class="nav-item">
                                <a class="nav-link" href="controladorEmpleado?menu=Empleado&accion=Listar">GESTION EMPLEADO</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="controladorCliente?menu=Cliente&accion=Listar">GESTION CLIENTE</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="controladorProducto?menu=Producto&accion=Listar">GESTION PRODUCTO</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="controladorVenta?menu=Venta&accion=Listar">REALIZA VENTA</a>
                            </li>
                           
                    <% 
                    } else { 
                    %>
                            <li class="nav-item">
                                <span class="nav-link text-danger">CARGO DESCONOCIDO</span>
                            </li>
                    <% 
                    }
                    %>
                    <li class="nav-item">
                        <a class="nav-link" href="controladorUsuario?accion=Salir">CERRAR SESIÓN</a>
                    </li>
                <% } else { %>
                    <li class="nav-item">
                        <span class="nav-link welcome-message text-danger">NO HAY SESIÓN INICIADA</span>
                    </li>
                <% } %>
                </ul>
            </div>
        </div>
    </div>
</nav>

<div class="container" style="margin-top: 100px;">
    <h2>¿QUIÉNES SOMOS?</h2>
    <p><i>"La Tiendita de Lili"</i> es un negocio que nació en Lima, Perú, gracias a la iniciativa de una pareja de venezolanos, Jorge e Indiana. La historia comienza con Jorge, quien trabajó como diseñador en el centro de la ciudad y decidió emprender un proyecto creativo particular: la creación de cuadros únicos y originales que, hasta ese momento, nadie había visto.</p>
    <h2>Nuestros Valores</h2>
    <ul>
        <li><strong>Calidad:</strong> Nos esforzamos por ofrecer productos y servicios de la más alta calidad para satisfacer las necesidades de nuestros clientes.</li>
        <li><strong>Servicio al Cliente:</strong> Priorizamos la satisfacción del cliente y nos esforzamos por brindar un excelente servicio en cada interacción.</li>
        <li><strong>Innovación:</strong> Buscamos constantemente nuevas formas de mejorar y ofrecer soluciones creativas y originales.</li>
        <li><strong>Ética:</strong> Nos comprometemos a operar de manera ética y responsable en todas nuestras actividades comerciales.</li>
        <li><strong>Comunidad:</strong> Valoramos y apoyamos a nuestra comunidad, contribuyendo positivamente a su desarrollo y bienestar.</li>
    </ul>
</div>

<div class="card-container">
    <div class="card" style="width: 40rem;">
        <img src="https://acortar.link/zZouxS" class="card-img-top imagen">
        <div class="card-body">
            <h1>VISIÓN</h1>
            <p class="card-text">Queremos estar a la altura de las exigencias de nuestros consumidores, ofreciendo los mejores servicios que faciliten la entrega a domicilio y mejoren la satisfacción del cliente.</p>
        </div>
    </div>

    <div class="card" style="width: 40rem;">
        <img src="https://previews.123rf.com/images/epicfail/epicfail1705/epicfail170500040/79138557-banner-de-dise%C3%B1o-plano-de-delgada-l%C3%ADnea-de-declaraci%C3%B3n-de-misi%C3%B3n-empresarial.jpg" class="card-img-top imagen">
        <div class="card-body">
            <h1>MISIÓN</h1>
            <p class="card-text">Nuestra misión es ofrecer a nuestros clientes las últimas tendencias en diseño de cuadros artísticos. Nuestras colecciones están dirigidas a todo el público que ama las decoraciones modernas.</p>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const container = document.body; // Puedes cambiar esto a un div específico si lo prefieres.
        const fireworks = new Fireworks(container, {
            hue: { min: 0, max: 360 },
            auto: true, // Inicia automáticamente
        });
        fireworks.start();
    });
</script>
</body>
</html>

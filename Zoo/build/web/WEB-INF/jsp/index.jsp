<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html lang="en">
  <head>
    <jsp:include page="plantillas/Bootstrap_head.jsp"/>
    
    <title>Bienvenid@s al zoo</title>
    
    <style>
        .navbar{
            margin-bottom: 0px;
        }
    </style>
  </head>
<!-- NAVBAR
================================================== -->
  <body>
      
    <jsp:include page="plantillas/header.jsp"/>

    <!-- Carousel
    ================================================== -->
    <div id="myCarousel" class="carousel slide" data-ride="carousel">
      <!-- Indicators -->
      <ol class="carousel-indicators">
        <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
        <li data-target="#myCarousel" data-slide-to="1"></li>
        <li data-target="#myCarousel" data-slide-to="2"></li>
      </ol>
      <div class="carousel-inner" role="listbox">
        <div class="item active">
          <img class="first-slide" src="images/carousel_giraffe.jpg" alt="First slide">
          <div class="container">
            <div class="carousel-caption">
              <h1>Mabuti te mira a los ojos</h1>
              <p>Trepa la torre de mono, y te podrá lamer</p>
            </div>
          </div>
        </div>
        <div class="item">
          <img class="second-slide" src="images/carousel_redpanda.jpg" alt="Second slide">
          <div class="container">
            <div class="carousel-caption">
              <h1>A Yin Lao le encanta dormir en el sol</h1>
              <p>Lo llaman el oso gato, pero es familia de las mofetas!</p>
            </div>
          </div>
        </div>
        <div class="item">
          <img class="third-slide" src="images/carousel_vulture.jpg" alt="Third slide">
          <div class="container">
            <div class="carousel-caption">
              <h1>El águila calvo es muy hermoso</h1>
              <p>Es el ave más grande que has visto en tu vida</p>
            </div>
          </div>
        </div>
      </div>
      <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
        <span class="sr-only">Previous</span>
      </a>
      <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
        <span class="sr-only">Next</span>
      </a>
    </div><!-- /.carousel -->


    <!-- Marketing messaging and featurettes
    ================================================== -->
    <!-- Wrap the rest of the page in another container to center all the content. -->

    <div class="container">
        <h1>Bienvenid@s al zoo de Yupilandia</h1>
        <p class="lead" style="padding:5px; margin:5px">Los animales molan! Algunos son muy grandes, otros pequeños, fuertes, o rápidos... y puedes conocerlos todos aquí.
        Ven al Zoo y ponte cara a cara con los monos, gruñe con los leones, y aprende por qué los murciélagos pueden volar hasta en total oscuridad.
        Siempre hay algo que ver en el Zoo!</p>
    </div>
    
    <div class="container marketing">

      <!-- START THE FEATURETTES -->

      <hr class="featurette-divider">

      <div class="row featurette">
        <div class="col-md-7">
          <h2 class="featurette-heading">Noticias <span class="text-muted">del mundo animal</span></h2>
          <p class="lead">Tenemos animales bebé? Un león que cumple años? Algún evento especial? Ponte al día <a href="base.htm?pagina=noticias">aquí</a>.</p>
        </div>
        <div class="col-md-5">
          <img class="featurette-image img-responsive center-block" src="images/frontpage_lion.jpg">
        </div>
      </div>

      <hr class="featurette-divider">

      <div class="row featurette">
        <div class="col-md-7 col-md-push-5">
          <h2 class="featurette-heading">Información <span class="text-muted">sobre el zoo</span></h2>
          <p class="lead">En nuestra página de <a href="base.htm?pagina=info">Información</a> encuentras rutas, horarios, y mapas del zoo</p>
        </div>
        <div class="col-md-5 col-md-pull-7">
          <img class="featurette-image img-responsive center-block" src="images/frontpage-koala.jpg">
        </div>
      </div>

      <hr class="featurette-divider">

      <div class="row featurette">
        <div class="col-md-7">
          <h2 class="featurette-heading">Entradas</h2>
          <p class="lead">Tenemos varios tipos de entradas para un día, medio año u año completo. Compra en taquilla o <a href="base.htm?pagina=entradas">en línea</a>.</p>
        </div>
        <div class="col-md-5">
          <img class="featurette-image img-responsive center-block" src="images/frontpage-raccoon.jpg">
        </div>
      </div>

      <hr class="featurette-divider">

      <!-- /END THE FEATURETTES -->


      <!-- FOOTER -->
      <footer>
        <p class="pull-right"><a href="#">Back to top</a></p>
        <p>&copy; 2020 Zoo de Yupilandia, Inc. &middot; <a href="#">Privacy</a> &middot; <a href="#">Terms</a> &middot; <a href="logemp.htm">Empleados</a></p>
      </footer>

    </div><!-- /.container -->


    <jsp:include page="plantillas/Bootstrap_foot.jsp"/>
  </body>
</html>

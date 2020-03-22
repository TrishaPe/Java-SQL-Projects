<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>

    <nav class="navbar navbar-inverse">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#">${empleado.nombre}</a>
        </div>
        <div id="navbar" class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
            <li><a href="misdatos.htm">Mis datos</a></li>
            <c:if test="${empleado.dept_cod==1 || empleado.funcion=="gestor"}">
                <li><a href="empdatos.htm">Datos empleados</a></li>
            </c:if>
            <li><a href="animal.htm">Animales</a></li>
            <li><a href="peticiones.htm?peticiones=inicio">Pedidos</a></li>
          </ul>
          <form class="navbar-form navbar-right" action="portemp.htm">
              <button type="submit" class="btn btn-success" name="portemp" value="desloguear">Desloguear</button>
          </form>
        </div><!--/.nav-collapse -->
      </div>
    </nav>

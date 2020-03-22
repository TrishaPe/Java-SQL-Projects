<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>

<c:choose>
 <c:when test="${sessionScope.cliente!=null}"><%--Si tenemos cliente en session, ponemos su nombre y damos opcion de desloguear--%>
  <nav class="navbar navbar-inverse">
    <div class="container">
      <div class="navbar-header"></div>
      <div class="navbar-collapse collapse">
        <ul class="nav navbar-nav">
          <li><a href="index.htm">Home</a></li>
          <li><a href="cliente.htm?caccion=inicio">Portal cliente</a></li>
          <li><a href="cliente.htm?caccion=desloguear">Desloguear</a></li>
        </ul>
      </div><!--/.nav-collapse -->
    </div>
  </nav>
 </c:when>
 <c:otherwise>
   <nav class="navbar navbar-inverse">
    <div class="container">
      <div  id="navbar" class="navbar-collapse collapse">
        <form class="navbar-form navbar-right" action="base.htm">
          <div class="form-group">
            <input type="text" placeholder="Usuario" class="form-control" name="txtUsuario" required>
          </div>
          <div class="form-group">
            <input type="text" placeholder="Contraseña" class="form-control" name="txtContraseña" required>
          </div>
          <button type="submit" class="btn btn-success" name="pagina" value="login">Entrar</button>
        </form>
        <form class="navbar-form navbar-right" action="base.htm">
          <button type="submit" class="btn btn-success" name="pagina" value="registrar">Registrar</button>
        </form>
      </div><!--/.navbar-collapse -->
    </div>
   </nav>
 </c:otherwise>
</c:choose>


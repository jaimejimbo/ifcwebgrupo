<%@page import="java.sql.CallableStatement" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.ResultSet" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="../includes.jsp"/>
    <title>Inicio</title>
</head>
<body>
<jsp:include page="header.jsp"/>
<div class="col-lg-1 col-md-1 col-sm-1"></div>
<div class="col-lg-10 col-md-10 col-sm-10 col-xs-12 main-bg">

    <%
        // Recupero las sesiones que hay iniciadas. Aunque me vale con el id del usuario logeado.

        HttpSession sesion = request.getSession();

        String email = (String) sesion.getAttribute("email"); //$NON-NLS-1$
        String pwd = (String) sesion.getAttribute("pwd"); //$NON-NLS-1$
        Integer cliente_id = (Integer) sesion.getAttribute("cliente_id"); //$NON-NLS-1$

        // Compruebo que me traigo bien el "cliente_id".

        System.out.println("cliente_id: " + cliente_id);

        // Me conecto a la base de datos.

        Connection conexion = null;
        CallableStatement cs1 = null;
        CallableStatement cs2 = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            String url = "jdbc:mysql://localhost/banco";
            conexion = DriverManager.getConnection(url, "root", "");

            // Lo primer que quiero hacer es mostrar las cuentas del cliente logueado.
            // No existe un procedimiento para seleccionar las "cuenta_id" del "cliente_id" en la "tabla posesiones".
            // He creado un procedimiento con ese fin ("seleccionar_cuenta_id").

            cs1 = conexion.prepareCall("{call seleccionar_cuenta_id(?)}");
            cs1.setInt(1, cliente_id);
            ResultSet rs = cs1.executeQuery();

            // Pido que me muestre en la consola esos ids para ver si selecciona bien.

            //while(rs.next()){
            //System.out.println("cuenta_id: "+rs.getInt(1));
            //}

            // Pido que me muestre en la pantalla las cuentas de esos ids.
            out.print("<table class='table table-hover'><thead><th>descripcion</th><th>fondos</th><th>nombre</th><th>seleccionar</th></thead><tbody>");

            // Muestro en la pantalla los valores de lso registros seleccionados en la tabla "cuentas".
            while (rs.next()) {
                // Creo otro procedimiento que busca el registro en "cuentas" que tiene cada "cuenta_id".
                // Lo he llamado "seleccionar_cuentas".
                cs2 = conexion.prepareCall("{call seleccionar_cuentas(?)}");
                // Envio el "Resulset" anterior al nuevo procedimiento.
                cs2.setInt(1, rs.getInt(1));
                //Compruebo que envia bien el "Resulset" del primer procedimiento al segundo.
                System.out.println("cuenta_id: " + rs.getInt(1));
                ResultSet mostrar = cs2.executeQuery();
                // Muestro en la pantalla los valores de lso registros seleccionados en la tabla "cuentas".
                while (mostrar.next()) {
    %>
    <tr>
        <td><%=mostrar.getString(4)%>
        </td>
        <td><%=mostrar.getFloat(3)%>
        </td>
        <td><%=mostrar.getString(2)%>
        </td>
        <td><a class="fa fa-times"
               href="<%=request.getContextPath()%>/jsp/privado/eliminar.jsp?eliminado=<%=mostrar.getInt(1)%>">Eliminar</a>
        </td>
        <td><a class="fa fa-bars"
               href="<%=request.getContextPath()%>/movimientos.php?cuentaid=<%=mostrar.getInt(1)%>">Movimientos</a></td>
    </tr>
    <%
                }
            }
            out.print("</tbody></table>");
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
    <p class="text-right">
        <a class="fa fa-plus" href="crearcuenta.jsp">Añadir</a>
    </p>
</div>
<div id="output"></div>
<!--[if lt IE 9]>
<script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<![endif]-->
<jsp:include page="footer.jsp"></jsp:include>

</body>
</html>
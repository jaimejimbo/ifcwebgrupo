<%@ page import="java.sql.ResultSet" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" %>

<table class='table table-hover'>
    <thead>
    <th>descripcion</th>
    <th>fondos</th>
    <th>nombre</th>
    <th>seleccionar</th>
    </thead>
    <tbody>

    <%
        ResultSet rs = (ResultSet) request.getAttribute("cuentas");
        if (rs != null) {
            while (rs.next()) {
                int cuenta_id = rs.getInt(1);
                String descripcion = rs.getString(2);
                float fondos = rs.getFloat(3);
                String nombre = rs.getString(4);
    %>
    <tr>
        <td><%=descripcion%>
        </td>
        <td><%=fondos%>
        </td>
        <td><%=nombre%>
        </td>
        <td><a class="fa fa-times"
               href="<%=request.getContextPath()%>/jsp/privado/eliminar.jsp?eliminado=<%=cuenta_id%>">Eliminar</a>
        </td>
        <td><a class="fa fa-bars"
               href="<%=request.getContextPath()%>/movimientos.php?cuentaid=<%=cuenta_id%>">Movimientos</a></td>
    </tr>
    <%
            }
        }
    %>
    </tbody>
</table>
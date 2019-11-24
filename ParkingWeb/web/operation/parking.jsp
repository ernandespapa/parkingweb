<%-- 
    Document   : home
    Created on : 19/11/2019, 15:40:22
    Author     : ernandes
--%>

<%@page import="br.com.fatecpg.parking.Period"%>
<%@page import="java.util.Date"%>
<%@page import="br.com.fatecpg.parking.Price"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String error = null;
    
    if(request.getParameter("formNewPeriod")!=null){
        try {
           String model = request.getParameter("model");
           String plate = request.getParameter("plate");
           Period.addPeriod(model, plate);
           response.sendRedirect(request.getRequestURI());
        } catch(Exception e){
            error = e.getMessage();
        }
        
    }
     %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title> Estacionamento - ParkingWebApp</title>
    </head>
    <body>
        <%@include file="../WEB-INF/jspf/header.jspf"%>
        <h1>Estacionamento (vagas)</h1>
        <%if(session.getAttribute("user")== null){%>
        <h2>É preciso estar autenticado para acessar este recurso</h2>
        <%}else{%>
        <% User user = (User) session.getAttribute("user"); %>
        
        <% if (error != null){%>
        <h3><%=error%></h3>
        <%}%>
        <fieldset>
            <legend>Entrada de Veículo</legend>
            <form>
                Modelo: <input type="text" name="model"/>
                Placa: <input type="text" name="plate"/>
                <input type="submit" name="formNewPeriod" value="Registrar Entrada"/>
            </form>
        </fieldset>
        <table border="1">
            <tr>
                <th>ID</th>
                <th>Modelo</th>
                <th>Placa</th>
                <th>Entrada</th>
                <th>Comandos</th>
            </tr>
            <% for (Period p: Period.getPeriods()){%>
            <tr>
                <td><%=p.getId()%></td>
                <td><%=p.getModel()%></td>
                <td><%=p.getPlate()%></td>
                <td><%=p.getBegin()%></td>
                
                <td>
                    <a href="finish-period.jsp?id=<%=p.getId()%>">Registar Saída</a>
                </td>
            </tr>
            <% }%>
        </table>
        
        <%}%>
       
        
    </body>
</html>

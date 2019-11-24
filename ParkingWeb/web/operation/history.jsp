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
    String date = null;
    String plate = null;
    
    if(request.getParameter("formFilter")!=null){
      date = request.getParameter("date");
      if (date.isEmpty()) date = null;
      plate = request.getParameter("plate");
      if (plate.isEmpty()) plate = null;
   
    }
     %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title> Histórico - ParkingWebApp</title>
    </head>
    <body>
        <%@include file="../WEB-INF/jspf/header.jspf"%>
        <h1>Histórico</h1>
        <%if(session.getAttribute("user")== null){%>
        <h2>É preciso estar autenticado para acessar este recurso</h2>
        <%}else{%>
        <% User user = (User) session.getAttribute("user"); %>
        
        <% if (error != null){%>
        <h3><%=error%></h3>
        <%}%>
        <fieldset>
            <legend>Flitro</legend>
            <form>
                Data: <input type="date" name="date"/>
                Placa: <input type="text" name="plate"/>
                <input type="submit" name="formFilter" value="Filtrar"/>
            </form>
        </fieldset>
        <table border="1">
            <tr>
                <th>ID</th>
                <th>Modelo</th>
                <th>Placa</th>
                <th>Entrada</th>
                <th>Saída</th>
                <th>Preço</th>
                
            </tr>
            <% for (Period p: Period.getHistory(date, plate)){%>
            <tr>
                <td><%=p.getId()%></td>
                <td><%=p.getModel()%></td>
                <td><%=p.getPlate()%></td>
                <td><%=p.getBegin()%></td>
                <td><%=p.getEnd()%></td>
                <td><%=p.getPrice()%></td>
                
               
            </tr>
            <% }%>
        </table>
        
        <%}%>
       
        
    </body>
</html>

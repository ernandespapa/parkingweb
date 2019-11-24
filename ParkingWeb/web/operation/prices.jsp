<%-- 
    Document   : home
    Created on : 19/11/2019, 15:40:22
    Author     : ernandes
--%>

<%@page import="java.util.Date"%>
<%@page import="br.com.fatecpg.parking.Price"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String error = null;
    if(request.getParameter("formDeletePrice")!=null){
        try{
            long id = Long.parseLong(request.getParameter("id"));
            Price.removePrice(id);
            response.sendRedirect(request.getRequestURI());
        }catch(Exception e){
             error = e.getMessage();   
        }
    }
    if(request.getParameter("formNewPrice")!=null){
        try {
           double price = Double.parseDouble(request.getParameter("price"));
           Price.addPrice(new Date(), price);
           response.sendRedirect(request.getRequestURI());
        } catch(Exception e){
            error = e.getMessage();
        }
        
    }
     %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title> Preços - ParkingWebApp</title>
    </head>
    <body>
        <%@include file="../WEB-INF/jspf/header.jspf"%>
        <h1>Preços</h1>
        <%if(session.getAttribute("user")== null){%>
        <h2>É preciso estar autenticado para acessar este recurso</h2>
        <%}else{%>
        <% User user = (User) session.getAttribute("user"); %>
        
        <% if (error != null){%>
        <h3><%=error%></h3>
        <%}%>
        <fieldset>
            <legend>Novo preço</legend>
            <form>
                Novo Preço: <input type="text" name="price"/>
                <input type="submit" name="formNewPrice" value="Add"/>
            </form>
        </fieldset>
        <table border="1">
            <tr>
                <th>ID</th>
                <th>Data/hora</th>
                <th>Preço</th>
                <th>Comandos</th>
            </tr>
            <% for (Price p: Price.getPrices()){%>
            <tr>
                <td><%=p.getId()%></td>
                <td><%=p.getTimestamp()%></td>
                <td><%=p.getPrice()%></td>
                
                <td>
                    <form>
                        <input type="hidden" name="id" value="<%=p.getId()%>"/>
                        <input type="submit" name="formDeletePrice" value="Remover"/>
                    </form>
                </td>
            </tr>
            <% }%>
        </table>
        
        <%}%>
       
        
    </body>
</html>

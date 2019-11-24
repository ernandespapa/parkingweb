<%-- 
    Document   : home
    Created on : 19/11/2019, 15:40:22
    Author     : ernandes
--%>

<%@page import="br.com.fatecpg.parking.Price"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title> Home - ParkingWebApp</title>
    </head>
    <body>
        <%@include file="WEB-INF/jspf/header.jspf"%>
        <h1>Página Inicial</h1>
        <h1>Preço Atual</h1>
        <% if( Price.getCurrentPrice() == null){%>
        <h3>[Preço não definido pela administração do Estacionamento</h3>
        <% }else{%>
            <h3>R$ <%= Price.getCurrentPrice()%></h3>
        <% }%>
        
        
    </body>
</html>

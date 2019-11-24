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
    Long id = null;
    Period period = null;
    int hours = 0;
    double price = 0;
    try{
    id = Long.parseLong(request.getParameter("id"));
    period = Period.getPeriod(id);
    Date now = new Date();
    hours = now.getHours() - period.getBegin().getHours();
    price = hours * Price.getCurrentPrice();
    
      if(request.getParameter("formFinishPeriod")!=null){
        try {
           
           Period.finishPeriod(id, price);
           response.sendRedirect(request.getContextPath()+"/operation/parking.jsp");
        } catch(Exception e){
            error = e.getMessage();
        }
        
    }
    }catch(Exception ex){
        error = "Erro de leitura do registro de estadia do veículo: "  + ex.getMessage();
    }
    
  
     %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title> Estacionamento - ParkingWebApp</title>
    </head>
    <body>
        <%@include file="../WEB-INF/jspf/header.jspf"%>
        <h1>Regitrar Saída</h1>
         <% if (error != null){%>
        <h3><%=error%></h3>
        <%}%>
        <%if(session.getAttribute("user")== null){%>
        <h2>É preciso estar autenticado para acessar este recurso</h2>
        <%}else if (period != null){%>
        <% User user = (User) session.getAttribute("user"); %>
        
            <form>
                <h3> ID: <%= id %></h3>
                <h3>Modelo:<%= period.getModel()%></h3>
                <h3>Placa:<%= period.getPlate() %></h3>
                <h3>Horas:<%= hours %></h3>
                <h3>Preço: R$ <%= price%></h3>
                <input type="hidden" value ="<%= id%>" name="id"/>
                
                <h3><input type="submit" name="formFinishPeriod" value="Registrar Saida">&nbsp;&nbsp;<a href="parking.jsp">Voltar</a></h3>
            </form>
        
        <%}%>
       
        
    </body>
</html>

<%-- 
    Document   : soccer new_match
    Created on : Feb 24, 2016, 10:14:20 AM
    Author     : eduarc
--%>
<%@page import="co.com.bookmaker.business_logic.controller.event.MatchEventController"%>
<%@page import="co.com.bookmaker.business_logic.controller.event.TournamentController"%>
<%@page import="co.com.bookmaker.business_logic.controller.AnalystController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:useBean id="Role" class="co.com.bookmaker.util.type.Role"></jsp:useBean>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
        <link rel="stylesheet" href="css/analyst/analyst.css">
        
        <title>BookMaker - Nuevo Juego</title>
    </head>
    <body>
        <jsp:include page="/WEB-INF/navbar.jsp"></jsp:include>
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-3 sidebar">
                    <jsp:include page="<%=AnalystController.getJSP(AnalystController.SIDEBAR)%>"></jsp:include>
                </div>
                <!-- Main Content -->
                <div id="mainContent" class="col-md-9 side-body">
                <jsp:include page="<%=MatchEventController.getJSP(MatchEventController.NEW) %>">
                    <jsp:param name="roleRequester" value="${Role.ANALYST}"></jsp:param>
                </jsp:include>
                </div>
            </div>
        </div>
        <%@include file="/WEB-INF/footer.jsp" %>
                
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
        <script>
            $(document).ready(function() {
                $('#menuMatch').collapse("show");
                $('#newMatch').addClass("active");
                $('#pAnalyst').addClass("active");
                $(".team_name").on('keyup', function() {
                    var strId = $(this).prop("id");
                    var name = $(this).prop("value");
                    var id = strId.substr(2);
                    $(".t"+id).text(name);
                });
            });
        </script>
    </body>
    <jsp:include page="/WEB-INF/info_modal.jsp"></jsp:include>
    <jsp:include page="/WEB-INF/warning_modal.jsp"></jsp:include>
    <jsp:include page="/WEB-INF/error_modal.jsp"></jsp:include>
</html>




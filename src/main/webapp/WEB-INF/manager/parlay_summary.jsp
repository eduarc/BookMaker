<%-- 
    Document   : parlay_summary
    Created on : Mar 14, 2016, 10:02:31 PM
    Author     : eduarc
--%>
<%@page import="co.com.bookmaker.business_logic.controller.ManagerController"%>
<%@page import="co.com.bookmaker.business_logic.controller.parlay.ParlayController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="Role" class="co.com.bookmaker.util.type.Role"></jsp:useBean>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
        <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
        <link rel="stylesheet" href="css/seller/seller.css">
        
        <title>BookMaker - Resumen de Parlay</title>

        <style></style>
    </head>
    <body>
        <jsp:include page="/WEB-INF/navbar.jsp"></jsp:include>
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-3 sidebar">
                    <jsp:include page="<%=ManagerController.getJSP(ManagerController.SIDEBAR)%>"></jsp:include>
                </div>
                <!-- Main Content -->
                <div id="mainContent" class="col-md-9 side-body">
                    <h2 class="main_content_title"> Parlay </h2>
                    <jsp:include page="<%=ParlayController.getJSP(ParlayController.SUMMARY)%>">
                        <jsp:param name="roleRequester" value="${Role.MANAGER}"></jsp:param>
                    </jsp:include>
                </div>
            </div>
        </div>
        <%@include file="/WEB-INF/footer.jsp" %>
                
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
        <script>
            $(document).ready(function() {
                $('#searchParlay').addClass("active");
                $('#pManager').addClass("active");
            });
        </script>
    </body>
    <jsp:include page="/WEB-INF/info_modal.jsp"></jsp:include>
    <jsp:include page="/WEB-INF/warning_modal.jsp"></jsp:include>
    <jsp:include page="/WEB-INF/error_modal.jsp"></jsp:include>
</html>



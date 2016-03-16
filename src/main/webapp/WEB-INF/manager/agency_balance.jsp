<%-- 
    Document   : agency_balance
    Created on : Mar 13, 2016, 11:47:31 AM
    Author     : eduarc
--%>
<%@page import="co.com.bookmaker.business_logic.controller.ManagerController"%>
<%@page import="co.com.bookmaker.business_logic.controller.AgencyController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
        <link rel="stylesheet" href="/BookMaker/css/admin/admin.css">
        
        <title>BookMaker - Agency Balance</title>
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
                    <jsp:include page="<%=AgencyController.getJSP(AgencyController.BALANCE)%>"></jsp:include>
                </div>
            </div>
        </div>
        <%@include file="/WEB-INF/footer.jsp" %>
        
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
        <script>
            $(document).ready(function() {
                $('#balance').addClass("active");
                $('#pManager').addClass("active");
            });
        </script>
    </body>
    <jsp:include page="/WEB-INF/info_modal.jsp"></jsp:include>
    <jsp:include page="/WEB-INF/warning_modal.jsp"></jsp:include>
    <jsp:include page="/WEB-INF/error_modal.jsp"></jsp:include>
</html>


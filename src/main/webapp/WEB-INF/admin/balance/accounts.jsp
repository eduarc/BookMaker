<%-- 
    Document   : accounts
    Created on : Mar 17, 2016, 12:55:51 PM
    Author     : eduarc
--%>
<%@page import="co.com.bookmaker.business_logic.controller.AdminController"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<fmt:setLocale value="en_US"></fmt:setLocale>

<style>
    .form-group {
        margin-top: 0px;
        margin-bottom: 0px;
        padding-bottom: 0px;
        padding-top: 0px;
    }
</style>

<jsp:useBean id="Param" class="co.com.bookmaker.util.type.Parameter"></jsp:useBean>
<jsp:useBean id="Attr" class="co.com.bookmaker.util.type.Attribute"></jsp:useBean>
<jsp:useBean id="Info" class="co.com.bookmaker.util.type.Information"></jsp:useBean>
<jsp:useBean id="Role" class="co.com.bookmaker.util.type.Role"></jsp:useBean>

<h2 class="main_content_title"> Balance de Cuentas </h2>

<div class="row">
    <div class="col-md-6">
        <form role="form" class="form-horizontal">
            <div class="form-group" style="text-align: center">
                <h4 class="col-md-12">Agencia</h4>
            </div>
            <div class="form-group">
                <label class="col-md-3 control-label">Total: </label>
                <div class="col-md-9">
                    <p class="form-control-static">${requestScope[Attr.AGENCIES]}</p>
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-3 control-label">Activa: </label>
                <div class="col-md-9">
                    <p class="form-control-static">${requestScope[Attr.ACTIVE_AGENCIES]}</p>
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-3 control-label">Inactiva: </label>
                <div class="col-md-9">
                    <p class="form-control-static">${requestScope[Attr.INACTIVE_AGENCIES]}</p>
                </div>
            </div>
        </form>
    </div>
    <div class="col-md-6">
        <form role="form" class="form-horizontal">
            <div class="form-group" style="text-align: center">
                <h4 class="col-md-12">Usuario</h4>
            </div>
            <div class="form-group">
                <label class="col-md-3 control-label">Total: </label>
                <div class="col-md-9">
                    <p class="form-control-static">${requestScope[Attr.USERS]}</p>
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-3 control-label">Online: </label>
                <div class="col-md-9">
                    <p class="form-control-static">${requestScope[Attr.ONLINE]}</p>
                </div>
            </div>    
            <div class="form-group">
                <label class="col-md-3 control-label">Activa: </label>
                <div class="col-md-9">
                    <p class="form-control-static">${requestScope[Attr.ACTIVE_USERS]}</p>
                </div>
            </div>
            <div class="form-group">
                <label class="col-md-3 control-label">Inactiva: </label>
                <div class="col-md-9">
                    <p class="form-control-static">${requestScope[Attr.INACTIVE_USERS]}</p>
                </div>
            </div>
        </form>
    </div>
</div>


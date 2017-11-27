<%@ page import="java.util.*" pageEncoding="ISO-8859-1"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<base href="<%=basePath%>">

<link rel="stylesheet" href="sources/external/bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="sources/external/fontawesome/css/font-awesome.css">
<link rel="stylesheet" href="sources/external/jquery-ui/jquery-ui.css">
<link rel="stylesheet" href="sources/css/site.css">
<link rel="stylesheet" href="sources/css/header.css">

<nav class="navbar navbar-inverse">
    <div class="navbar-header">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="">
            <i class="fa fa-video-camera" aria-hidden="true"></i><span style="padding-left: 15px;">Home</span>
        </a>
    </div>

    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
        <ul class="nav navbar-nav">
            <li><a href="">Base Case</a></li>
            <li><a href="">Variation1</a></li>
            <li><a href="">Variation2</a></li>
            <li><a href="">Variation3</a></li>
        </ul>
    </div>
</nav>

<script src="sources/external/jquery/jquery-3.2.1.js"></script>
<script src="sources/external/jquery-ui/jquery-ui.js"></script>

<%@ page import="java.util.*,tools.*" pageEncoding="ISO-8859-1"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
<base href="<%=basePath%>">
<head>
    <title>Edge-Disjoint Paths</title>
    <link rel="stylesheet" href="sources/css/poster_list.css">
</head>

<body>
<jsp:include page="view/shared/Header.jsp" />
<div class="container">
    <% if(request.getAttribute("error") != null) { %>
        <% if((Boolean) request.getAttribute("error")) { %>
            <div class="alert alert-danger">
                <%=request.getAttribute("message")%>
            </div>
        <% } else { %>
            <div class="alert alert-success">
                <%=request.getAttribute("message")%>
            </div>
        <% } %>
    <% } %>
    <div class="panel panel-primary">
        <div class="panel-heading">
            <div class="row">
                <div class="prod-panel col-lg-12">
                    <div class="panel panel-primary info-panel">
                        <div class="panel-heading">
                            <h3 class="panel-title">Welcome</h3>
                        </div>
                        <div class="panel-body">
                            <div class="mytext">
                                Input Requirements:
                                <ul>
                                    <li><b>Must run in Chrome.</b></li>
                                    <li>The input must be a connected graph.</li>
                                    <li>The node id must start from 1.</li>
                                    <li>There never exsits a duplicate entry. (i.e. two edges has same source and target).</li>
                                </ul>

                                Please upload csv file first before you run any applications.
                                <form action="UploadControl" method="post" enctype="multipart/form-data">
                                    <input type="file" name="file" accept=".csv"/>
                                    <button class="btn btn-default" type="submit" value="upload"><i class="fa fa-search"></i> Submit</button>
                                </form>
                            </div>
                            <%
                                Boolean error = (Boolean)request.getAttribute("error");
                                Boolean uploaded = (Boolean)this.getServletConfig().getServletContext().getAttribute("uploaded");
                                if(error != null && uploaded) {
                                    String orgGraphName = (String)this.getServletConfig().getServletContext().getAttribute("org_graph");
                                    ArrayList<Integer> nodeList = (ArrayList<Integer>)this.getServletConfig().getServletContext().getAttribute("node_list");
                            %>
                                <div class="mytext">
                                    </br>Please select the source node and destination node. </br>
                                    <b>Source</b> and <b>Destination MUST </b>be different.
                                </div>

                                <form action="BaseControl" method="post" name="base_form">
                                    <div class="form-group col-lg-3" style="padding-right:0;">
                                        <label class="mytext">Source:</label>
                                        <div class="input-group">
                                            <span class="input-group-addon"><i class="fa fa-user"></i></span>
                                            <select  name="source" class="form-control" onblur="document.var1_form.input.value = this.value;">
                                                <option value="">select source...</option>
                                                <%
                                                    for (Integer node: nodeList) {
                                                %>
                                                <option value="<%=node%>"><%=node%></option>
                                                <%
                                                    }
                                                %>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="form-group col-lg-3" style="padding-right:0;">
                                        <label class="mytext">Destination:</label>
                                        <div class="input-group">
                                            <span class="input-group-addon"><i class="fa fa-user"></i></span>
                                            <select  name="dest" class="form-control" onblur="document.var1_form.input.value = this.value;">
                                                <option value="">select dest...</option>
                                                <%
                                                    for (Integer node: nodeList) {
                                                %>
                                                <option value="<%=node%>"><%=node%></option>
                                                <%
                                                    }
                                                %>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <button class="btn btn-default col-lg-1" type="submit"><i class="fa fa-search"></i> Base Case</button>
                                        <button class="btn btn-default col-lg-1" formaction="Var1Control" type="submit"><i class="fa fa-search"></i> Variation1</button>
                                    </div>
                                </form>
                                <div class="row-items col-lg-12">
                                    <div class='mytext' align="center">Original Graph</div>
                                    <img id="photo" src="<%="tmpfiles/"+orgGraphName%>" onError="this.onerror=null;this.src='image/thumbnail_unavailable.jpg';"><br>
                                </div>
                            <%
                                }
                            %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


</div>
<jsp:include page="view/shared/Scripts.jsp" />
</body>
</html>

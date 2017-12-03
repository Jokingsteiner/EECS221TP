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
                                    <li>You may select given input sample instead of uploading CSV file.</li>
                                    <li><b>You may need to refresh the page to see updated graph.</b></li>
                                </ul>

                                Please upload csv file first before you run any applications.
                                <div>
                                    <form class = "myForm" action="UploadControl" method="post" enctype="multipart/form-data">
                                        <input type="file" name="file" accept=".csv"/>
                                        <button class="btn btn-default" type="submit" value="upload"><i class="fa fa-search"></i> Submit</button>
                                    </form>
                                    <form class = "myForm" action="SampleControl" method="post">
                                        <input type="hidden" name="sample_name" value="input_sample.csv"/>
                                        <button class="btn btn-default" type="submit" value="upload"><i class="fa fa-search"></i> Sample</button>
                                    </form>
                                </div>
                            </div>
                            <%
                                Boolean uploaded = (Boolean)this.getServletConfig().getServletContext().getAttribute("uploaded");
                                if(uploaded != null && uploaded) {
                                    String orgGraphName = (String)this.getServletConfig().getServletContext().getAttribute("org_graph");
                                    ArrayList<Integer> nodeList = (ArrayList<Integer>)this.getServletConfig().getServletContext().getAttribute("node_list");
                            %>
                                <div class="mytext">
                                    <br>Please select the source node and destination node. <br>
                                    <b>Source</b> and <b>Destination MUST </b>be different.
                                </div>

                                <form action="BaseControl" method="post" name="base_form">
                                    <div class="form-group col-lg-3" style="padding-right:0;">
                                        <label class="mytext">Source:</label>
                                        <div class="input-group">
                                            <span class="input-group-addon"><i class="fa fa-user"></i></span>
                                            <select  name="source" class="form-control">
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
                                            <select  name="dest" class="form-control">
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
                                    <br>
                                    <button class="btn btn-default col-lg-1" type="submit"><i class="fa fa-search"></i> Base Case</button>
                                    <button class="btn btn-default col-lg-1" formaction="Var1Control" type="submit"><i class="fa fa-search"></i> Variation1</button>
                                    <button class="btn btn-default col-lg-1" formaction="Var2Control" type="submit"><i class="fa fa-search"></i> Variation2</button>
                                    <button class="btn btn-default col-lg-1" formaction="Var3Control" type="submit"><i class="fa fa-search"></i> Variation3</button>
                                </form>
                                <div class="row-items col-lg-12">
                                    <div class='mytext' align="center">Original Graph</div>
                                    <img class="photo" src="<%="tmpfiles/"+orgGraphName%>" onError="this.onerror=null;this.src='image/thumbnail_unavailable.jpg';"><br>
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

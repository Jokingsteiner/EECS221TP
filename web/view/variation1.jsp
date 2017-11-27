<%@ page import="java.util.*,tools.*" pageEncoding="ISO-8859-1"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
<base href="<%=basePath%>">
<head>
    <title>Variation1</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/sources/css/poster_list.css">
</head>

<body>
<jsp:include page="${pageContext.request.contextPath}/view/shared/Header.jsp" />
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
                            <h3 class="panel-title">Variation1</h3>
                        </div>
                        <div class="panel-body">
                            <%
                                Boolean error = (Boolean)request.getAttribute("error");
                                if(error != null && !error) {
                                    String orgGraphName = (String)this.getServletConfig().getServletContext().getAttribute("org_graph");
                                    String var1GraphName = (String)request.getAttribute("var1_graph");
                                    if(var1GraphName != null) {
                            %>
                                        <div class="row-items">
                                            <div class='mytext' align="center">Variation1</div></br>
                                            <div class="mytext">
                                                Find two edge-disjoint paths from s to t and have minimum total cost.
                                            </div>
                                            <img id="photo" src="<%="tmpfiles/"+var1GraphName%>" onError="this.onerror=null;this.src='image/thumbnail_unavailable.jpg';"><br>
                                        </div>
                                <%
                                    }
                                    if(orgGraphName != null) {
                                %>
                                        <div class="row-items">
                                            <div class='mytext' align="center">Original Graph</div>
                                            <img id="photo" src="<%="tmpfiles/"+orgGraphName%>" onError="this.onerror=null;this.src='image/thumbnail_unavailable.jpg';"><br>
                                        </div>
                                <%
                                    }
                                %>
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
<jsp:include page="${pageContext.request.contextPath}/view/shared/Scripts.jsp" />
</body>
</html>

<%@ page import="java.util.*,tools.*" pageEncoding="ISO-8859-1"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
<base href="<%=basePath%>">
<head>
    <title>Base Case</title>
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
                            <h3 class="panel-title">Base Case</h3>
                        </div>
                        <div class="panel-body">
                            <%
                                Boolean error = (Boolean)request.getAttribute("error");
                                if(error != null && !error) {
                                    String orgGraphName = (String)this.getServletConfig().getServletContext().getAttribute("org_graph");
                                    String baseGraphName = (String)request.getAttribute("base_graph");
                                    if(baseGraphName != null) {
                            %>
                                        <div class="row-items">
                                            <div class="mytext" align="center">Base Case</div></br>
                                            <div class="mytext">
                                                Given a directed graph G, a start node s and a terminate node t. We assign a weight cost w(E) for each edge E(u, v) with starting node u and end note v. The basic problem is to find edge-disjoint paths {P1, P2, ..., Pn} from s to t.
                                            </div>
                                            <img id="photo" src="<%="tmpfiles/"+baseGraphName%>" onError="this.onerror=null;this.src='image/thumbnail_unavailable.jpg';"><br>
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

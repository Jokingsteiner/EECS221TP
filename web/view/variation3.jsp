<%@ page import="java.util.LinkedList" %>
<%@ page import="java.util.ArrayList" %>
<%@ page pageEncoding="ISO-8859-1"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
<base href="<%=basePath%>">
<head>
    <title>Variation3</title>
    <link rel="stylesheet" href="sources/css/poster_list.css">
</head>

<body>
<jsp:include page="shared/Header.jsp" />
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
                            <h3 class="panel-title">Variation3</h3>
                        </div>
                        <div class="panel-body">
                            <%
                                Boolean error = (Boolean)request.getAttribute("error");
                                if(error != null && !error) {
                                    String var3GraphName = (String)request.getAttribute("var3_graph");
                                    ArrayList<LinkedList<Integer>> pathSet = (ArrayList<LinkedList<Integer>>)request.getAttribute("path_set");
                                    String source = (String)this.getServletConfig().getServletContext().getAttribute("source");
                                    String dest = (String)this.getServletConfig().getServletContext().getAttribute("dest");
                                    Integer pathCost = (Integer) request.getAttribute("path_cost");
                                    if(var3GraphName != null) {
                            %>
                                        <div class="row-items">
                                            <div class='mytext' align="center">Variation3</div><br>
                                            <div class="mytext">
                                                Find a set with maximum number of edge-disjoint paths <b>with minimum total cost.</b><br>
                                                <%
                                                    out.print("Found " + pathSet.size() + (pathSet.size()>1?" paths. ":" path. "));
                                                    out.print("Source = " + source + " Destination = " + dest + "<br>");
                                                    if (pathSet.size() != 0)
                                                        out.print("Path total cost: " + pathCost + "<br>");
                                                    int count = 0;
                                                    for (LinkedList<Integer> edjPath : pathSet) {
                                                        if (edjPath.size() != 0) {
                                                            out.print("Path" + ++count + ": ");
                                                            for (int idx = 0; idx < edjPath.size() - 1; ++idx) {
                                                                out.print(edjPath.get(idx) + " -> ");
                                                            }
                                                            out.print(edjPath.get(edjPath.size() - 1) + "<br>");
                                                        }
                                                    }
                                                %>
                                            </div>
                                            <img class="photo" src="<%="tmpfiles/"+var3GraphName%>" onError="this.onerror=null;this.src='image/thumbnail_unavailable.jpg';"><br>
                                        </div>
                            <%
                                    }
                                }
                            %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


</div>
<jsp:include page="shared/Scripts.jsp" />
</body>
</html>

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
    <title>Variation1</title>
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
                            <h3 class="panel-title">Variation1</h3>
                        </div>
                        <div class="panel-body">
                            <%
                                Boolean error = (Boolean)request.getAttribute("error");
                                if(error != null && !error) {
                                    String var1GraphName = (String)request.getAttribute("var1_graph");
                                    ArrayList<LinkedList<Integer>> pathSet = (ArrayList<LinkedList<Integer>>)request.getAttribute("path_set");
                                    String source = (String)this.getServletConfig().getServletContext().getAttribute("source");
                                    String dest = (String)this.getServletConfig().getServletContext().getAttribute("dest");
                                    Integer pathCost = (Integer) request.getAttribute("path_cost");
                                    boolean hasResult = true;
                                    if(var1GraphName != null) {
                            %>
                                        <div class="row-items">
                                            <div class='mytext' align="center">Variation1</div><br>
                                            <div class="mytext">
                                                Find <b>TWO</b> edge-disjoint paths from s to t that have minimum total cost.<br>
                                                <%
                                                    out.print("Source = " + source + " Destination = " + dest + "<br>");
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
                                                    if (count != 2) {
                                                        out.print("Can't found TWO edge-disjoint paths from " + source + " to " + dest + "<br>");
                                                        hasResult = false;
                                                    }
                                                    if (pathSet.size() != 0 && hasResult)
                                                        out.print("Path total cost: " + pathCost + "<br>");
                                                %>
                                            </div>
                                            <%if(hasResult) {%>
                                                <img class="photo" src="<%="tmpfiles/"+var1GraphName%>" onError="this.onerror=null;this.src='image/thumbnail_unavailable.jpg';"><br>
                                            <%
                                                }
                                            %>
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

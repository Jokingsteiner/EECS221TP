package controller;

import edu.uci.ics.jung.graph.Graph;
import tools.CustomEdge;
import tools.EdgeDisjointPath;
import tools.GraphVisualizer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedList;

@WebServlet("/Var2Control")

public class Var2Control extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        LinkedList<Integer[]> rawGraph = (LinkedList<Integer[]>)this.getServletConfig().getServletContext().getAttribute("raw_data");
        Integer src, dest;
        String s = request.getParameter("source");
        String t = request.getParameter("dest");
        if(s != null && !s.equals(""))
            this.getServletConfig().getServletContext().setAttribute("source", s);
        else
            s = (String)this.getServletConfig().getServletContext().getAttribute("source");
        if(t != null && !t.equals(""))
            this.getServletConfig().getServletContext().setAttribute("dest", t);
        else
            t = (String)this.getServletConfig().getServletContext().getAttribute("dest");
        if (rawGraph == null) {
            request.setAttribute("error",true);
            request.setAttribute("message", "Please upload csv file first");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
        // global s and t are still not set
        else if (s == null || s.equals("") || t == null || t.equals("")) {
            request.setAttribute("error",true);
            request.setAttribute("message", "Please select source and destination node");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
        else {
            if (s.equals(t)) {
                request.setAttribute("error",true);
                request.setAttribute("message", "Source and Destination node must be different");
                request.getRequestDispatcher("index.jsp").forward(request, response);
                return;
            }
            src = Integer.valueOf(s);
            dest = Integer.valueOf(t);
            EdgeDisjointPath edp = new EdgeDisjointPath(rawGraph);
            ArrayList<LinkedList<Integer>> hlPaths = edp.findMaxEdjPaths(null, src, dest);
            GraphVisualizer gv = new GraphVisualizer();
            Graph<Integer, CustomEdge> g = gv.createGraph(edp.getRawGraph());
            gv.colorEdges(g, hlPaths);
            String baseGraphPath = request.getServletContext().getAttribute("FILES_DIR")+ File.separator + "variation2.png";
            gv.saveGraph(null, baseGraphPath);
            request.setAttribute("error",false);
            request.setAttribute("message", "Variation2 result generated.");
            request.setAttribute("var2_graph", "variation2.png");
            request.setAttribute("path_set", hlPaths);
            request.setAttribute("path_cost", edp.getPathSetCost(g, hlPaths));
            request.getRequestDispatcher("view/variation2.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}

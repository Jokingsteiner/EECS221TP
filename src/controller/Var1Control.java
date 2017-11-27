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

@WebServlet("/Var1Control")

public class Var1Control extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        LinkedList<Integer[]> rawGraph = (LinkedList<Integer[]>)this.getServletConfig().getServletContext().getAttribute("raw_data");
        Integer src, dest;
        String s = request.getParameter("source");
        String t = request.getParameter("dest");
        if(s != null && !s.equals("")) {
            src = Integer.valueOf(s);
            this.getServletConfig().getServletContext().setAttribute("source", s);
        }
        else
            src = (Integer)this.getServletConfig().getServletContext().getAttribute("source");
        if(t != null && !t.equals("")) {
            dest = Integer.valueOf(t);
            this.getServletConfig().getServletContext().setAttribute("dest", t);
        }
        else
            dest = (Integer)this.getServletConfig().getServletContext().getAttribute("dest");
        if (rawGraph == null) {
            request.setAttribute("error",true);
            request.setAttribute("message", "Please upload csv file first");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
        else if (src == null || dest == null) {
            request.setAttribute("error",true);
            request.setAttribute("message", "Please select source and destination node");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
        else {
            EdgeDisjointPath edp = new EdgeDisjointPath(rawGraph);
            ArrayList<LinkedList<Integer>> hlPaths = edp.findSuurballePaths(null, src, dest);
            GraphVisualizer gv = new GraphVisualizer();
            Graph<Integer, CustomEdge> g = gv.createGraph(edp.getRawGraph());
            gv.colorEdges(g, hlPaths);
            String baseGraphPath = request.getServletContext().getAttribute("FILES_DIR")+ File.separator + "variation1.png";
            gv.saveGraph(null, baseGraphPath);
            request.setAttribute("error",false);
            request.setAttribute("message", "Base case result generated.");
            request.setAttribute("var1_graph", "variation1.png");
            request.getRequestDispatcher("view/variation1.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}

package controller;

import tools.CSVParser;
import tools.GraphVisualizer;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedList;

@WebServlet("/SampleControl")

public class SampleControl extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String sampleFileName = request.getParameter("sample_name");
        if (sampleFileName != null && !sampleFileName.equals("")) {
            String contextPath = this.getServletContext().getRealPath(File.separator);
            String samplePath = contextPath + File.separator + "sampledata" + File.separator + sampleFileName;
            CSVParser cp = new CSVParser(samplePath);
            GraphVisualizer gv = new GraphVisualizer();
            LinkedList<Integer[]> rawGraph = cp.parse();
            gv.createGraph(rawGraph);
            ArrayList<Integer> nodeList = cp.getNodeList();
            String orgGraphPath = request.getServletContext().getAttribute("FILES_DIR") + File.separator + "original.png";
            gv.saveGraph(null, orgGraphPath);
            request.setAttribute("error", false);
            request.setAttribute("message", sampleFileName + " is loaded.");
            this.getServletConfig().getServletContext().setAttribute("org_graph", "original.png");
            this.getServletConfig().getServletContext().setAttribute("node_list", nodeList);
            this.getServletConfig().getServletContext().setAttribute("uploaded", true);
            // reset global source and dest
            this.getServletConfig().getServletContext().setAttribute("source", "");
            this.getServletConfig().getServletContext().setAttribute("dest", "");
            this.getServletConfig().getServletContext().setAttribute("raw_data", rawGraph);
        }
        else {
            request.setAttribute("error", true);
            request.setAttribute("message", "Failed to load sample data.");
        }
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
}

package controller;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import tools.CSVParser;
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
import java.util.List;

@WebServlet("/UploadControl")

public class UploadControl extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fileName = null;
        //process only if its multipart content
        if(ServletFileUpload.isMultipartContent(request)){
            try {
                List<FileItem> multiparts = new ServletFileUpload(
                        new DiskFileItemFactory()).parseRequest(request);

                for(FileItem item : multiparts){
                    if(!item.isFormField()){
                        fileName = item.getName();
                        String[] splitStr = fileName.split("\\.", 0);
                        if(!splitStr[splitStr.length-1].equals("csv")) {
                            request.setAttribute("error",true);
                            request.setAttribute("message", "You must upload a *.csv file.");
                            request.getRequestDispatcher("/index.jsp").forward(request, response);
                            return;
                        }
                        item.write( new File(request.getServletContext().getAttribute("FILES_DIR")+ File.separator + fileName));
                    }
                }
                //File uploaded successfully
                CSVParser cp = new CSVParser(request.getServletContext().getAttribute("FILES_DIR")+ File.separator + fileName);
                GraphVisualizer gv = new GraphVisualizer();
                LinkedList<Integer[]> rawGraph = cp.parse();
                gv.createGraph(rawGraph);
                ArrayList<Integer> nodeList = cp.getNodeList();
                String orgGraphPath = request.getServletContext().getAttribute("FILES_DIR")+ File.separator + "original.png";
                System.out.println("orgGraphPath = " + orgGraphPath);
                gv.saveGraph(null, orgGraphPath);
                request.setAttribute("error",false);
                request.setAttribute("message", "File Uploaded Successfully");
                this.getServletConfig().getServletContext().setAttribute("org_graph", "original.png");
                this.getServletConfig().getServletContext().setAttribute("node_list", nodeList);
                this.getServletConfig().getServletContext().setAttribute("uploaded", true);
                this.getServletConfig().getServletContext().setAttribute("raw_data", rawGraph);

            } catch (Exception ex) {
                request.setAttribute("error",true);
                request.setAttribute("message", "File Upload Failed due to " + ex);
            }
        }
        else{
            request.setAttribute("error",true);
            request.setAttribute("message", "Sorry this Servlet only handles file upload request");
        }
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
}

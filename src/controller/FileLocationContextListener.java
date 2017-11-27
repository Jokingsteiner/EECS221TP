package controller;

import org.apache.commons.io.FileUtils;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

/**
 * Reference: https://www.javacodegeeks.com/2013/08/servlet-upload-file-and-download-file-example.html
 * Thanks for providing a great code snippet
 */


@WebListener
public class FileLocationContextListener implements ServletContextListener {

    public void contextInitialized(ServletContextEvent servletContextEvent) {
        String rootPath = System.getProperty("catalina.home");
        ServletContext ctx = servletContextEvent.getServletContext();
        String relativePath = ctx.getInitParameter("tempfile.dir");
        String contextPath = ctx.getRealPath(File.separator);
        String filePath = contextPath + File.separator + relativePath;
        File file = new File(filePath);
        if(!file.exists()) file.mkdirs();
        System.out.println("File Directory created..");
        ctx.setAttribute("FILES_DIR_FILE", file);
        // store the FILES_DIR at the server
        ctx.setAttribute("FILES_DIR", filePath);
    }

    public void contextDestroyed(ServletContextEvent servletContextEvent) {
        try {
            String rootPath = System.getProperty("catalina.home");
            ServletContext ctx = servletContextEvent.getServletContext();
            String relativePath = ctx.getInitParameter("tempfile.dir");
            String contextPath = ctx.getRealPath(File.separator);
            String filePath = contextPath + File.separator + relativePath;
            FileUtils.deleteDirectory(new File(filePath));
        } catch (IOException e) {
            System.out.println("Delete tempfile folder failed.");
        }
    }
}
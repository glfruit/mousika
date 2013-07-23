package com.sanwn.mousika.ckfinder;

import com.ckfinder.connector.ConnectorServlet;
import com.ckfinder.connector.ServletContextFactory;
import com.ckfinder.connector.configuration.Configuration;
import com.ckfinder.connector.configuration.ConfigurationFactory;
import com.ckfinder.connector.configuration.IConfiguration;
import com.ckfinder.connector.utils.AccessControlUtil;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import java.lang.reflect.Method;

/**
 * @author glix
 * @version 1.0
 */
public class MousikaServlet extends ConnectorServlet {

    private Exception initException;

    @Override
    public void init() throws ServletException {
        try {
            Method method = ServletContextFactory.class.getDeclaredMethod("setServletContext", ServletContext.class);
            method.setAccessible(true);
            method.invoke(null, getServletContext());
        } catch (Exception e) {
            throw new ExceptionInInitializerError("failed to set servlet context");
        }
        IConfiguration configuration = null;
        try {
            configuration = new MousikaConfiguration(getServletConfig());
        } catch (Exception e) {
            configuration = new Configuration(getServletConfig());
        }
        try {
            configuration.init();
            AccessControlUtil.getInstance(configuration).loadACLConfig();
        } catch (Exception e) {
            if (Boolean.valueOf(getServletConfig().getInitParameter("debug"))) {
                e.printStackTrace();
            }
            this.initException = e;
            configuration = null;
        }
        ConfigurationFactory.getInstace().setConfiguration(configuration);
    }
}

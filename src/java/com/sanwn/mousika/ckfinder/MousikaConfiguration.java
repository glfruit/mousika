package com.sanwn.mousika.ckfinder;

import com.ckfinder.connector.configuration.Configuration;
import org.apache.shiro.SecurityUtils;

import javax.servlet.ServletConfig;

/**
 * @author glix
 * @version 1.0
 */
public class MousikaConfiguration extends Configuration {
    /**
     * Constructor.
     *
     * @param servletConfig servlet config to get parameters from web-xml
     */
    public MousikaConfiguration(ServletConfig servletConfig) {
        super(servletConfig);
    }

    @Override
    public String getBaseURL() {
        String principal = (String) SecurityUtils.getSubject().getPrincipal();
        return this.baseURL + principal;
    }
}

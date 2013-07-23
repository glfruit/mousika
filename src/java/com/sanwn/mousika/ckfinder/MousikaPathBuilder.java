package com.sanwn.mousika.ckfinder;

import com.ckfinder.connector.configuration.ConfigurationPathBuilder;
import org.apache.shiro.SecurityUtils;

import javax.servlet.http.HttpServletRequest;

/**
 * @author glix
 * @version 1.0
 */
public class MousikaPathBuilder extends ConfigurationPathBuilder {

    @Override
    public String getBaseUrl(final HttpServletRequest request) {
        String baseUrl = super.getBaseUrl(request);
        String principal = (String) SecurityUtils.getSubject().getPrincipal();
        return baseUrl + principal;
    }
}

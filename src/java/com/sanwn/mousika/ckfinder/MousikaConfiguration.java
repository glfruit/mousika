package com.sanwn.mousika.ckfinder;

import com.ckfinder.connector.configuration.Configuration;
import com.sanwn.mousika.FileRepository;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;

import javax.servlet.ServletConfig;
import javax.servlet.http.HttpServletRequest;

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
        Session session = SecurityUtils.getSubject().getSession();
        String repoType = (String) session.getAttribute(FileRepository.REPOSITORY_TYPE);
        String repoPath = (String) session.getAttribute(FileRepository.REPOSITORY_PATH);
        if (FileRepository.REPOSITORY_TYPE_FILE.equals(repoType)) {
            return this.baseURL + "users/" + repoPath;
        } else if (FileRepository.REPOSITORY_TYPE_COURSE.equals(repoType)) {
            return this.baseURL + "courses/" + repoPath;
        }
        throw new IllegalStateException("未指定文件库类型或路径");
    }

    @Override
    public boolean checkAuthentication(final HttpServletRequest request) {
        return SecurityUtils.getSubject().isAuthenticated();
    }

}

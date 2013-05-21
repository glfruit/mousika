<%@ page import="com.sanwn.mousika.domain.Page" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName"
               value="${message(code: 'page.label', default: 'Page')}"/>
        <title><g:message code="default.show.label"
                          args="[entityName]"/></title>
    </head>

    <body>
        <a href="#show-page" class="skip" tabindex="-1"><g:message
                code="default.link.skip.label"
                default="Skip to content&hellip;"/></a>

        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message
                        code="default.home.label"/></a></li>
                <li><g:link class="list" action="list"><g:message
                        code="default.list.label"
                        args="[entityName]"/></g:link></li>
                <li><g:link class="create" action="create"><g:message
                        code="default.new.label"
                        args="[entityName]"/></g:link></li>
            </ul>
        </div>

        <div id="show-page" class="content scaffold-show" role="main">
            <h1><g:message code="default.show.label" args="[entityName]"/></h1>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <ol class="property-list page">

                <g:if test="${pageInstance?.title}">
                    <li class="fieldcontain">
                        <span id="title-label" class="property-label"><g:message
                                code="page.title.label" default="Title"/></span>

                        <span class="property-value"
                              aria-labelledby="title-label">
                            <g:fieldValue bean="${pageInstance}"
                                          field="title"/></span>

                    </li>
                </g:if>

                <g:if test="${pageInstance?.content}">
                    <li class="fieldcontain">
                        <span id="content-label"
                              class="property-label"><g:message
                                code="page.content.label"
                                default="Content"/></span>

                        <span class="property-value"
                              aria-labelledby="content-label">
                            ${org.apache.commons.lang.StringEscapeUtils.unescapeHtml(pageInstance.description)}
                        </span>

                    </li>
                </g:if>

                <g:if test="${pageInstance?.description}">
                    <li class="fieldcontain">
                        <span id="description-label"
                              class="property-label"><g:message
                                code="page.description.label"
                                default="Description"/></span>

                        <span class="property-value"
                              aria-labelledby="description-label">
                            ${pageInstance.content}
                            %{--${org.apache.commons.lang.StringEscapeUtils.unescapeHtml(pageInstance.content)}--}%
                        </span>

                    </li>
                </g:if>

                <g:if test="${pageInstance?.sequence}">
                    <li class="fieldcontain">
                        <span id="sequence-label"
                              class="property-label"><g:message
                                code="page.sequence.label"
                                default="Sequence"/></span>

                        <span class="property-value"
                              aria-labelledby="sequence-label"><g:fieldValue
                                bean="${pageInstance}" field="sequence"/></span>

                    </li>
                </g:if>

            </ol>
            <g:form>
                <fieldset class="buttons">
                    <g:hiddenField name="id" value="${pageInstance?.id}"/>
                    <g:link class="edit" action="edit"
                            id="${pageInstance?.id}"><g:message
                            code="default.button.edit.label"
                            default="Edit"/></g:link>
                    <g:actionSubmit class="delete" action="delete"
                                    value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                                    onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
                </fieldset>
            </g:form>
        </div>
    </body>
</html>

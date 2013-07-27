<%@ page import="com.sanwn.mousika.Label" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName"
               value="${message(code: 'label.label', default: 'Label')}"/>
        <title><g:message code="default.show.label"
                          args="[entityName]"/></title>
    </head>

    <body>
        <a href="#show-label" class="skip" tabindex="-1"><g:message
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

        <div id="show-label" class="content scaffold-show" role="main">
            <h1><g:message code="default.show.label" args="[entityName]"/></h1>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <ol class="property-list label">

                <g:if test="${labelInstance?.labelContent}">
                    <li class="fieldcontain">
                        <span id="labelContent-label"
                              class="property-label"><g:message
                                code="label.labelContent.label"
                                default="Label Content"/></span>

                        <span class="property-value"
                              aria-labelledby="labelContent-label"><g:fieldValue
                                bean="${labelInstance}"
                                field="labelContent"/></span>

                    </li>
                </g:if>

                <g:if test="${labelInstance?.section}">
                    <li class="fieldcontain">
                        <span id="section-label"
                              class="property-label"><g:message
                                code="label.section.label"
                                default="Section"/></span>

                        <span class="property-value"
                              aria-labelledby="section-label"><g:link
                                controller="courseUnit" action="show"
                                id="${labelInstance?.section?.id}">${labelInstance?.section?.encodeAsHTML()}</g:link></span>

                    </li>
                </g:if>

                <g:if test="${labelInstance?.sequence}">
                    <li class="fieldcontain">
                        <span id="sequence-label"
                              class="property-label"><g:message
                                code="label.sequence.label"
                                default="Sequence"/></span>

                        <span class="property-value"
                              aria-labelledby="sequence-label"><g:fieldValue
                                bean="${labelInstance}"
                                field="sequence"/></span>

                    </li>
                </g:if>

                <g:if test="${labelInstance?.title}">
                    <li class="fieldcontain">
                        <span id="title-label" class="property-label"><g:message
                                code="label.title.label"
                                default="Title"/></span>

                        <span class="property-value"
                              aria-labelledby="title-label"><g:fieldValue
                                bean="${labelInstance}" field="title"/></span>

                    </li>
                </g:if>

            </ol>
            <g:form>
                <fieldset class="buttons">
                    <g:hiddenField name="id" value="${labelInstance?.id}"/>
                    <g:link class="edit" action="edit"
                            id="${labelInstance?.id}"><g:message
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

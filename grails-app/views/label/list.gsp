<%@ page import="com.sanwn.mousika.Label" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName"
               value="${message(code: 'label.label', default: 'Label')}"/>
        <title><g:message code="default.list.label"
                          args="[entityName]"/></title>
    </head>

    <body>
        <a href="#list-label" class="skip" tabindex="-1"><g:message
                code="default.link.skip.label"
                default="Skip to content&hellip;"/></a>

        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message
                        code="default.home.label"/></a></li>
                <li><g:link class="create" action="create"><g:message
                        code="default.new.label"
                        args="[entityName]"/></g:link></li>
            </ul>
        </div>

        <div id="list-label" class="content scaffold-list" role="main">
            <h1><g:message code="default.list.label" args="[entityName]"/></h1>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <table>
                <thead>
                    <tr>

                        <g:sortableColumn property="labelContent"
                                          title="${message(code: 'label.labelContent.label', default: 'Label Content')}"/>

                        <th><g:message code="label.section.label"
                                       default="Section"/></th>

                        <g:sortableColumn property="sequence"
                                          title="${message(code: 'label.sequence.label', default: 'Sequence')}"/>

                        <g:sortableColumn property="title"
                                          title="${message(code: 'label.title.label', default: 'Title')}"/>

                    </tr>
                </thead>
                <tbody>
                    <g:each in="${labelInstanceList}" status="i"
                            var="labelInstance">
                        <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                            <td><g:link action="show"
                                        id="${labelInstance.id}">${fieldValue(bean: labelInstance, field: "labelContent")}</g:link></td>

                            <td>${fieldValue(bean: labelInstance, field: "section")}</td>

                            <td>${fieldValue(bean: labelInstance, field: "sequence")}</td>

                            <td>${fieldValue(bean: labelInstance, field: "title")}</td>

                        </tr>
                    </g:each>
                </tbody>
            </table>

            <div class="pagination">
                <g:paginate total="${labelInstanceTotal}"/>
            </div>
        </div>
    </body>
</html>

<%@ page import="com.sanwn.mousika.domain.Course" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName"
               value="${message(code: 'course.label', default: 'Course')}"/>
        <title><g:message code="default.list.label"
                          args="[entityName]"/></title>
    </head>

    <body>
        <h4 style="border-bottom: 1px solid #000;color: #777777;"><g:message
                code="label.course.list"/></h4>
        <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
        </g:if>
        <ul class="thumbnails">
            <g:each in="${courseInstanceList}" status="i"
                    var="courseInstance">
                <li class="span6">
                    <div class="thumbnail">
                        <div class="container">
                            <div class="row">
                                <div class="span2">
                                    <h4>
                                        <g:link action="show"
                                                id="${courseInstance.id}">
                                            ${fieldValue(bean: courseInstance, field: "title")}
                                        </g:link>
                                    </h4>

                                    <p>教师：${fieldValue(bean: courseInstance, field: "author")}</p> <!-- TODO: 将教师链接到个人信息页面 -->
                                </div>

                                <div class="span4">
                                    <p>${fieldValue(bean: courseInstance, field: "description")}</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </li>
            </g:each>
        </ul>
    </body>
</html>

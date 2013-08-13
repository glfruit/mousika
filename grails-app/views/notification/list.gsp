<%@ page import="com.sanwn.mousika.Role; org.apache.commons.lang.StringEscapeUtils; com.sanwn.mousika.User; com.sanwn.mousika.Course" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="course"/>
        <title>${course?.title}-课程通知</title>
    </head>

    <body>
        <g:if test="${course}">
            <ul class="breadcrumb" style="margin-top: 20px;">
                <li>
                    <a href="${createLink(controller: 'course', action: 'show', id: course?.id)}">${course?.title}</a>
                    <span class="divider">/</span>
                </li>
                <li class="active">课程通知</li>
            </ul>
        </g:if>
        <g:else>
            <h3 style="text-align: center;">新闻通知</h3>
        </g:else>
        <shiro:hasPermission permission="course:create:${course?.id}">
            <a class="btn" style="margin-top: 10px;"
               href="${createLink(controller: 'notification', action: 'create', params: [courseId: course?.id])}">发布通知</a>
        </shiro:hasPermission>
        <table class="table table-striped" style="margin-top: 10px;">
            <thead>
                <tr>
                    <th>标题</th>
                    <th>发布时间</th>
                </tr>
            </thead>
            <tbody>
                <g:each in="${notifications}" var="notification">
                    <tr>
                        <td><a href="${createLink(controller: 'notification', action: 'show', id: notification.id, params: [courseId: course?.id])}">${notification.title}</a>
                        </td>
                        <td>
                            <g:formatDate date="${notification.dateCreated}"
                                          format="yyyy-MM-dd HH:mm"/>
                        </td>
                    </tr>
                </g:each>
            </tbody>
        </table>
        <shiro:hasPermission permission="course:create:${course?.id}">
            <a class="btn"
               href="${createLink(controller: 'notification', action: 'create', params: [courseId: course?.id])}">发布通知</a>
        </shiro:hasPermission>
        <mousika:paginate controller="notification"
                          class="pagination pagination-centered"
                          action="list"
                          total="${total}"/>
        <div style="clear:both;"></div>
    </body>
</html>

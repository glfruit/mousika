<%@ page import="com.sanwn.mousika.Role; org.apache.commons.lang.StringEscapeUtils; com.sanwn.mousika.User; com.sanwn.mousika.Course" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="course"/>
        <title>${course?.title}-课程通知</title>
    </head>

    <body>
        <ul class="breadcrumb" style="margin-top: 20px;">
            <li>
                <a href="${createLink(controller: 'course', action: 'show', id: course?.id)}">${course?.title}</a>
                <span class="divider">/</span>
            </li>
            <li class="active">课程通知</li>
        </ul>
        <a class="btn" style="margin-top: 10px;" href="${createLink(controller: 'notification', action: 'create',params:[courseId:course?.id])}">发布通知</a>
        <table class="table table-striped" style="max-resolution: 10px;">
            <thead>
                <tr>
                    <th>标题</th>
                    <th>发布时间</th>
                </tr>
            </thead>
            <tbody>
                <g:each in="${notifications}" var="notification">
                    <tr>
                        <td><a href="${createLink(controller: 'notification', action: 'show', id: notification.id, params:[courseId:course?.id])}">${notification.title}</a>
                        </td>
                        <td>
                            <g:formatDate date="${notification.dateCreated}"
                                          format="yyyy-MM-dd HH:mm"/>
                        </td>
                    </tr>
                </g:each>
            </tbody>
        </table>
        <a class="btn" href="${createLink(controller: 'notification', action: 'create',params:[courseId:course?.id])}">发布通知</a>
        <mousika:paginate controller="notification"
                          class="pagination pagination-centered"
                          action="list"
                          total="${total}"/>
        <div style="clear:both;"></div>
    </body>
</html>

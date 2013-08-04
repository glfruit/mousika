<%@ page import="com.sanwn.mousika.Label" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="course">
        <style type="text/css">
        table.fixed {
            table-layout: fixed;
        }

        table.fixed td {
            overflow: hidden;
        }
        </style>
        <title>${forum.title}</title>
    </head>

    <body>
        <div id="list-user" class="content scaffold-show" role="main">
            <h4 style="text-align: center;">${forum.title}</h4>
            <table class="table table-bordered fixed">
                <col width="180px"/>
                <col width="30px"/>
                <col width="55px"/>
                <col width="50"/>
                <thead style="background-color: #F7F7F9;">
                    <tr>
                        <th>主题</th>
                        <th>作者</th>
                        <th>回复数/浏览次数</th>
                        <th>最后回复</th>
                    </tr>
                </thead>
                <tbody>
                    <g:each in="${forum.posts}" var="post">
                        <tr>
                            <td>
                                <a href="${createLink(mapping: 'post', params: [courseId: params.courseId, forumId: params.id, id: post.id])}">
                                    ${post.title}</a></td>
                            <td>${post.postedBy.fullname}</td>
                            <td>${post.replies.size()}/100</td>
                            <td>${post.lastUpdated}</td>
                            %{--<td><g:formatDate format="yyyy-MM-dd HH:mm:ss"--}%
                            %{--date="${user.profile?.firstAccessed}"/></td>--}%
                            %{--<td><g:formatDate format="yyyy-MM-dd HH:mm:ss"--}%
                            %{--date="${user.profile?.lastAccessed}"/></td>--}%
                        </tr>
                    </g:each>
                </tbody>
            </table>
            <g:paginate total="total" mapping="post" prev="&lt;"
                        max="20"
                        next="&gt;"></g:paginate>
            <a class="btn"
               href="${request.contextPath}/course/${params.courseId}/forum/${params.id}/post/create">发表新帖</a>
        </div>
    </body>
</html>

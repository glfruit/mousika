<html>
    <head>
        <meta name="layout" content="course"/>
        <title>${post.title}</title>
    </head>

    <body>
        <p style="padding-top: 20px;">
            <a href="${createLink(mapping: 'forum', params: [courseId: params.courseId, id: params.forumId])}">${post.forum.title}</a>->${post.title}
        </p>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <td colspan="2"
                        style="text-align: center;background-color: #DEE3E7;">主题：${post.title}</td>
                </tr>
                <tr>
                    <td style="text-align: center;background-color: #777777;">作者</td>
                    <td style="text-align: center;background-color: #777777;">正文</td>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td style="background-color: #DEE3E7;">${post.postedBy.fullname}
                        ${post.postedBy.profile?.photo}</td>
                    <td style="background-color: #DEE3E7;">
                        <%=post.postContent%>
                        <a href="${createLink(mapping: 'attachmentDownload',
                                params: [courseId: params.courseId, forumId: params.forumId, postId: params.id, id: post.attachment])}">${post.attachment}</a>
                    </td>
                </tr>
            </tbody>
        </table>
    </body>
</html>

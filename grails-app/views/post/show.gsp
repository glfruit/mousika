<html>
    <head>
        <meta name="layout" content="course"/>
        <title>${post.title}</title>
    </head>

    <body>
        <p style="padding-top: 20px;">
            <a href="${createLink(controller: 'course', action: 'show', id: params.courseId)}">${post.forum.course.title}</a>-><a
                href="${createLink(mapping: 'forum', params: [courseId: params.courseId, id: params.forumId])}">${post.forum.title}</a>->${post.title}
        </p>
        <table class="table table-bordered fixed">
            <col width="100px"/>
            <col width="300px"/>
            <thead>
                <tr>
                    <td colspan="2"
                        style="text-align: center;background-color: #DEE3E7;">主题：${post.title}</td>
                </tr>
                <tr>
                    <td style="text-align: center;background-color: #777777;color: white;">作者</td>
                    <td style="text-align: center;background-color: #777777; color: white;">正文</td>
                </tr>
            </thead>
            <tbody>
                <g:if test="${params.int('offset') == 0}">
                    <tr>
                        <td style="background-color: #DEE3E7;">
                            <g:if test="${post.postedBy.profile?.photo}">
                                ${post.postedBy.profile?.photo}
                            </g:if>
                            <g:else>
                                <g:img dir="images" file="profile.png"
                                       height="60"
                                       width="60" class="img-polaroid"/>
                            </g:else>
                            ${post.postedBy.fullname}
                        </td>
                        <td style="background-color: #DEE3E7;">
                            <p class="post-content-title">
                                发表时间：<g:formatDate date="${post.dateCreated}"
                                                   format="yyyy-MM-dd HH:mm:ss"/>
                                <g:if test="${post.dateCreated < post.lastModified}">
                                    更新于：<g:formatDate date="${post.lastModified}"
                                                      format="yyyy-MM-dd HH:mm:ss"/>
                                </g:if>
                            </p>
                            <%=post.postContent%>
                            <g:if test="${post.attachment}">
                                附件：
                                <a href="${createLink(mapping: 'attachmentDownload',
                                        params: [courseId: params.courseId, forumId: params.forumId, postId: params.id, id: post.attachment])}">${post.attachment}</a>
                            </g:if>
                        </td>
                    </tr>
                </g:if>
                <g:each in="${replies}" var="reply">
                    <tr>
                        <td style="background-color: #DEE3E7;">
                            <g:if test="${reply.repliedBy.profile?.photo}">
                                ${reply.repliedBy.profile?.photo}
                            </g:if>
                            <g:else>
                                <g:img dir="images" file="profile.png"
                                       height="60"
                                       width="60" class="img-polaroid"/>
                            </g:else>
                            ${reply.repliedBy.fullname}
                            ${reply.repliedBy.profile?.photo}</td>
                        <td style="background-color: #DEE3E7;">
                            <p class="post-reply-content-title">回复时间：<g:formatDate
                                    date="${reply.dateCreated}"
                                    format="yyyy-MM-dd HH:mm:ss"/>
                            <g:if test="${reply.dateCreated < reply.lastUpdated}">
                                最后更新时间：<g:formatDate date="${reply.lastUpdated}"
                                                     format="yyyy-MM-dd HH:mm:ss"/>
                            </g:if>
                            </p>
                            <%=reply.replyContent%>
                            <g:if test="${reply.attachment}">
                                附件：
                                <a href="${createLink(mapping: 'replyAttachmentDownload',
                                        params: [courseId: params.courseId, forumId: params.forumId, postId: params.id,
                                                replyId: reply.id, id: reply.attachment])}">${reply.attachment}</a>
                            </g:if>
                        </td>
                    </tr>
                </g:each>
            </tbody>
        </table>

        <p>
            <mousika:paginate total="${total}" mapping="post"
                              class="pagination pagination-centered"
                              params="[courseId: post.forum.course.id, forumId: post.forum.id, id: post.id]"/>
        </p>
        <a href="${createLink(mapping: 'reply', params: [courseId: params.courseId, forumId: params.forumId, id: params.id])}"
           class="btn">发表回复</a>

        <div class="pull-right">
            <g:form controller="reply" action="save">
                <g:submitButton name="quickReplyBtn"
                                class="btn btn-primary pull-top-left"
                                value="快速回复"/>
                <g:hiddenField name="quickReply" value="true"/>
                <g:hiddenField name="postId" value="${post.id}"/>
                <g:textArea name="replyContent"
                            style="width: 400px;height: 180px;max-resolution: 5px;"/>
            </g:form>
        </div>
    </body>
</html>

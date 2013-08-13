<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="course">
        <mousika:editor/>
        <title><g:message code="reply.create.label"/></title>
    </head>

    <body>
        <div id="create-post-reply" class="content scaffold-create" role="main">
            <p style="padding-top: 20px;">
                <a href="${createLink(controller: 'course', action: 'show', id: params.courseId)}">${post.forum.course.title}</a>->
                <a href="${createLink(mapping: 'forum', params: [courseId: params.courseId, id: params.forumId])}">${post.forum.title}</a>->
                <a href="${createLink(mapping: 'post', params: [courseId: params.courseId, forumId: params.forumId, id: params.id])}">${post.title}</a>
            </p>
            <h4 style="text-align: center;padding-bottom:3px;border-bottom: 1px #DEE3E7 solid;">回复主题：${post.title}</h4>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${reply}">
                <ul class="errors" role="alert">
                    <g:eachError bean="${reply}" var="error">
                        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                                error="${error}"/></li>
                    </g:eachError>
                </ul>
            </g:hasErrors>
            <g:uploadForm action="save" class="form-horizontal">
                <fieldset class="form">
                    <f:with bean="reply">
                        <g:hiddenField name="postId"
                                       value="${params.id}"/>
                        <f:field property="replyContent" required="true"/>
                        <f:field property="attachment"/>
                    </f:with>
                </fieldset>
                <fieldset class="buttons">
                    <div style="text-align: center;">
                        <g:submitButton name="create" class="btn btn-primary"
                                        value="${message(code: 'default.submit.label')}"/>
                        <a class="btn"
                           href="${createLink(mapping: 'post', params: [courseId: params.courseId, forumId: params.forumId, id: params.id])}">${message(code: 'default.cancel.label')}</a>
                    </div>
                </fieldset>
            </g:uploadForm>
        </div>
    </body>
</html>

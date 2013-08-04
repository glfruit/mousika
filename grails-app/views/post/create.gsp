<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="course">
        <g:javascript src="../tiny_mce/tiny_mce.js"/>
        <r:script>
            tinyMCE.init({
                mode: "textareas",
                theme: "advanced",
                language: "cn",
                plugins: "autoresize,autosave,emotions,contextmenu,fullscreen,inlinepopups,preview",
                theme_advanced_buttons3_add: "emotions",
                theme_advanced_buttons3_add: "fullscreen",
                fullscreen_new_window: true,
                fullscreen_settings: {
                    theme_advanced_path_location: "top"
                },
                dialog_type: "modal",
                theme_advanced_buttons3_add: "preview",
                plugin_preview_width: "500",
                plugin_preview_height: "600"
            });
        </r:script>
        <title><g:message code="post.create.label"/></title>
    </head>

    <body>
        <div id="create-post" class="content scaffold-create" role="main">
            <h4><g:message code="post.create.label"/></h4>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${post}">
                <ul class="errors" role="alert">
                    <g:eachError bean="${post}" var="error">
                        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                                error="${error}"/></li>
                    </g:eachError>
                </ul>
            </g:hasErrors>
            <g:uploadForm action="save" class="form-horizontal">
                <fieldset class="form">
                    <f:with bean="post">
                        <g:hiddenField name="courseId"
                                       value="${params.courseId}"/>
                        <g:hiddenField name="forumId" value="${params.forumId}"/>
                        <f:field property="title" required="true"/>
                        <f:field property="postContent" required="true"/>
                        <f:field property="attachment"/>
                    </f:with>
                </fieldset>
                <fieldset class="buttons">
                    %{--<g:render template="/uploader"/>--}%
                    <div style="text-align: center;">
                        <g:submitButton name="create" class="btn btn-primary"
                                        value="${message(code: 'default.submit.label')}"/>
                        <a class="btn"
                           href="${createLink(mapping: 'forum', params: [courseId: params.courseId, id: params.forumId])}">${message(code: 'default.cancel.label')}</a>
                    </div>
                </fieldset>
            </g:uploadForm>
        </div>
    </body>
</html>

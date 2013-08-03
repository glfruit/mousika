<html>
    <head>
        <meta name="layout" content="course"/>
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
        <title>批改作业</title>
        <style>
        li {
            cursor: text;
        }
        </style>
    </head>

    <body>
        <h4 style="border-bottom: 1px solid #000;color: #777777;">
            作业打分
        </h4>
        <g:if test="${flash.message}">
            <div class="text-success" role="status">${flash.message}</div>
        </g:if>
        <h4>${attempt.assignment.title}</h4>

        <p><%=attempt.assignment.description%></p>
        <g:hasErrors bean="${attempt}">
            <ul class="errors" role="alert">
                <g:eachError bean="${attempt}" var="error">
                    <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                            error="${error}"/></li>
                </g:eachError>
            </ul>
        </g:hasErrors>
        <g:form class="form-horizontal" action="save">
            <f:with bean="attempt">
                <g:hiddenField name="courseId" value="${params.id}"/>
                <g:hiddenField name="attemptId" value="${attempt.id}"/>
                <g:hiddenField name="assignmentItemId" value="${assignmentItemId}"/>
                <f:field property="score"/>
                <div class="control-group">
                    <label class="control-label" for="suggestion">
                        ${message(code:'attempt.feedback.suggestion.label')}
                    </label>

                    <div class="controls">
                        <g:textArea name="suggestion" value="${attempt.feedback?.suggestion}" rows="10" />
                    </div>
                </div>
            </f:with>
            <div class="control-group pagination-centered">
                <g:submitButton id="evaluate-assignment-btn"
                                name="evaluate-assignment-btn"
                                class="btn btn-primary"
                                value="${message(code: 'assignment.evaluate.label')}"/>
                <a class="btn"
                   href="${createLink(action: 'show', id: params.id, params: [assignmentItemId: params.assignmentItemId])}">取消</a>
            </div>
        </g:form>
    %{--<ul>--}%
    %{--<li>作业名称：${attempt.assignment.title}</li>--}%
    %{--<li>作业内容：<%=attempt.assignment.description%></li>--}%
    %{--<li>回答：<%=attempt.attemptContent%></li>--}%
    %{--<li>成绩：<input type="text"></li>--}%
    %{--<li>评语：<g:textArea name="feedback.suggestion" rows="10"--}%
    %{--value="${attempt.feedback?.suggestion}"/></li>--}%
    %{--</ul>--}%
    </body>
</html>

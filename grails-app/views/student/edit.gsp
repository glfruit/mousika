<%@ page import="com.sanwn.mousika.Course" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="student"/>
        <title><g:message code="course.edit.label"/></title>
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
    </head>

    <body>
        <div id="edit-course" class="content scaffold-create" role="main">
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${courseInstance}">
                <ul class="errors" role="alert">
                    <g:eachError bean="${courseInstance}" var="error">
                        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                                error="${error}"/></li>
                    </g:eachError>
                </ul>
            </g:hasErrors>
            <g:form id="create-course-form" action="save"
                    class="form-horizontal">
                <f:with bean="courseInstance">
                    <f:field property="code"/>
                    <f:field property="title"/>
                    <f:field property="description"/>
                    <f:field property="startDate"/>
                    <f:field property="numberOfWeeks"/>
                    <f:field property="available"/>
                    <f:field property="guestVisible"/>
                </f:with>
                <div class="control-group pagination-centered">
                    <g:actionSubmit action="update" class="btn btn-primary"
                                    value="${message(code: 'default.button.update.label')}"/>
                    <a class="btn"
                       href="${createLink(action: 'show', id: courseInstance.id)}">取消</a>
                </div>
            </g:form>
        </div>
        <script>
            require(['dojo/query', 'bootstrap/Datepicker'], function (query) {
                query(".date").datepicker({
                    format: 'yyyy-mm-dd',
                    weekStart: 1
                });
            });
        </script>
    </body>
</html>

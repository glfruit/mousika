<%@ page import="com.sanwn.mousika.domain.Course" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
        <g:set var="entityName"
               value="${message(code: 'course.label', default: 'Course')}"/>
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
        %{--<ckeditor:resources/>--}%
        <title><g:message code="default.create.label"
                          args="[entityName]"/></title>
    </head>

    <body>
        <div id="create-course" class="content scaffold-create" role="main">
            <h3 class="text-center"><g:message
                    code="default.course.create.label"/></h3>
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
            <g:form action="save" class="form-horizontal">
                <f:all bean="courseInstance"/>
                <div class="control-group pagination-centered">
                    <g:submitButton name="create"
                                    value="${message(code: 'default.button.create.label', default: 'Create')}"/>
                </div>
            </g:form>
        </div>
        <dojo:amdRequire
                modules="['dijit.form.DateTextBox', 'dojoui.widget.Editor']"/>
    </body>
</html>

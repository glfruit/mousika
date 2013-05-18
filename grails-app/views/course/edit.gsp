<%@ page import="com.sanwn.mousika.domain.Course" %>
<!DOCTYPE html>
<html>
    <head>
        <g:set var="entityName"
               value="${message(code: 'course.label', default: 'Course')}"/>
        <title><g:message code="default.edit.label"
                          args="[entityName]"/></title>
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
        <div id="edit-course" class="content scaffold-edit" role="main">
            <h1><g:message code="default.edit.label" args="[entityName]"/></h1>
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
            <g:form method="post">
                <g:hiddenField name="id" value="${courseInstance?.id}"/>
                <g:hiddenField name="version"
                               value="${courseInstance?.version}"/>
                <fieldset class="form">
                    <f:with bean="courseInstance">
                        <f:field property="code"/>
                        <f:field property="title"/>
                        <f:field property="description"/>
                        <f:field property="startDate"/>
                        <f:field property="numberOfWeeks"/>
                        <f:field property="available"/>
                        <f:field property="guestVisible"/>
                    </f:with>
                </fieldset>
                <fieldset class="buttons">
                    <g:actionSubmit class="save" action="update"
                                    value="${message(code: 'default.button.update.label', default: 'Update')}"/>
                    <g:actionSubmit class="delete" action="delete"
                                    value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                                    formnovalidate=""
                                    onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');"/>
                </fieldset>
            </g:form>
        </div>
    </body>
</html>

<%@ page import="com.sanwn.mousika.Label" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main">
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
        <g:set var="entityName"
               value="${message(code: 'label.label', default: 'Label')}"/>
        <title><g:message code="default.create.label"
                          args="[entityName]"/></title>
    </head>

    <body>
        <div id="create-label" class="content scaffold-create" role="main">
            <h3 class="text-center"><g:message code="label.create.label"
                           args="[entityName]"/></h3>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${labelInstance}">
                <ul class="errors" role="alert">
                    <g:eachError bean="${labelInstance}" var="error">
                        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                                error="${error}"/></li>
                    </g:eachError>
                </ul>
            </g:hasErrors>
            <g:form action="save" class="form-horizontal">
                <fieldset class="form">
                    <g:hiddenField name="sectionSeq" value="${sectionSeq}"/>
                    <f:with bean="labelInstance">
                        <f:field property="labelContent"/>
                    </f:with>
                </fieldset>
                <fieldset class="buttons">
                    <div class="control-group pagination-centered">
                        <g:submitButton name="create" class="save"
                                        value="${message(code: 'label.create.label', default: 'Create')}"/>
                        <a class="btn"
                           href="${createLink(controller: 'course', action: 'show', id: courseId)}">${message(code: 'default.cancel.label')}</a>
                    </div>
                </fieldset>
            </g:form>
        </div>
    </body>
</html>

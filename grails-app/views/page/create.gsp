<%@ page import="com.sanwn.mousika.domain.Page" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="dojo">
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
               value="${message(code: 'page.label', default: 'Page')}"/>
        <title><g:message code="default.create.label"
                          args="[entityName]"/></title>
    </head>

    <body>
        <div id="create-page" class="content scaffold-create" role="main">
            <h3><g:message code="page.create.label"
                           args="[entityName]"/></h3>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${pageInstance}">
                <ul class="errors" role="alert">
                    <g:eachError bean="${pageInstance}" var="error">
                        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                                error="${error}"/></li>
                    </g:eachError>
                </ul>
            </g:hasErrors>
            <g:form action="save" class="form-horizontal">
                <fieldset class="form">
                    <f:with bean="pageInstance">
                        <f:field property="title" required="true"/>
                        <f:field property="description"/>
                        <f:field property="content"/>
                    </f:with>
                </fieldset>
                <fieldset class="buttons">
                    <g:submitButton name="create" class="save"
                                    value="${message(code: 'page.button.create.label', default: 'Create')}"/>
                    <g:submitButton name="createAndReturn"
                                    value="创建并返回到课程"/>
                </fieldset>
            </g:form>
        </div>
    </body>
</html>

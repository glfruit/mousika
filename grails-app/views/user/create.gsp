<%--
  Created by IntelliJ IDEA.
  User: yehai
  Date: 13-7-16
  Time: 下午1:34
  To change this template use File | Settings | File Templates.
--%>

<%@ page import="com.sanwn.mousika.User" %>
<!DOCTYPE html>
<html>
<head>
    %{--<meta name="layout" content="dojo">--}%
    <g:set var="entityName"
           value="${message(code: 'user.label')}"/>
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
    <link rel="stylesheet"
          href="${resource(dir: 'css', file: 'datepicker.css')}"
          type="text/css"/>
    %{--<ckeditor:resources/>--}%
    <title><g:message code="default.create.label"
                      args="[entityName]"/></title>
</head>

<body>
<div id="create-user" class="content scaffold-create" role="main">
    <h3 class="text-center"><g:message
            code="user.create.label"/></h3>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${userInstance}">
        <ul class="errors" role="alert">
            <g:eachError bean="${userInstance}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                        error="${error}"/></li>
            </g:eachError>
        </ul>
    </g:hasErrors>
    <g:form id="create-user-form" action="save"
            class="form-horizontal">
        <f:with bean="userInstance">
            <f:field property="username"/>
            <f:field property="fullname"/>
        </f:with>
        <div class="control-group pagination-centered">
            <g:submitButton id="create-user-button" name="create"
                            class="btn btn-primary"
                            value="${message(code: 'user.create.label', default: 'Create')}"/>
            <a class="btn" href="${createLink(action: 'list')}">取消</a>
        </div>
    </g:form>
</div>
</body>
</html>


</body>
</html>
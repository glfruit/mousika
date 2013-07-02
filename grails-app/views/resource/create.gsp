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
        <title><g:message code="resource.create.label"/></title>
    </head>

    <body>
        <div id="create-resource" class="content scaffold-create" role="main">
            <h3><g:message code="resource.create.label"/></h3>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${resource}">
                <ul class="errors" role="alert">
                    <g:eachError bean="${resource}" var="error">
                        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                                error="${error}"/></li>
                    </g:eachError>
                </ul>
            </g:hasErrors>
            <g:form action="save" class="form-horizontal">
                <fieldset class="form">
                    <f:with bean="resource">
                        <g:hiddenField name="courseId" id="courseId"
                                       value="${courseId}"/>
                        <g:hiddenField name="sectionSeq" id="sectionSeq"
                                       value="${sectionSeq}"/>
                        <g:hiddenField name="returnToCourse" id="returnToCourse"
                                       value="false"/>
                        <f:field property="title" required="true"/>
                        <f:field property="description"/>
                        <g:render template="${type}"/>
                    </f:with>
                </fieldset>
                <fieldset class="buttons">
                    <g:submitButton id="createAndShowBtn" name="create"
                                    class="btn"
                                    value="${message(code: 'page.button.create.label', default: 'Create')}"/>
                    <g:submitButton id="createAndReturnBtn"
                                    name="createAndReturn" class="btn"
                                    value="创建并返回到课程"/>
                    <a class="btn"
                       href="${createLink(controller: 'course', action: 'show', id: courseId)}">${message(code: 'default.cancel.label')}</a>
                </fieldset>
            </g:form>
            <script>
                require(['dojo/query', 'dojo/dom-attr'], function (query, domAttr) {
                    query('#createAndShowBtn').on('click', function () {
                        domAttr.set(query('#returnToCourse')[0], 'value', 'false');
                    });
                    query('#createAndReturnBtn').on('click', function () {
                        domAttr.set(query('#returnToCourse')[0], 'value', 'true');
                    });
                });
            </script>
        </div>
    </body>
</html>

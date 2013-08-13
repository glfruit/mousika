<%@ page import="com.sanwn.mousika.Role; org.apache.commons.lang.StringEscapeUtils; com.sanwn.mousika.User; com.sanwn.mousika.Course; com.sanwn.mousika.Assignment" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="student"/>
        <g:set var="entityName" value="${message(code: 'course.label')}"/>
        <title><g:message code="default.list.label" args="[entityName]"/></title>
        <mousika:editor/>
        %{--<g:javascript src="../tinymce/tinymce.min.js"/>--}%
        %{--<r:script>--}%
            %{--tinyMCE.init({--}%
                %{--mode: "textareas",--}%
                %{--theme: "advanced",--}%
                %{--language: "cn",--}%
                %{--width: "98%",--}%
                %{--height: 260,--}%
                %{--plugins: "autosave,emotions,contextmenu,fullscreen,inlinepopups,preview",--}%
                %{--theme_advanced_buttons3_add: "emotions",--}%
                %{--theme_advanced_buttons3_add: "fullscreen",--}%
                %{--fullscreen_new_window: true,--}%
                %{--fullscreen_settings: {--}%
                    %{--theme_advanced_path_location: "top"--}%
                %{--},--}%
                %{--dialog_type: "modal",--}%
                %{--theme_advanced_buttons3_add: "preview",--}%
                %{--plugin_preview_width: "500",--}%
                %{--plugin_preview_height: "600"--}%
            %{--});--}%
        %{--</r:script>--}%
    </head>

    <body>
        <g:if test="${org.apache.shiro.SecurityUtils.subject.hasRoles([com.sanwn.mousika.Role.STUDENT])}">
            <h4 style="border-bottom: 1px solid #000;color: #777777;">
                <g:message code="label.student.working"/>
            </h4>
        </g:if>

        <div data-dojo-type="dijit/TitlePane"
             data-dojo-props="title: '我的作业'"
             style="padding-bottom: 10px;">
                <g:if test="${assignment}">
                    <g:uploadForm action="createAttempt">
                    <table width="96%" border="0">
                        <tr>
                            %{--<th width="90">--}%
                                %{--课程名称：--}%
                            %{--</th>--}%
                            %{--<td>--}%
                                %{--${assignment.section.course.title}--}%
                            %{--</td>--}%
                            <th width="90">
                                作业名称：
                            </th>
                            <td colspan="3">
                                ${assignment.title}
                            </td>
                        </tr>
                        <tr>
                            <th>
                                作业内容：
                            </th>
                            <td colspan="3">
                                <%=assignment?.description%>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                回答：
                            </th>
                            <td colspan="3">
                                <g:hiddenField name="assignmentId"  value="${assignment?.id}"/>
                                <g:textArea name="attemptContent" value="${attempt?.attemptContent}" rows="10"/>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                提交文件：
                            </th>
                            <td colspan="3">
                                <input type="file" name="assignmentFile" size="40"/>
                            </td>
                        </tr>
                        <tr>
                            <g:if test="${flash.message}">
                                <th><a style="color: blue;">操作提示：</a></th>
                                <td colspan="4" align="left" height="30">
                                    <div class="message" role="status">${flash.message}</div>
                                </td>
                            </g:if>
                        </tr>
                        <tr>
                            <td colspan="4" align="center">
                                <g:if test="${assignment.availableFrom<=new Date()&&new Date()<=assignment.dueDate}">
                                    <button type="submit" class="btn btn-primary">提交作业</button>
                                </g:if>
                            </td>
                        </tr>
                    </table>
                    </g:uploadForm>
                </g:if>
                <g:else>
                    无该作业
                </g:else>
        </div>


    </body>
</html>

<%@ page import="com.sanwn.mousika.Role; org.apache.commons.lang.StringEscapeUtils; com.sanwn.mousika.User; com.sanwn.mousika.Course" %>
<!DOCTYPE html>
<html>
    <head>
        <g:set var="entityName"
               value="${message(code: 'course.label')}"/>
        <title><g:message code="default.list.label"
                          args="[entityName]"/></title>
        <style type="text/css">
        .dojoxGridCell {
            font-size: 12px;
        }

        h2 {
            margin-top: 0;
        }
        </style>
        <link rel="stylesheet"
              href="${resource(dir: 'js/lib/dojox/grid/enhanced/resources/claro', file: 'EnhancedGrid.css')}"
              type="text/css"/>
        <script type="text/javascript">
            require(['dojox/grid/EnhancedGrid','dojox/grid/enhanced/plugins/Pagination','dojox/data/QueryReadStore'],function(g,p,Store) {
                var myStore = new Store({url:'student/regCourseList',requestMethod:'POST'});
            })
        </script>
    </head>

    <body class="claro">
        <g:if test="${org.apache.shiro.SecurityUtils.subject.hasRoles([com.sanwn.mousika.Role.STUDENT])}">
            <h4 style="border-bottom: 1px solid #000;color: #777777;">
                <g:message code="label.student.regCourse"/>
            </h4>
        </g:if>

        <% header = {
            return """
    <button style="float:left">Selected: ${dojo.bind(variable: 'myGrid.selected')}</button>
    <h2>My Widgets ( ${dojo.bind(variable: 'myGrid.rowCount')} )</h2>
  """
        } %>

        <table dojoType="dojox.grid.EnhancedGrid" jsId="grid" data-dojo-id="myStore"
               rowsPerPage="5" clientSort="true"
               style="width: 100%; height: 100%;"
               onRowDblClick="onRowDblClick"
               rowSelector="20px" plugins="{ pagination: {
           pageSizes:['5','10','20'],
           maxPageStep: 5,
           descTemplate: '${message(code: 'AAA')}',
           description: true,
           sizeSwitch: true,
           pageStepper: true ,
           gotoButton: true
           }}">
            <thead>
                <tr>
                    <th width="50px" field="id">ID</th>
                    <th width="100px" field="name">员工号</th>
                </tr>
            </thead>
        </table>


        <g:if test="${notRegCoures}">
            <g:each in="${notRegCoures}" status="i"
                    var="courseInstance">
                <section
                        style="border: 1px solid #A0A0A0;padding-left: 10px;padding-right: 10px;margin-top:10px;margin-bottom: 10px;">
                    <ul class="thumbnails">
                        <li class="span5">
                            <h3>
                                <dojo:grid name="myGrid" controller="student"
                                           action="regCourse" max="20"
                                           sort="name"
                                           style="height:200px; width:600px"
                                           header="${header}" selectable="true">
                                    <dojo:col width="50%" label="title"
                                              field="notRegCoures.title">${notRegCoures.title}</dojo:col>
                                    <dojo:col width="50%" label="id"
                                              field="notRegCoures.id">${notRegCoures.id}</dojo:col>
                                </dojo:grid>
                            </h3>

                    </ul>
                </section>
            </g:each>
            <p>
                <g:link controller="student" action="regCourse"
                        class="btn create">注 册</g:link>
            <p>
        </g:if>
        <g:else>
            <p>暂时没有任何课程</p>
        </g:else>

    </body>
</html>

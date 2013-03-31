<%@ page import="com.sanwn.mousika.domain.Course" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="dojo">
        <g:set var="entityName"
               value="${message(code: 'course.label', default: 'Course')}"/>
        <title><g:message code="default.list.label"
                          args="[entityName]"/></title>
        <style>
        .commands {
            white-space: nowrap;
            display: inline;
        }

        li {
            cursor: text;
        }
        </style>
    </head>

    <body>
        <h4 style="border-bottom: 1px solid #000;color: #777777;">
            添加成员
        </h4>
        <a href="#myModal" role="button" class="btn"
           data-toggle="modal">添加成员</a>

        <div class="modal hide fade" id="myModal" tabindex="-1" role="dialog"
             aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-hidden="true">×</button>

                <h3 id="myModalLabel">Modal header</h3>
            </div>

            <div class="modal-body">
                <p>One fine body…</p>
            </div>

            <div class="modal-footer">
                <button class="btn" data-dismiss="modal"
                        aria-hidden="true">Close</button>
                <button class="btn btn-primary">Save changes</button>
            </div>
        </div>
        <table class="table">
            <thead>
                <th>姓名</th>
                <th>电子邮件</th>
                <th>最后访问时间</th>
                <th>角色</th>
            </thead>
            <tbody>
                <tr>
                    <td>李果</td>
                    <td>gleexpp@gmail.com</td>
                    <td>2013-03-29 15:30</td>
                    <td>教师</td>
                </tr>
            </tbody>
        </table>
        <script type="text/javascript">
            require(["dijit/Dialog", "dijit/form/TextBox", "dijit/form/Button", "bootstrap/Modal"]);
        </script>
    </body>
</html>

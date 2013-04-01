<%@ page import="com.sanwn.mousika.domain.User; com.sanwn.mousika.domain.Role; com.sanwn.mousika.domain.Course" %>

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

                <h4 id="myModalLabel">添加成员</h4>
            </div>

            <div class="modal-body">
                分配角色：<g:select id="roleList" name="role" from="${Role.list()}"
                               optionKey="id" optionValue="name"/>
                <table class="table table-striped">
                    <g:each in="${users}" var="u" status="i">
                        <tr>
                            <td>${i + 1}</td>
                            <td>img</td>
                            <td>${u.fullname}</td>
                            <td>${u.email}</td>
                            <td>
                                <g:form id="userForm${i + 1}" controller="user"
                                        action="assign">
                                    <input type="hidden" class="user-id"
                                           value="${u.id}"/>
                                    <button type="button"
                                            class="btn enrol">添加</button>
                                </g:form>
                            </td>
                        </tr>
                    </g:each>
                </table>

                <div class="pagination">
                    <ul>
                        <li><a href="#">&laquo;</a></li>
                        <li><a href="#">1</a></li>
                        <li><a href="#">2</a></li>
                        <li><a href="#">3</a></li>
                        <li><a href="#">4</a></li>
                        <li><a href="#">5</a></li>
                        <li><a href="#">&raquo;</a></li>
                    </ul>
                </div>

                <form class="form-search">
                    <input type="text" class="input-medium search-query">
                    <button type="submit" class="btn">搜索</button>
                </form>
            </div>

            <div class="modal-footer">
                <button class="btn" data-dismiss="modal"
                        aria-hidden="true">关闭</button>
                <button class="btn btn-primary">保存</button>
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
            require(["dojo/query", "dojo/ready", "bootstrap/Modal"], function (query, ready) {
                ready(function () {
                    query(".enrol").on("click", function (e) {
                        require(['dojo/request', 'dojo/dom', 'dojo/dom-attr'], function (request, dom, domAttr) {
                            request.post("${request.contextPath}/user/assign", {
                                data: {
                                    uid: domAttr.get(query(e.target).siblings(".user-id")[0], "value"),
                                    rid: dom.byId("roleList").value
                                }
                            }).then(function (response) {
                                        require(["dojo/json"], function (json) {
                                            if (json.parse(response).success) {
                                                query(e.target).parents("tr").first().addClass("success");
                                                query(e.target).addClass("hide");
                                            } else {
                                                alert("failure!" + json.parse(response).error);
                                            }
                                        });
                                    });
                        });
                    });
                });
            });
        </script>
    </body>
</html>

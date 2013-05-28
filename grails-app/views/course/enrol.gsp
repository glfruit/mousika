<%@ page import="com.sanwn.mousika.domain.User; com.sanwn.mousika.domain.Role; com.sanwn.mousika.domain.Course" %>

<!DOCTYPE html>
<html>
    <head>
        <g:set var="entityName"
               value="${message(code: 'course.label', default: 'Course')}"/>
        <title><g:message code="course.enrol.label"/></title>
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
        <h4 id="courseTitleHead"
            style="border-bottom: 1px solid #000;color: #777777;">
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
                            <td>${u.profile?.photo}</td>
                            <td>${u.fullname}</td>
                            <td>${u.profile?.email}</td>
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

                <g:if test="${pages > 1}">
                    <div class="pagination pagination-centered">
                        <ul>
                            <li class="${offset == 0 ? 'disabled' : ''}">
                                <a href="#back" class="page-link">&laquo;</a>
                            </li>
                            <g:each in="${1..pages}" var="page">
                                <li class="${offset + 1 == page ? 'active' : ''}">
                                    <a href="#${page - 1}"
                                       class="page-link">${page}</a>
                                </li>
                            </g:each>
                            <li class="${offset + 1 == pages ? 'disabled' : ''}"><a
                                    href="#forward"
                                    class="page-link">&raquo;</a></li>
                        </ul>
                    </div>
                </g:if>
                <form class="form-search">
                    <input type="text" class="input-medium search-query">
                    <button type="submit" class="btn">搜索</button>
                </form>
            </div>

            <div class="modal-footer">
                <button id="enrol-done" class="btn" data-dismiss="modal"
                        aria-hidden="true">关闭</button>
            </div>
        </div>
        <table class="table">
            <thead>
                <th>姓名</th>
                <th>电子邮件</th>
                <th>最后访问时间</th>
                <th>角色</th>
            </thead>
            <tbody id="userRows">
                <g:each in="${members}" var="member">
                    <tr>
                        <td>${member.fullname}</td>
                        <td>${member.profile?.email}</td>
                        <td><g:formatDate date="${member.profile?.lastAccessed}"
                                          format="yyyy-MM-dd HH:mm:ss"/></td>
                        <td>
                            <g:each in="${member.roles}" var="role">
                                ${role.name}<i class="icon-remove"></i>
                            </g:each>
                        </td>
                    </tr>
                </g:each>
                <tr colspan="4"><a class="btn"
                                   href="${createLink(action: 'list')}">返回到课程</a>
                </tr>
            </tbody>
        </table>
        <script type="text/javascript">
            require(["dojo/query",
                "dojo/ready",
                "bootstrap/Modal"], function (query, ready) {
                ready(function () {
                    query(".enrol").on("click", function (e) {
                        require(['dojo/request', 'dojo/dom', 'dojo/dom-attr'], function (request, dom, domAttr) {
                            request.post("${request.contextPath}/course/assign/${params.id}", {
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
                    query(".page-link").on("click", function (e) {  //TODO: 处理分页
                        e.stopPropagation();
                        e.preventDefault();
                        require(['dojo/request', 'dojo/dom-attr'], function (request, domAttr) {
                            var clz = query(e.target).parent().attr("class").toString();
                            if (!clz.contains("active")) {
                                var p = query(e.target).attr("href").substring(1);
                                if (p == "back") {

                                } else if (p == "forward") {

                                } else {
                                    p = parseInt(p);

                                }
                            }
                        });
                    });
                    query("#enrol-done").on("click", function () {
                        require(['dojo/request'], function (request) {
                            request.post("${request.contextPath}/course/listMembers/${params.id}",{
                                headers: {
                                    'Accept' : 'application/json'
                                }
                            }).then(function (response) {
                                require(['dojo/dom', 'dojo/dom-construct', 'dojo/_base/array', 'dojo/json', 'dojo/query', 'dojo/date/locale'],
                                        function (dom, domConstruct, arrayUtil, json, query, locale) {
                                            var users = json.parse(response);
                                            arrayUtil.forEach(users, function (user) {
                                                var tr = domConstruct.create('tr', null, query('#userRows')[0]);
                                                domConstruct.create("td", {innerHTML: user.fullname}, tr);
                                                domConstruct.create("td", {innerHTML: user.profile ? user.profile.email : ''}, tr);
                                                var lastAccessed = 'N/A';
                                                if (user.lastAccessed) {
                                                    lastAccessed = locale.format(user.lastAccessed, {
                                                        datePattern: 'yyyy-MM-dd hh:mm:ss'
                                                    });
                                                }
                                                domConstruct.create("td", {innerHTML: lastAccessed}, tr);
                                                var roles = '';
                                                arrayUtil.forEach(user.roles, function (role) {
                                                    roles = roles + role.name + '<i class="icon-remove"></i>'
                                                });
                                                domConstruct.create("td", {innerHTML: roles}, tr);
                                            });
                                        });
                            });
                        });
                    });
                });
            });
        </script>
    </body>
</html>

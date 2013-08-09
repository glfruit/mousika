
<%@ page import="com.sanwn.mousika.User" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/html">
<head>
    <meta name="layout" content="system">
    <title><g:message code="user.list.label"/></title>
    <style type="text/css">
    ul{list-style:none;}
    li{list-style:none;}
    </style>
</head>
<body>
%{--<a href="#list-user" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>--}%
%{--<div class="nav" role="navigation">
    <ul>
        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
        <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
    </ul>
</div>--}%

<div id="list-user" class="content scaffold-list" role="main">
    <h4 style="border-bottom: 1px solid black;">用户管理</h4>
    <form class="form-search">
        <input id="searchBy" placeholder="查找用户" type="text"
               class="input-medium search-query">
        <button id="searchUserBtn" type="submit" class="btn">搜索</button>
    </form>
    <g:link controller="user" class="btn create" action="create"><g:message code="user.create.label"/></g:link>&nbsp;&nbsp;&nbsp;&nbsp;<g:link controller="user" class="btn create"  action="batchImportIndex"><g:message code="user.batch.import.label" args="[entityName]" /></g:link></li>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <table class="table table-striped" id="userTbl">
        <thead>
        <tr>
            %{--<g:sortableColumn property="username" title="${message(code: 'user.username.label', default: '用户名')}" />

            <g:sortableColumn property="fullname" title="${message(code: 'user.fullname.label', default: '姓名')}" />

            <g:sortableColumn property="email" title="${message(code: 'user.email.label', default: '邮箱')}" />

            <g:sortableColumn property="roles" title="${message(code: 'user.roles.label', default: '角色')}" />

            <g:sortableColumn property="firstAccessed" title="${message(code: 'user.firstAccessed.label', default: '首次访问时间')}" />

            <g:sortableColumn property="lastAccessed" title="${message(code: 'user.lastAccessed.label', default: '最后访问时间')}" />--}%
            <td align="center">${message(code: 'user.username.label', default: '用户名')}</td>
            <td align="center">${message(code: 'user.fullname.label', default: '姓名')}</td>
            <td align="center">${message(code: 'user.roles.label', default: '角色')}</td>
            <td align="center">${message(code: 'user.firstAccessed.label', default: '首次访问时间')}</td>
            <td align="center">${message(code: 'user.lastAccessed.label', default: '最后访问时间')}</td>
            <td align="center">${message(code: 'user.operation.label', default: '操作')}</td>

        </tr>
        </thead>
        <tbody id="userRows">
        <g:each in="${userInstanceList}" status="i" var="userInstance">
            <tr class="${(i % 2) == 0 ? 'even' : 'odd'}">

                <td>${fieldValue(bean: userInstance, field: "username")}</td>

                <td>${fieldValue(bean: userInstance, field: "fullname")}</td>

                <td>
                    <g:each in="${userInstance.roles}" var="role">
                        ${role.name}；
                    </g:each>
                </td>
                %{--<td>${fieldValue(bean: userInstance, field: "roles")}</td>--}%

                <td><g:formatDate format="yyyy-MM-dd HH:mm:ss"
                                  date="${userInstance.profile?.firstAccessed}"/></td>
                <td><g:formatDate format="yyyy-MM-dd HH:mm:ss"
                                  date="${userInstance.profile?.lastAccessed}"/></td>
                <td>
                    <g:link controller="user"  id ="${userInstance.id}" action="show">查看</g:link>
                    <g:link controller="user"  id ="${userInstance.id}" action="edit">修改</g:link>
                    <g:link controller="user"  id ="${userInstance.id}" action="delete" onclick="return confirm('${message(code: 'user.button.delete.confirm.message', default: '确定要删除该用户吗?')}');">删除</g:link>
                </td>

            </tr>
        </g:each>
        </tbody>
    </table>
    <div class="pagination">
        <g:paginate total="${userInstanceTotal}" />
    </div>
</div>
</body>
<g:javascript>
    require(["dojo/query",
        "dojo/ready",
        "dojo/_base/event",
        "dojo/dom",
        "dojo/dom-class",
        "dojo/request",
        "dojo/dom-construct",
        "dojo/json",
        "dojo/_base/array",
        "bootstrap/Modal"], function (query, ready, event, dom, domClass, request, domConstruct, json, arrayUtil) {
        ready(function () {
            var searchTotal = -1;
            query("#searchUserBtn").on("click", function (e) {
                event.stop(e);
                domClass.add(dom.byId('searchUserBtn'), 'inSearch');
                request.get("${request.contextPath}/user/search", {
                    headers: {
                        'Accept': 'application/json'
                    },
                    query: {
                        max: 20,
                        offset: 0,
                        sort: 'username',
                        q: dom.byId('searchBy').value
                    }
                }).then(function (response) {
                            domConstruct.empty(dom.byId('userRows'));
                            var searchResult = json.parse(response);
                            var users = searchResult.users;
                            arrayUtil.forEach(users, function (user, i) {
                                var userDiv = dom.byId('userRows');
                                var tr = domConstruct.create('tr', null, userDiv);
                                domConstruct.create("td", {innerHTML: user.username}, tr)
                                domConstruct.create("td", {innerHTML: user.fullname}, tr);
                                var roles = '';
                                arrayUtil.forEach(user.roles, function (role) {
                                    roles = roles + role.name + ';';
                                });
                                domConstruct.create("td", {innerHTML: roles}, tr);
                                var firstAccessed;
                                if (user.firstAccessed!=null&&user.firstAccessed!="") {
                                    firstAccessed = locale.format(user.firstAccessed, {
                                        datePattern: 'yyyy-MM-dd hh:mm:ss'
                                    });
                                    domConstruct.create("td", {innerHTML: firstAccessed}, tr);
                                }
                                else{
                                    domConstruct.create("td", {innerHTML: ''}, tr);
                                }
                                var lastAccessed;
                                if (user.lastAccessed) {
                                    lastAccessed = locale.format(user.lastAccessed, {
                                        datePattern: 'yyyy-MM-dd hh:mm:ss'
                                    });
                                domConstruct.create("td", {innerHTML: lastAccessed}, tr);
                                }
                                else{
                                    domConstruct.create("td", {innerHTML: ''}, tr);
                                }
                                domConstruct.create("td", {innerHTML: "<a href='/mousika/user/show/"+user.id+"'>查看</a>"+"&nbsp;&nbsp;"+"<a href='/mousika/user/edit/"+user.id+"'>修改</a>"+"&nbsp;&nbsp;"+"<a href='/mousika/user/edit/"+user.id+"' onclick=\"return confirm('确定要删除该用户吗?')\">删除</a>"}, tr);
                            });
                            searchTotal = searchResult.total;
                });
            });
        });
    });
</g:javascript>
</html>

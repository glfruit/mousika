<%@ page import="com.sanwn.mousika.Role; com.sanwn.mousika.User; com.sanwn.mousika.Course" %>

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
        分配角色：<g:select id="roleList" name="role"
                       from="${com.sanwn.mousika.Role.list(order: 'name')}"
                       optionKey="id" optionValue="name"/>
        <table id="userTbl" class="table table-striped">
            <g:each in="${users}" var="u" status="i">
                <tr>
                    <td>${i + 1}</td>
                    <td>${u.profile?.photo}</td>
                    <td>${u.fullname}</td>
                    <td>${u.profile?.email}</td>
                    <td>
                        <button id="btn${u.id}" type="button"
                                class="btn enrol">添加</button>
                    </td>
                </tr>
            </g:each>
        </table>

        <g:if test="${pages > 1}">
            <div class="pagination pagination-centered">
                <ul>
                    <li id="backAnchor"
                        class="${offset == 0 ? 'disabled' : ''}">
                        <a href="#back" class="page-link">&laquo;</a>
                    </li>
                    <g:each in="${1..pages}" var="page">
                        <li class="${offset + 1 == page ? 'active' : ''} page-num">
                            <a href="#${page - 1}"
                               class="page-link">${page}</a>
                        </li>
                    </g:each>
                    <li id="forwardAnchor"
                        class="${offset + 1 == pages ? 'disabled' : ''}"><a
                            href="#forward"
                            class="page-link">&raquo;</a></li>
                </ul>
            </div>
        </g:if>
        <form class="form-search">
            <input id="searchBy" placeholder="查找用户" type="text"
                   class="input-medium search-query">
            <button id="searchUserBtn" type="submit" class="btn">搜索</button>
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
                <td>${member.profile?.email ? member.profile?.email : 'N/A'}</td>
                <td>
                    <g:set var="lastAccessed"
                           value="${member.profile?.lastAccessed}"/>
                    <g:if test="${lastAccessed}">
                        <g:formatDate
                                date="${lastAccessed}"
                                format="yyyy-MM-dd HH:mm:ss"/>
                    </g:if>
                    <g:else>
                        N/A
                    </g:else>
                </td>
                <td>
                    <g:each in="${member.roles}" var="role">
                        ${role.name}；
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
            query(".enrol").on("click", function (e) {
                require(['dojo/request'], function (request) {
                    var uid = query(e.target)[0].id.match(/btn(\d+)$/)[1];
                    request.post("${request.contextPath}/course/assign/${params.id}", {
                        data: {
                            uid: uid,
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
                            var userTbl = dom.byId('userTbl');
                            domConstruct.empty(userTbl);
                            var searchResult = json.parse(response);
                            var users = searchResult.users;
                            arrayUtil.forEach(users, function (user, i) {
                                var tr = domConstruct.create('tr', null, userTbl);
                                domConstruct.create("td", {innerHTML: i + 1}, tr);
                                domConstruct.create("td", {innerHTML: user.profile ? user.photo : ''})
                                domConstruct.create("td", {innerHTML: user.fullname}, tr);
                                domConstruct.create("td", {innerHTML: user.profile ? user.profile.email : ''}, tr);
                                domConstruct.create("td", {innerHTML: "<button id='btn" + user.id + " type='button' class='btn enrol'>添加</button>"}, tr);
                            });
                            searchTotal = searchResult.total;
                        });
            });
            query(".page-link").on("click", function (e) {
                event.stop(e);
                var baseUrl = "${request.contextPath}/user/";
                var url = query('.inSearch').length == 0 ? baseUrl + 'list' : baseUrl + 'search';
                require(['dojo/request', 'dojo/dom-attr', 'dojo/dom', 'dojo/dom-class'], function (request, domAttr, dom, domClass) {
                    var clz = query(e.target).parent().attr("class").toString();
                    if (!clz.contains("active")) {
                        var p = query(e.target).attr("href")[0].substring(1);
                        var active = query('.active>a').attr('href')[0];
                        var current = parseInt(active.substring(1));
                        if (p == "back") {
                            p = current - 1;
                            if (p < 0) return;
                            request.get(url, {
                                headers: {
                                    'Accept': 'application/json'
                                },
                                query: {
                                    max: 20,
                                    offset: p * 20,
                                    sort: 'username'
                                }
                            }).then(function (response) {
                                        require(['dojo/dom-class', 'dojo/dom', 'dojo/dom-construct', 'dojo/_base/array', 'dojo/json', 'dojo/query', 'dojo/date/locale', 'dojo/dom-construct'],
                                                function (domClass, dom, domConstruct, arrayUtil, json, query, locale, domConstruct) {
                                                    var userTbl = dom.byId('userTbl');
                                                    domConstruct.empty(userTbl);
                                                    var users = json.parse(response);
                                                    arrayUtil.forEach(users, function (user, i) {
                                                        var tr = domConstruct.create('tr', null, userTbl);
                                                        domConstruct.create("td", {innerHTML: i + 1}, tr);
                                                        domConstruct.create("td", {innerHTML: user.profile ? user.photo : ''})
                                                        domConstruct.create("td", {innerHTML: user.fullname}, tr);
                                                        domConstruct.create("td", {innerHTML: user.profile ? user.profile.email : ''}, tr);
                                                        domConstruct.create("td", {innerHTML: "<button id='btn" + user.id + " type='button' class='btn enrol'>添加</button>"}, tr);
                                                    });
                                                    domClass.remove(dom.byId('forwardAnchor'), 'disabled');
                                                    query('.active.page-num').removeClass('active');
                                                    query("a[href='#" + p + "']").parent().addClass('active');
                                                    if (p == 0) {
                                                        domClass.add(dom.byId('backAnchor'), 'disabled');
                                                    } else {
                                                        domClass.remove(dom.byId('backAnchor'), 'disabled');
                                                    }
                                                });
                                    });

                        } else if (p == "forward") {
                            p = current + 1;
                            if (searchTotal != -1 && p >= searchTotal) return;
                            if (p >= parseInt("${pages}")) return;
                            request.get(url, {
                                headers: {
                                    'Accept': 'application/json'
                                },
                                query: {
                                    max: 20,
                                    offset: p * 20,
                                    sort: 'username'
                                }
                            }).then(function (response) {
                                        require(['dojo/dom-class', 'dojo/dom', 'dojo/dom-construct', 'dojo/_base/array', 'dojo/json', 'dojo/query', 'dojo/date/locale', 'dojo/dom-construct'],
                                                function (domClass, dom, domConstruct, arrayUtil, json, query, locale, domConstruct) {
                                                    var userTbl = dom.byId('userTbl');
                                                    domConstruct.empty(userTbl);
                                                    var users = json.parse(response);
                                                    arrayUtil.forEach(users, function (user, i) {
                                                        var tr = domConstruct.create('tr', null, userTbl);
                                                        domConstruct.create("td", {innerHTML: i + 1}, tr);
                                                        domConstruct.create("td", {innerHTML: user.profile ? user.photo : ''})
                                                        domConstruct.create("td", {innerHTML: user.fullname}, tr);
                                                        domConstruct.create("td", {innerHTML: user.profile ? user.profile.email : ''}, tr);
                                                        domConstruct.create("td", {innerHTML: "<button id='btn" + user.id + " type='button' class='btn enrol'>添加</button>"}, tr);
                                                    });
                                                    domClass.remove(dom.byId('backAnchor'), 'disabled');
                                                    query('.active.page-num').removeClass('active');
                                                    query("a[href='#" + p + "']").parent().addClass('active');
                                                    if (p == parseInt("${pages}") - 1) {
                                                        domClass.add(dom.byId('forwardAnchor'), 'disabled');
                                                    } else {
                                                        domClass.remove(dom.byId('forwardAnchor'), 'disabled');
                                                    }
                                                });
                                    });
                        } else {
                            p = parseInt(p);
                            request.get(url, {
                                headers: {
                                    'Accept': 'application/json'
                                },
                                query: {
                                    max: 20,
                                    offset: p * 20,
                                    sort: 'username'
                                }
                            }).then(function (response) {
                                        require(['dojo/dom-class', 'dojo/dom', 'dojo/dom-construct', 'dojo/_base/array', 'dojo/json', 'dojo/query', 'dojo/date/locale', 'dojo/dom-construct'],
                                                function (domClass, dom, domConstruct, arrayUtil, json, query, locale, domConstruct) {
                                                    var userTbl = dom.byId('userTbl');
                                                    domConstruct.empty(userTbl);
                                                    var users = json.parse(response);
                                                    arrayUtil.forEach(users, function (user, i) {
                                                        var tr = domConstruct.create('tr', null, userTbl);
                                                        domConstruct.create("td", {innerHTML: i + 1}, tr);
                                                        domConstruct.create("td", {innerHTML: user.profile ? user.photo : ''})
                                                        domConstruct.create("td", {innerHTML: user.fullname}, tr);
                                                        domConstruct.create("td", {innerHTML: user.profile ? user.profile.email : ''}, tr);
                                                        domConstruct.create("td", {innerHTML: "<button id='btn" + user.id + " type='button' class='btn enrol'>添加</button>"}, tr);
                                                    });
                                                    query('.active.page-num').removeClass('active');
                                                    domClass.toggle(e.target.parentNode, 'active');
                                                    if (p == 0) {
                                                        domClass.add(dom.byId('backAnchor'), 'disabled');
                                                    } else {
                                                        domClass.remove(dom.byId('backAnchor'), 'disabled');
                                                    }
                                                    if (query(e.target.parentNode).next()[0].id == 'forwardAnchor') {
                                                        domClass.add(dom.byId('forwardAnchor'), 'disabled');
                                                    } else {
                                                        domClass.remove(dom.byId('forwardAnchor'), 'disabled');
                                                    }
                                                });
                                    });
                        }
                    }
                });
            });
            query("#enrol-done").on("click", function () {
                require(['dojo/request'], function (request) {
                    request.post("${request.contextPath}/course/listMembers/${params.id}", {
                        headers: {
                            'Accept': 'application/json'
                        }
                    }).then(function (response) {
                                require(['dojo/dom', 'dojo/dom-construct', 'dojo/_base/array', 'dojo/json', 'dojo/query', 'dojo/date/locale', 'dojo/dom-construct'],
                                        function (dom, domConstruct, arrayUtil, json, query, locale, domConstruct) {
                                            domConstruct.empty(dom.byId('userRows'));
                                            var users = json.parse(response);
                                            arrayUtil.forEach(users, function (user) {
                                                var userDiv = dom.byId('userRows');
                                                var tr = domConstruct.create('tr', null, userDiv);
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
                                                    roles = roles + role.name + ';';
                                                });
                                                domConstruct.create("td", {innerHTML: roles}, tr);
                                            });
                                            query('.inSearch').removeClass('inSearch');
                                            searchTotal = -1;
                                        });
                            });
                });
            });
        });
    });
</script>
</body>
</html>

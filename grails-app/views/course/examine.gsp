<%@ page import="com.sanwn.mousika.Role; com.sanwn.mousika.User; com.sanwn.mousika.Course" %>

<!DOCTYPE html>
<html>
    <head>
        <title><g:message code="course.approve.label"/></title>
        <style>
        li {
            cursor: text;
        }
        </style>
    </head>

    <body>
        <h4 id="courseTitleHead"
            style="border-bottom: 1px solid #000;color: #777777;">
            <g:message code="course.approve.label"/>
        </h4>
        <table id="applicantTbl" class="table table-striped">
            <thead>
                <th><input id="checkAll" type="checkbox"></th>
                <th>姓名</th>
                <th>申请时间</th>
                <th>操作</th>
            </thead>
            <tbody id="userRows">
                <g:each in="${applications}" var="apply">
                    <tr>
                        <td><input id="apply${apply.id}" class="examine"
                                   type="checkbox"></td>
                        <td><a href="${createLink(controller: 'user', action: 'show', id: apply.applicant.id)}">${apply.applicant.fullname}</a>
                        </td>
                        <td><g:formatDate
                                date="${apply.applyDate}"
                                format="yyyy-MM-dd HH:mm:ss"/></td>
                        <td>
                            <a id="btn${apply.id}" href="#"
                               class="btn btn-success btn-approve">批准</a>
                            <a id="deny${apply.id}" href="#"
                               class="btn btn-deny"
                               style="padding-left:5px;">拒绝</a>
                        </td>
                    </tr>
                </g:each>
                <tr colspan="4">
                    <p>
                        <a class="btn"
                           href="${createLink(action: 'show', id: 63)}">返回到课程</a>
                        <a id="batchApprove" class="btn" href="#">批量批准</a>
                        <a id="batchDeny" class="btn" href="#">批量拒绝</a>
                    </p>
                </tr>
            </tbody>
        </table>
        <g:paginate total="${total}" controller="course" action="approve"
                    id="${params.id}"
                    max="20"
                    prev="&lt; previous"
                    next="next &gt;"></g:paginate>
        <a class="btn"
           href="${createLink(action: 'show', id: 63)}">返回到课程</a>
        <script>
            require(['dojo/dom', 'dojo/on', 'dojo/query', 'dojo/dom-attr', 'dojo/_base/event',
                'dojo/request', 'dojo/json', 'dojo/_base/array', 'dojo/dom-construct', 'dojo/date/locale', 'dojo/domReady!'],
                    function (dom, on, query, domAttr, event, request, json, arrayUtils, domConstruct, locale) {
                        on(dom.byId('checkAll'), 'click', function (e) {
                            query('.examine').forEach(function (node) {
                                domAttr.set(node, 'checked', e.target.checked);
                            });
                        });
                        var responseHandler = function (response) {
                            var j = json.parse(response);
                            if (!j.success) {
                                alert('更新失败！');
                                return;
                            }
                            var userTbl = dom.byId('userRows');
                            domConstruct.empty(userTbl);
                            var applications = j.applications;
                            arrayUtils.forEach(applications, function (application, i) {
                                var tr = domConstruct.create('tr', null, userTbl);
                                domConstruct.create("td",
                                        {innerHTML: '<input id="apply"' + application.id + ' class="examine" type="checkbox">'}, tr);
                                domConstruct.create("td",
                                        {innerHTML: "<a href='${request.contextPath}/user/show/" + application.applicantId + "'>" + application.applicantName + "</a>"}, tr);
                                domConstruct.create("td",
                                        {innerHTML: locale.format(new Date(application.applyDate), {
                                            datePattern: 'yyyy-MM-dd hh:mm:ss'
                                        })}, tr);
                                domConstruct.create("td", {innerHTML: '<a href="#" class="btn btn-success">批准</a><a href="#" class="btn">打回</a>'}, tr);
                            });
                        };
                        var max = ${params.max ?: 20};
                        var offset = ${params.offset ?: 0};
                        var requestUrl = "${request.contextPath}/course/approve/${params.id}";
                        var requestData = {
                            max: max,
                            offset: offset,
                            sort: 'applyDate',
                            status: 'approved',
                            batch: false
                        };
                        query('.btn-deny').on('click', function (e) {
                            event.stop(e);
                            var id = e.target.id.match(/deny(\d+)$/)[1];
                            if (!dom.byId('apply' + id).checked) return;
                            requestData.examine = id;
                            requestData.status = 'denied';
                            request.post(requestUrl, {
                                data: requestData
                            }).then(responseHandler);
                        });
                        on(dom.byId('batchDeny'), 'click', function (e) {
                            event.stop(e);
                            var examined = []
                            query('input.examine:checked').forEach(function (node) {
                                var id = node.id.match(/apply(\d+)$/)[1];
                                examined.push(id);
                            });
                            if (examined.length > 0) {
                                requestData.examine = examined;
                                requestData.status = "denied";
                                requestData.batch = true;
                                request.post(requestUrl, {
                                    data: requestData
                                }).then(responseHandler);
                            }
                        });
                        query('.btn-approve').on('click', function (e) {
                            event.stop(e);
                            var id = e.target.id.match(/btn(\d+)$/)[1];
                            if (!dom.byId('apply' + id).checked) return;
                            requestData.examine = id;
                            request.post(requestUrl, {
                                data: requestData
                            }).then(responseHandler);
                        });
                        on(dom.byId('batchApprove'), 'click', function (e) {
                            event.stop(e);
                            var approved = []
                            query('input.examine:checked').forEach(function (node) {
                                var id = node.id.match(/apply(\d+)$/)[1];
                                approved.push(id);
                            });
                            if (approved.length > 0) {
                                requestData.examine = approved;
                                requestData.batch = true;
                                request.post(requestUrl, {
                                    data: requestData
                                }).then(responseHandler);
                            }
                        });
                    })
        </script>
    </body>
</html>

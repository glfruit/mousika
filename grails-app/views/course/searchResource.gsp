<%@ page defaultCodec="html" %>
<%@ page import="org.apache.commons.lang.StringEscapeUtils; org.springframework.util.ClassUtils" %>
<%@ page import="grails.plugin.searchable.internal.lucene.LuceneUtils" %>
<%@ page import="grails.plugin.searchable.internal.util.StringQueryUtils" %>
<html>
    <head>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8">
        <title><g:if
                test="${params.q && params.q?.trim() != ''}">${params.q} -</g:if>课程搜索</title>
        <script type="text/javascript">
            var focusQueryInput = function () {
                document.getElementById("q").focus();
            }
        </script>
    </head>

    <body onload="focusQueryInput();">
        <div id="header" style="padding-top: 20px;">
            <h4>"${params.q}"的搜索结果</h4>
        </div>

        <div id="main">
            <g:set var="haveQuery" value="${params.q?.trim()}"/>
            <g:set var="haveResults" value="${searchResult?.results}"/>
            <div class="title">
                <span>
                    <g:if test="${haveQuery && haveResults}">
                        显示：<strong>${searchResult.offset + 1}</strong> - <strong>${searchResult.results.size() + searchResult.offset}</strong>,<strong>共${searchResult.total}</strong>
                        条结果
                    </g:if>
                    <g:else>
                        &nbsp;
                    </g:else>
                </span>
            </div>

            <g:if test="${haveQuery && !haveResults && !parseException}">
                <p>未找到匹配“<strong>${params.q}</strong>“的结果。</p>
            </g:if>

            <g:if test="${parseException}">
                <p>输入的查询关键字“<strong>${params.q}</strong>“不正确。</p>
            </g:if>

            <g:if test="${haveResults}">
                <table class="table table-striped">
                    <tr>
                        <td>资源名称</td>
                        <td>所属单元</td>
                        <td>所属课程</td>
                        <td></td>
                    </tr>
                    <g:each var="result" in="${searchResult.results}"
                            status="index">
                        <tr>
                            <td>
                                <g:link controller="${result.content.type}"
                                        action="show" id="${result.content.id}">
                                    ${result.title}
                                </g:link>
                            </td>
                            <td>
                                <g:link controller="course" action="show"
                                        id="${result.unit.course.id}"
                                        fragment="courseSection${result.unit.sequence}">
                                    ${result.unit.title}
                                </g:link>
                            </td>
                            <td>
                                <g:link controller="course" action="show"
                                        id="${result.unit.course.id}">
                                    ${result.unit.course.title}
                                </g:link>
                            </td>
                            <td>
                                <a role="button" data-toggle="modal" href="#"
                                   class="copy-resource-${result.id} copy-resource-link">
                                    <i class="icon-download-alt copy-resource-${result.id}"></i>
                                </a>
                            </td>
                        </tr>
                    </g:each>
                </table>

                <div dojoType="dijit.Dialog" jsId="courseDialog"
                     data-dojo-props="title:'导入课程资源'"
                     style="width: 400px;display: none;">
                    <div>
                        <div dojoType="dojo.data.ItemFileWriteStore"
                             url="${createLink(controller: 'course', action: 'listMine')}"
                             jsId="courseStore"></div>

                        <div dojoType="dijit.tree.ForestStoreModel"
                             rootLabel="我的课程" store="courseStore"
                             childrenAttrs="units,unitItems"
                             jsId="ordModel"></div>

                        <div dojoType="dijit.Tree" id="ordTree"
                             model="ordModel">
                            <script type="dojo/method" event="onClick"
                                    args="item,node">
                                if(!item.id) return;
                                selectedOne = {
                                item: item,
                                id: item.id[0],
                                title: item.title[0],
                                type: item.type[0],
                                parentId: item.parentId ? item.parentId[0] : null
                                };
                            </script>
                        </div>
                    </div>

                    <div class="pull-right" style="margin-bottom: 10px;">
                        <button id="copyResourceBtn"
                                class="btn btn-primary">导入</button>
                        <button class="btn" id="cancelBtn">取消</button>
                    </div>
                </div>

                <div>
                    <g:if test="${haveResults}">
                        <mousika:paginate controller="course"
                                          class="pagination pagination-centered"
                                          action="search"
                                          params="[q: params.q, type: 'resource']"
                                          total="${searchResult.total}"/>
                    </g:if>
                </div>
            </g:if>
            <script>
                require(['dojo/_base/event', 'dojo/query', 'dojo/_base/array', 'dojo/request', 'dojo/json', 'dijit/Dialog', 'dojo/data/ItemFileWriteStore', 'dijit/tree/ForestStoreModel', 'dijit/Tree', 'bootstrap/Modal', 'dojo/domReady!'],
                        function (event, query, arrayUtils, request, json) {
                            query('.copy-resource-link').on('click', function (e) {
                                event.stop(e);
                                var cls = query(e.target).attr('class')[0].split(' ');
                                var itemId = -1;
                                arrayUtils.forEach(cls, function (c) {
                                    if (c.startsWith('copy-resource')) {
                                        itemId = c.split('-')[2];
                                    }
                                });
                                if (itemId == -1) {
                                    console.error("Someting must be wrong!");
                                }
                                courseDialog.set('itemId', itemId);
                                courseDialog.show();
                            });
                            query('#cancelBtn').on('click', function () {
                                courseDialog.hide();
                            });
                            query('#copyResourceBtn').on('click', function (e) {
                                event.stop(e);
                                var itemId = courseDialog.get('itemId');
                                var parentItem;
                                if (selectedOne.type == 'unit') {
                                    parentItem = selectedOne.item;
                                } else if (selectedOne.type == 'unitItem') {
                                    courseStore.fetchItemByIdentity({
                                        identity: selectedOne.parentId,
                                        onItem: function (item) {
                                            if (!item.id) return;
                                            parentItem = item;
                                        },
                                        onError: function (e) {
                                            console.log("Item Not Found");
                                        }
                                    });
                                } else {
                                    alert('请选择一个单元或者内容节点！');
                                    return;
                                }
                                request.post("${request.contextPath}/unitItem/copy",
                                        {
                                            data: {
                                                type: selectedOne.type,
                                                sourceId: itemId,
                                                targetId: selectedOne.id}}).then(function (response) {
                                            var result = json.parse(response);
                                            if (!result.success) {
                                                if (result.error) alert(result.error);
                                                else alert('出现未知错误！');
                                                return;
                                            }
                                            courseStore.newItem(json.parse(response), {parent: parentItem, attribute: "unitItems"});
                                        });
                            });
                        });
            </script>
        </div>
    </body>
</html>

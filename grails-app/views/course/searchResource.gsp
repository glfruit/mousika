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
        <div id="header">
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
                                <a role="button" data-toggle="modal"
                                   href="#copyResource"><i
                                        class="icon-download-alt"></i>
                                </a>
                            </td>
                        </tr>
                    </g:each>
                </table>

                <div>
                    <div class="paging">
                        <g:if test="${haveResults}">
                            第
                            <g:set var="totalPages"
                                   value="${Math.ceil(searchResult.total / searchResult.max)}"/>
                            <g:if test="${totalPages == 1}"><span
                                    class="currentStep">1</span>页，共1页</g:if>
                            <g:else><g:paginate controller="course"
                                                action="search"
                                                params="[q: params.q, type: 'resource']"
                                                total="${searchResult.total}"
                                                prev="&lt; previous"
                                                next="next &gt;"/></g:else>
                        </g:if>
                    </div>
                </div>
            </g:if>
            <div>
                <div dojoType="dojo.data.ItemFileReadStore"
                     url="${createLink(controller: 'course', action: 'listMine')}"
                     jsId="ordJson"></div>

                <div dojoType="dijit.tree.ForestStoreModel"
                     rootLabel="我的课程"
                     store="ordJson" jsId="ordModel"></div>

                <div dojoType="dijit.Tree" id="ordTree"
                     model="ordModel"></div>
            </div>
            <script>
                require(['dijit/Dialog', 'dojo/query', 'dojo/data/ItemFileReadStore', 'dijit/tree/ForestStoreModel', 'dijit/Tree', 'bootstrap/Modal', 'dojo/domReady!'],
                        function (Dialog, query) {
                            myDialog = new Dialog({
                                title: "导入课程资源",
                                content: "Test content.",
                                style: "width: 300px"
                            });
                            query('.icon-download-alt').on('click', function () {
                                myDialog.show();
                            });
                        });
            </script>
        </div>
    </body>
</html>

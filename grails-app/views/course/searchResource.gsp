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
                <p><g:message
                        code="search.notfound.label"/> <strong>${params.q}</strong>
                </p>
                <g:if test="${!searchResult?.suggestedQuery}">
                    <p>Suggestions:</p>
                    <ul>
                        <li>Try a suggested query: <g:link
                                controller="searchable" action="index"
                                params="[q: params.q, suggestQuery: true]">Search again with the <strong>suggestQuery</strong> option</g:link><br/>
                            <em>Note: Suggestions are only available when classes are mapped with <strong>spellCheck</strong> options, either at the class or property level.<br/>
                                The simplest way to do this is add <strong>spellCheck "include"</strong> to the domain class searchable mapping closure.<br/>
                                See the plugin/Compass documentation Mapping sections for details.
                            </em>
                        </li>
                    </ul>
                </g:if>
            </g:if>

            <g:if test="${searchResult?.suggestedQuery}">
                <p>Did you mean <g:link controller="searchable" action="index"
                                        params="[q: searchResult.suggestedQuery]">${StringQueryUtils.highlightTermDiffs(params.q.trim(), searchResult.suggestedQuery)}</g:link>?</p>
            </g:if>

            <g:if test="${parseException}">
                <p>Your query - <strong>${params.q}</strong> - is not valid.</p>

                <p>Suggestions:</p>
                <ul>
                    <li>Fix the query: see <a
                            href="http://lucene.apache.org/java/docs/queryparsersyntax.html">Lucene query syntax</a> for examples
                    </li>
                    <g:if test="${LuceneUtils.queryHasSpecialCharacters(params.q)}">
                        <li>Remove special characters like <strong>" - [ ]</strong>, before searching, eg, <em><strong>${LuceneUtils.cleanQuery(params.q)}</strong>
                        </em><br/>
                            <em>Use the Searchable Plugin's <strong>LuceneUtils#cleanQuery</strong> helper method for this: <g:link
                                    controller="searchable" action="index"
                                    params="[q: LuceneUtils.cleanQuery(params.q)]">Search again with special characters removed</g:link>
                            </em>
                        </li>
                        <li>Escape special characters like <strong>" - [ ]</strong> with <strong>\</strong>, eg, <em><strong>${LuceneUtils.escapeQuery(params.q)}</strong>
                        </em><br/>
                            <em>Use the Searchable Plugin's <strong>LuceneUtils#escapeQuery</strong> helper method for this: <g:link
                                    controller="searchable" action="index"
                                    params="[q: LuceneUtils.escapeQuery(params.q)]">Search again with special characters escaped</g:link>
                            </em><br/>
                            <em>Or use the Searchable Plugin's <strong>escape</strong> option: <g:link
                                    controller="searchable" action="index"
                                    params="[q: params.q, escape: true]">Search again with the <strong>escape</strong> option enabled</g:link>
                            </em>
                        </li>
                    </g:if>
                </ul>
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
                                <a class="btn btn-primary" href="#">引用</a>
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
        </div>
    </body>
</html>

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
            <g:form class="form-search"
                    url="[controller: 'course', action: 'search']" method='get'>
                <g:textField name="q" value="${params.q}" size="50"
                             class="input-medium search-query"/>
                <button type="submit" class="btn"><g:message
                        code="course.search.label"/></button>
            </g:form>
            <div style="clear: both; display: none;" class="hint">See <a
                    href="http://lucene.apache.org/java/docs/queryparsersyntax.html">Lucene query syntax</a> for advanced queries
            </div>
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
                <p>Nothing matched your query - <strong>${params.q}</strong></p>
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
                <div class="results">
                    <g:each var="result" in="${searchResult.results}"
                            status="index">
                        <section
                                style="border: 1px solid #A0A0A0;padding-left: 10px;padding-right: 10px;margin-top:10px;margin-bottom: 10px;">
                            <ul class="thumbnails">
                                <li class="span5">
                                    <h3>
                                        <g:link action="show"
                                                id="${result.id}">
                                            ${fieldValue(bean: result, field: "title")}
                                        </g:link>
                                    </h3>

                                    %{--<p>教师：<g:link controller="user" action="show"--}%
                                    %{--id="${teachers[i]?.user?.id}">${teachers[i]?.user?.fullname}</g:link></p>--}%
                                </li>
                                <li class="span6">
                                    ${result.description.decodeHTML()}
                                </li>
                            </ul>
                        </section>
                    </g:each>
                </div>

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
                                                params="[q: params.q]"
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

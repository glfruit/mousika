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

                                    <p>教师：
                                    <g:if test="${result.deliveredBy}">
                                        <g:link controller="user"
                                                action="show"
                                                id="${result.deliveredBy?.id}">
                                            ${result.deliveredBy?.fullname}
                                        </g:link>
                                    </g:if>
                                    <g:else>
                                        N/A
                                    </g:else>
                                        <a href="${createLink(controller: 'course', action: 'copy', id: result.id)}">
                                            <span style="padding-left: 5px;">
                                                <i class="icon-download-alt"></i>导入
                                            </span>
                                        </a>
                                    </p>
                                </li>
                                <li class="span6">
                                    <%=result.description%>
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
                            <g:else>
                                <mousika:paginate controller="course"
                                                  action="search"
                                                  params="[q: params.q]"
                                                  total="${searchResult.total}"/>
                            </g:else>
                        </g:if>
                    </div>
                </div>
            </g:if>
        </div>
    </body>
</html>

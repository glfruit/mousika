<div class="course-section">
    <g:set var="beginDate" value="${startDate + (order - 1) * 7}"/>
    <g:set var="endDate" value="${beginDate + 6}"/>
    <g:set var="today" value="${new Date()}"/>
    <div
            style="width:5%;display:table-cell;background: none repeat scroll 0% 0% ${today >= beginDate && today <= endDate ? 'rgb(255,217,145)' : '#FFFFFF'};">
        <g:if test="${section.sequence != 0}">
            <i class="icon-move"
               style="position:relative;top:5px;left:10px;"></i>
        </g:if>
    </div>

    <div style="width:90%;display:table-cell;background-color: #FAFAFA;">
        <g:if test="${section.sequence != 0}">
            <h4 style="padding-left: 10px;color: #777777;">
                <g:formatDate
                        date="${beginDate}"
                        format="yyyy-MM-dd"/>
                - <g:formatDate
                    date="${endDate}"
                    format="yyyy-MM-dd"/></h4>
        </g:if>
        <g:set var="courseSectionId" value="courseSection${section.sequence}"/>
        <ul data-dojo-type="dojo.dnd.Source"
            data-dojo-props="accept: ['content'], withHandles: true, autoSync: true"
            class="dojoDndSource sectionContent"
            style="list-style: none;height:100px;"
            id="${courseSectionId}">
            %{--<g:if test="${section.sequence == 0}">--}%
                %{--<li class="dojoDndItem" dndType="content">--}%
                    %{--<p>新闻讨论区</p>--}%
                %{--</li>--}%
            %{--</g:if>--}%
            <g:each in="${section.contents}" var="content" status="s">
                <li id="${courseSectionId}item${s}"
                    class="dojoDndItem" dndType="content">
                    <div style="display: inline;">
                    <div style="float: left; padding-right: 3em;">
                        <g:if test="${content.type != 'label'}">
                            <a href="${createLink(controller: content.type, action: 'show', id: content.id)}">
                                ${content.title}
                            </a>
                            <span class="resource-link-details"></span>
                            </div>
                        </g:if>
                        <g:else>
                            ${org.apache.commons.lang.StringEscapeUtils.unescapeHtml(content.labelContent)}
                        </g:else>
                        <span class="commands">
                            <a href="#"><i class="icon-pencil"></i></a>
                            <a href="#" style="cursor: move;"><i
                                    class="icon-move dojoDndHandle"></i></a>
                            <a href="#"><i class="icon-eye-open"></i></a>
                        </span>
                    </div>

                    <div style="clear: both"></div>
                </li>
            </g:each>
        </ul>

        <div class="pagination pagination-right">
            <a id="csl${order}" href="#addActivityOrResourceModal"
               role="button"
               data-toggle="modal"
               class="addContent"
               style="text-align: right;margin-right: 5px;">
                <span>
                    <i class="icon-plus"></i> 添加一个活动或资源
                </span>
            </a>
        </div>
    </div>

    <div style="width:5%;display:table-cell;background: none repeat scroll 0% 0% ${today >= beginDate && today <= endDate ? 'rgb(255,217,145)' : '#FFFFFF'};"></div>
</div>
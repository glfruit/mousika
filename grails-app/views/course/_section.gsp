<g:set var="courseSectionId" value="courseSection${section.sequence}"/>
<g:if test="${section.sequence == 0}">
    <div id="${courseSectionId}" class="course-section ${section.visible ? 'show-unit-or-item' : 'hide-unit-or-item'}">
</g:if>
<g:else>
    <div id="${courseSectionId}" data-dojo-id="${courseSectionId}"
     class="dojoDndItem course-section ${section.visible ? 'show-unit-or-item' : 'hide-unit-or-item'}"
     dndType="unit">
</g:else>
<g:set var="beginDate" value="${startDate + (order - 1) * 7}"/>
<g:set var="endDate" value="${beginDate + 6}"/>
<g:set var="today" value="${new Date()}"/>
<div
        style="width:40px;;display:table-cell;background: none repeat scroll 0% 0% ${today >= beginDate && today <= endDate ? 'rgb(255,217,145)' : '#FFFFFF'};">
    <g:if test="${section.sequence != 0}">
        <i class="edit-course-region icon-move dojoDndHandle" rel="tooltip"
           title="移动课程单元"
           style="position:relative;top:5px;left:10px;cursor: move;"></i>
    </g:if>
</div>

<div style="width:650px;display:table-cell;background-color: #FAFAFA;height: 100%;">
    <g:if test="${section.sequence != 0}">
        <h4 style="padding-left: 10px;color: #777777;">
            <div id="editSectionTitle${section.sequence}" class="edit-course-region edit-section-title"><%=section.title%></div>

            <div id="sectionTitle${section.sequence}" class="edit-course-region hide"><%=section.title%></div>
        </h4>
    </g:if>
    <div>
        <ul data-dojo-type="dojo.dnd.Source"
            data-dojo-props="accept: ['content'], withHandles: true, autoSync: true"
            class="dojoDndSource sectionContent"
            style="list-style: none;height:auto;"
            id="list${courseSectionId}" data-dojo-id="list${courseSectionId}">
            <g:each in="${section.items}" var="item" status="s">
                <li id="${courseSectionId}item${s}"
                    class="dojoDndItem ${item.visible ? 'show-unit-or-item' : 'hide-unit-or-item'}"
                    dndType="content">
                    <div style="display: inline;">
                        <div style="float: left; padding-right: 3em;"
                             class="${courseSectionId}Item${item.sequence}">
                            <g:if test="${item.content.type == 'urlResource'}">
                                <a href="${item.content.location}"
                                   target="_blank">${item.title}</a>
                            </g:if>
                            <g:elseif test="${item.content.type == 'assignment'}">
                                <shiro:hasRole name="学生">
                                    <a href="${createLink(controller: 'student', action: 'resource', id: item.content.id)}">${item.title}</a>
                                </shiro:hasRole>
                                <shiro:hasAnyRole in="['教师', '系统管理员', '课程负责人']">
                                    <a href="${createLink(controller: item.content.type, action: 'show', id: item.content.id)}">${item.title}</a>
                                </shiro:hasAnyRole>
                                <span class="resource-link-details"></span>
                            </g:elseif>
                            <g:elseif test="${item.content.type == 'forum'}">
                                <a href="${request.contextPath}/course/${course.id}/forum/${item.content.id}">${item.title}</a>
                            </g:elseif>
                            <g:elseif test="${item.content.type != 'label'}">
                                <g:if test="${item.content.type == 'fileResource'}">
                                    <a href="${createLink(controller: item.content.type, action: 'show', id: item.content.id,
                                            params: ['type': item.content.fileType])}"
                                       class="fileType">
                                        ${item.title}
                                    </a>
                                </g:if>
                                <g:else>
                                    <a href="${createLink(mapping: 'mousika', controller: item.content.type, action: 'show', id: item.content.id,
                                            params: [courseId: course.id, unitId: section.id])}">
                                        ${item.title}
                                    </a>
                                </g:else>
                                <span class="resource-link-details"></span>
                            </g:elseif>
                            <g:else>
                                <span class="labelContent"><%=item.content.labelContent%></span>
                            </g:else>
                        </div>

                        <div class="edit-course-region">
                            <span class="commands">
                                %{--<a href="#" rel="tooltip" title="编辑标题">--}%
                                %{--<i class="icon-pencil"></i>--}%
                                %{--</a>--}%
                                <a href="#" rel="tooltip" title="移动内容"
                                   style="cursor: move;">
                                    <i class="icon-move dojoDndHandle"></i>
                                </a>
                                <a href="${createLink(mapping: 'mousika', controller: item.content.type, action: 'edit', id: item.content.id,
                                        params: [courseId: course.id, unitId: section.id])}"
                                   rel="tooltip" title="编辑内容">
                                    <i class="icon-edit"></i>
                                </a>
                                <a href="#" rel="tooltip" title="隐藏或显示内容">
                                    <i class="${item.visible ? 'icon-eye-open' : 'icon-eye-close'} ${courseSectionId}item${s}"></i>
                                </a>
                            </span>
                        </div>
                    </div>

                    <div style="clear: both"></div>
                </li>
            </g:each>
        </ul>
    </div>

    <div class="pagination pagination-right edit-course-region">
        <a id="csl${order}" href="#addActivityOrResourceModal"
           role="button"
           data-toggle="modal"
           class="addContent"
           style="text-align: right;margin: 0 5px 0 0;">
            <span>
                <shiro:hasAnyRole in="['教师', '系统管理员', '课程负责人']">
                    <i class="icon-plus"></i> 添加一个活动或资源
                </shiro:hasAnyRole>
            </span>
        </a>
    </div>
</div>

<div style="width:40px;;display:table-cell;background: none repeat scroll 0% 0% ${today >= beginDate && today <= endDate ? 'rgb(255,217,145)' : '#FFFFFF'};">
    <i class="${section.visible ? 'icon-eye-open' : 'icon-eye-close'} ${courseSectionId} edit-course-region"
       rel="tooltip" title="隐藏或显示课程单元"
       style="position:relative;top:5px;left:10px;"></i>
</div>
</div>
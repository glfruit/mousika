<div class="row-fluid"
     style="border: 1px solid #E1E1E8;margin-bottom: 10px;margin-top: 10px;">
    <g:set var="beginDate" value="${startDate + order * 7}"/>
    <g:set var="endDate" value="${beginDate + 6}"/>
    <g:set var="today" value="${new Date()}"/>
    <div class="span1"
         style="background: none repeat scroll 0% 0% ${today >= beginDate && today <= endDate ? 'rgb(255,217,145)' : '#FFFFFF'};"></div>

    <div class="span10" style="background-color: #FAFAFA;">
        <h4 style="padding-left: 10px;color: #777777;">
            <g:formatDate
                    date="${beginDate}"
                    format="yyyy-MM-dd"/>
            - <g:formatDate
                date="${endDate}"
                format="yyyy-MM-dd"/></h4>
        <i class="icon-move" style="position:relative;top:10px;left:10px;"></i>
        <ul data-dojo-type="dojo.dnd.Source"
            data-dojo-props="accept: ['content']"
            style="list-style: none;height:100px;"
            id="courseSection${order + 1}">
            <g:each in="${section.contents}" var="content">
                <li class="dojoDndItem" style="list-style: none;"
                    dndType="content">
                    <div style="display: inline;">
                        <div style="float: left; padding-right: 3em;">
                            <a href="${createLink(controller: content.type, action: 'show', id: content.id)}">
                                ${content.title}
                            </a>
                            <span class="resource-link-details"></span>
                        </div>
                        <span class="commands">
                            <a href="#"><i class="icon-pencil"></i></a>
                            <a href="#" style="cursor: move;"><i
                                    class="icon-move"></i></a>
                            <a href="#"><i class="icon-eye-open"></i></a>
                        </span>
                    </div>
                </li>
            </g:each>
        </ul>

        <div class="pagination pagination-right">
            <a id="csl${order + 1}" href="#addActivityOrResourceModal"
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

    <div class="span1"></div>
</div>
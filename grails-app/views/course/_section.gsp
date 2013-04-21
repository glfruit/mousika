<div style="border: 1px solid #E1E1E8;margin-bottom: 10px;margin-top: 10px;">
    <h4 style="padding-left: 10px;color: #E1E1E8;">
        <g:formatDate
                date="${startDate + order * 7}"
                format="yyyy-MM-dd"/>
        - <g:formatDate
            date="${startDate + order * 7 + 6}"
            format="yyyy-MM-dd"/></h4>
    <ol data-dojo-type="dojo.dnd.Source"
        data-dojo-props="accept: ['content']"
        id="courseSection${order}">
        <g:each in="${section.contents}" var="content">
            <li class="dojoDndItem" dndType="content">content.title</li>
        </g:each>
    </ol>

    <div class="pagination pagination-right">
        <a href="#addActivityOrResourceModal" role="button"
           data-toggle="modal"
           style="text-align: right;margin-right: 5px;">
            <span>
                <i class="icon-plus"></i> 添加一个活动或资源
            </span>
        </a>
    </div>
</div>
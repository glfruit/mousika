<div class="control-group">
    <label class="control-label ${required ? 'required' : ''}"
           for="${property}">
        ${label}<g:if test="required">*</g:if>
    </label>

    <div class="controls">
        <g:select name="${property}" keys="${['online', 'file', 'offline']}"
                  from="${['在线作业', '上传文件', '离线作业']}" value="${value}"/>
    </div>
</div>
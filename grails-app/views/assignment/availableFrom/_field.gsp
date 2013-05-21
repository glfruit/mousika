<div class="control-group">
    <label class="control-label ${required ? 'required' : ''}"
           for="${property}">
        ${label}<g:if test="${required}">*</g:if>
    </label>

    <div class="controls">
        <div class="input-append date"
             data-date-format="yyyy-mm-dd">
            <input type="text" name="${property}"
                   value="${formatDate(format: 'yyyy-MM-dd', date: value)}"
                   readonly="true"/>
            <span class="add-on"><i class="icon-th"></i></span>
        </div>
    </div>
</div>
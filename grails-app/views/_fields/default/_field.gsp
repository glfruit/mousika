<div class="control-group">
    <label class="control-label ${required ? 'required' : ''}"
           for="${property}">${label}<g:if test="${required}">*</g:if></label>

    <div class="controls">
        <g:if test="${type == Date}">
            <div class="input-append date"
                 data-date-format="yyyy-mm-dd">
                <input type="text" name="${property}" value="${value}"
                       readonly="true"/>
                <span class="add-on"><i class="icon-th"></i></span>
            </div>
        </g:if>
        <g:elseif test="${type == boolean || type == Boolean}">
            <g:checkBox name="${property}" value="${value}"/>
        </g:elseif>
        <g:elseif test="${type == String || type == int}">
            <g:textField name="${property}" value="${value}"/>
        </g:elseif>
    </div>
</div>
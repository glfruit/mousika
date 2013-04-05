<div class="control-group">
    <label class="control-label" for="${property}">${label}</label>

    <div class="controls">
        <g:if test="${type == Date}">
            <g:datePicker name="${property}" value="${value}" precision="day"/>
        %{--<g:textField name="${property}" value="${value}"--}%
        %{--data-dojo-type="dijit/form/DateTextBox"/>--}%
        </g:if>
        <g:elseif test="${type == boolean || type == Boolean}">
            <g:checkBox name="${property}" value="${value}"/>
        </g:elseif>
        <g:elseif test="${type == String || type == int}">
            <g:textField name="${property}" value="${value}"/>
        </g:elseif>
    </div>
</div>
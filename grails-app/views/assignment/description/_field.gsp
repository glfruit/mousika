<div class="control-group ${required ? 'required' : ''}">
    <label class="control-label" for="${property}">
        ${label}<g:if test="required">*</g:if>
    </label>

    <div class="controls">
        <g:textArea name="${property}" value="${value}" rows="10"/>
    </div>
</div>
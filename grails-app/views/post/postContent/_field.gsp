<div class="control-group">
    <label class="control-label ${required ? 'required' : ''}"
           for="${property}">${label}<g:if test="${required}">*</g:if></label>

    <div class="controls">
        <g:textArea name="${property}" value="${value}" rows="15" class="input-block-level"/>
    </div>
</div>
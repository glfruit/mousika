<div class="control-group">
    <label class="control-label ${required ? 'required' : ''}"
           for="${property}">${label}<g:if test="${required}">*</g:if></label>

    <div class="controls">
        <input type="file" name="${property}" value="${value}">
    </div>
</div>
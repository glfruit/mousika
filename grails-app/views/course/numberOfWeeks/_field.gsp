<div class="control-group">
    <label class="control-label" for="${property}">
        ${label}
    </label>

    <div class="controls">
        <g:select name="${property}" from="${(value ?: 0)..18}" value="${value}"/>
    </div>
</div>
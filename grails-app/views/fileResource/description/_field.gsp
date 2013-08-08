<div class="control-group ${required ? 'required' : ''}">
    <label class="control-label" for="${property}">
        ${label}<g:if test="${required}">*</g:if>
    </label>

    <div class="controls">
        <g:textArea name="${property}" value="${value}" rows="10" cols="10"/>
        %{--<div>--}%
            %{--<g:render template="/uploader"/>--}%
        %{--</div>--}%
        <ckeditor:editor name="${property}" height="400px" width="80%"
        filebrowserBrowseUrl="${request.contextPath}/ckfinder/ckfinder.html"
        filebrowserImageBrowseUrl="${request.contextPath}/ckfinder/ckfinder.html?Type=Images"
        filebrowserUploadUrl="${request.contextPath}/ckfinder/core/connector/java/connector.java?command=QuickUpload&type=Files"
        filebrowserImageUploadUrl="${request.contextPath}/ckfinder/core/connector/java/connector.java?command=QuickUpload&type=Images">
        ${value}
        </ckeditor:editor>
    </div>
</div>
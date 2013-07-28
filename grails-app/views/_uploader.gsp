<link href="${resource(dir: 'css', file: 'fineuploader-3.5.0.css')}" rel="stylesheet"
      type="text/css">

<div id="image-uploader">
    <noscript>
        <p>Please enable JavaScript to use file uploader.</p>
        <!-- or put a simple form for upload here -->
    </noscript>
</div>

<script src="${resource(dir: 'js', file: 'fineuploader-3.5.0.min.js')}"
        type="text/javascript"></script>

<%-- Override the style in the file with the correct pathname --%>
<style type="text/css">
.qq-upload-spinner {
    display: inline-block;
    background: url("${resource(dir:'images',file:'loading.gif')}");
    width: 15px;
    height: 15px;
    vertical-align: text-bottom;
}
</style>
<script>
    function createUploader() {
        var uploader = new qq.FineUploader({
            element: document.getElementById('image-uploader'),
            request: {
                endpoint: '<g:createLink controller="fileResource" action="upload" params=""/>'
            },
            sizeLimit: 3145728, // 3 MB
//            allowedExtensions: ['jpg', 'jpeg'],
            debug: true,
            text: {
                uploadButton: '上传文件'
            }
        });
    }

    // in your app create uploader as soon as the DOM is ready
    // don't wait for the window to load
    window.onload = createUploader;
</script>
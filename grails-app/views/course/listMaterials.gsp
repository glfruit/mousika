<%@ page import="org.apache.commons.io.FilenameUtils; com.sanwn.mousika.FileRepository" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="course">
    <link rel="stylesheet"
          href="${resource(dir: 'css', file: 'dropzone.css')}"
          type="text/css"/>
    <title>${course?.title}->课程资料</title>
</head>

<body>
<g:render template="fileManager"
          model="[course: course, files: files, editor: params.editor, currentPath: currentPath]"/>
<script type="text/javascript">
    require(['jquery', 'dropzone', 'dojo/query', 'dojox/image/Lightbox', 'dojo/domReady!'], function ($, Dropzone, query) {
        Dropzone.options.uploadForm = {
            dictDefaultMessage: '将文件拖至此处上传',
            dictInvalidFileType: "无效的文件类型",
            dictFileTooBig: "文件大小超过允许范围",
            dictResponseError: "系统错误",
            paramName: "file", // The name that will be used to transfer the file
            maxFilesize: 20
        };
        $('#refresher').click(function () {
            window.location.href = $(this).attr('href');
        });
        $('.upload-btn').click(function () {
            $('.uploader').show(500);
        });
        $('.close-uploader').click(function () {
            $('.uploader').hide(500);
            setTimeout(function () {
                window.location.href = $('#refresher').attr('href');
            }, 1000);
        });
        $('.new-folder-btn').click(function () {
            var folder = window.prompt("新建文件夹", "新文件夹");
            if (folder) {
                $.ajax({
                    type: 'post',
                    url: "${createLink(controller: 'course', action: 'newFolder')}",
                    data: {folder: folder, courseId: ${course ? course.id : -1}, currentPath: "${currentPath}"}
                }).done(function (response) {
                            if (!response.success) {
                                alert(response.error);
                                return;
                            }
                            window.location.href = "${request.contextPath}/course/listMaterials/${course?.id}?currentPath=" + response.currentPath;
                        });
            }
        });
        $('.thumbnail').mouseover(function () {
            $(this).find('.box').animate({top: "-20px"}, {queue: false});
        });
        $('.thumbnail').mouseout(function () {
            $(this).find('.box').animate({top: "0px"}, {queue: false});
        });
        $('.icon-pencil').click(function (e) {
            e.preventDefault();
            var p = $(this).parents('.commandsDiv').siblings('.box').children('p');
            var title = p.text();
            var newTitle = window.prompt("重命名", title);
            if (newTitle && newTitle != title) {
                $.ajax({
                    type: 'post',
                    url: "${createLink(controller: 'course', action: 'rename')}",
                    data: {title: title, newTitle: newTitle, courseId: ${course ? course.id : -1}, currentPath: "${currentPath}"}
                }).done(function (response) {
                            if (response.success) {
                                window.location.href = "${request.contextPath}/course/listMaterials/${course?.id}?currentPath=" + response.currentPath;
                            }
                        });
            }
        });
        $('.icon-trash').click(function (e) {
            e.preventDefault();
            var answer = window.confirm("是否删除该文件？")
            if (answer) {
                var thumbnail = $(this).parents('.thumbnail');
                var p = $(this).parents('.commandsDiv').siblings('.box').children('p');
                var title = p.text();
                $.ajax({
                    type: 'post',
                    url: "${createLink(controller: 'course', action: 'remove')}",
                    data: {filename: title, courseId:${course ? course.id : -1}, currentPath: "${currentPath}"}
                }).done(function (response) {
                            if (response.success) {
                                window.location.href = "${request.contextPath}/course/listMaterials/${course?.id}?currentPath=" + response.currentPath;
                            }
                        });
            }
        });
        $('.file-item').click(function (e) {
            var isDirectory = $(this).parents('.directory-link').length;
            if (isDirectory) return;

            e.preventDefault();
            var images = {jpg: true, jpeg: true, gif: true, tif: true, png: true, bmp: true};
            var track = $('#editor_track').val();
            var target = $('#' + track + '_ifr', parent.document);
            var filename = $(this).siblings('.box').children('p').text().trim();
            var href = "${request.contextPath}/course/download?courseId=${course?.id}&currentPath=${FilenameUtils.normalizeNoEndSeparator(currentPath)}";
            href = href + "&filename=" + filename;
            var fileLink;
            var fileType = filename.substring(filename.lastIndexOf('.') + 1);
            if (images[fileType])
                fileLink = '<img src="' + href + '"/>';
            else
                fileLink = '<a href="' + href + '">' + filename + '</a>';
            var imgTarget = $('.mce-img_' + track, parent.document);
            var mediaTarget = $('.mce-video3_' + track, parent.document);
            if (imgTarget.length > 0) {
                imgTarget.children('input').val(href);
            } else if (mediaTarget.length > 0) {
                mediaTarget.val(href);
            } else {
                $(target).contents().find('#tinymce').append(fileLink);
            }
            $('.mce-filemanager', parent.document).find('.mce-close').trigger('click');
        });
    });
</script>
</body>
</html>

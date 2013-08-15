<%@ page import="org.apache.commons.io.FilenameUtils" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="robots" content="noindex,nofollow">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>文件管理器</title>
    <link rel="stylesheet"
          href="${resource(dir: 'js/lib/dijit/themes/tundra', file: 'tundra.css')}"
          type="text/css"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet"
          href="${resource(dir: 'css', file: 'bootstrap.css')}"
          type="text/css"/>
    <link rel="stylesheet"
          href="${resource(dir: 'css', file: 'bootstrap-responsive.css')}"
          type="text/css"/>
    <link rel="stylesheet"
          href="${resource(dir: 'js/lib/dojox/image/resources', file: 'Lightbox.css')}"
          type="text/css"/>
    <link rel="stylesheet"
          href="${resource(dir: 'css', file: 'dropzone.css')}"
          type="text/css"/>
    <link rel="stylesheet"
          href="${resource(dir: 'css', file: 'mousika.css')}"
          type="text/css"/>
    <script type="text/javascript">
        dojoConfig = {
            tlmSiblingOfDojo: false,
            packages: [
                {
                    name: 'bootstrap', location: "${request.contextPath}/js/lib/dojo-bootstrap"
                },
                {
                    name: 'jquery', location: "${request.contextPath}/js/lib/jquery", main: "jquery"
                },
                {
                    name: 'dropzone', location: "${request.contextPath}/js/lib/dropzone", main: "dropzone"
                }
            ],
            has: {
                "dojo-firebug": true,
                "dojo-debug-messages": true,
                "config-tlmSiblingOfDojo": true
            },
            async: true,
            parseOnLoad: true
        };
    </script>
    <script type="text/javascript"
            src="${resource(dir: 'js/lib/dojo', file: 'dojo.js')}"></script>
    <script type="text/javascript">
        require(['dojo/parser']);
    </script>
    <style>
    body {
        margin: 0;
        padding: 0;
    }
    </style>
</head>

<body class="tundra">
<g:if test="${flash.message}">
    <div class="message" role="status"
         style="color: red;">${flash.message}</div>
</g:if>
<div class="uploader">
    <button class="btn btn-inverse close-uploader">
        <i class="icon-backward icon-white"></i>返回
    </button>

    <div class="space10"></div>

    <div class="space10"></div>
    <g:uploadForm controller="fileManager" action="upload"
                  id="uploadForm" class="dropzone">
<<<<<<< HEAD
        <input type="hidden" name="courseId" value="${course.id}"/>
=======
        <input type="hidden" name="courseId" value="${course?.id}"/>
>>>>>>> 560b91b4a6cf542808796cfb86134fd7d5824ede
        <input type="hidden" name="currentPath" value="${currentPath}"/>

        <div class="fallback">
            <input name="file" type="file"/>
            <input type="submit" name="submit" value="OK"/>
        </div>
    </g:uploadForm>
</div>

<div class="container-fluid">
    <div class="row-fluid">
        <ul class="breadcrumb" style="height:20px;">
            <li class="pull-left">
<<<<<<< HEAD
                <a href="${createLink(controller: 'fileManager', params: [courseId: course.id])}"><i
=======
                <a href="${createLink(controller: 'fileManager', params: [courseId: course?.id])}"><i
>>>>>>> 560b91b4a6cf542808796cfb86134fd7d5824ede
                        class="icon-home"></i></a>
                <span class="divider">/</span>
            </li>
            <input id="editor_track" type="hidden" value="${editor}"/>
            <g:set var="normalizedPath"
                   value="${org.apache.commons.io.FilenameUtils.normalizeNoEndSeparator(currentPath)}"/>
            <input class="norm-path" type="hidden" name="normalizedPath"
                   value="${normalizedPath}"/>
            <g:if test="${!normalizedPath.isEmpty() && normalizedPath != '/'}">
                <g:set var="splittedPaths"
                       value="${normalizedPath.split('/')}"/>
                <g:each in="${splittedPaths}" status="i"
                        var="path">
                    <g:if test="${i < splittedPaths.size() - 1}">
                        <li class="pull-left">
                            <a href="${createLink(controller: 'fileManager',
<<<<<<< HEAD
                                    params: [courseId: course.id,
=======
                                    params: [courseId: course?.id,
>>>>>>> 560b91b4a6cf542808796cfb86134fd7d5824ede
                                            currentPath: normalizedPath.substring(0, normalizedPath.indexOf(path) + path.length())])}">${path}</a>
                            <span class="divider">/</span>
                        </li>
                    </g:if>
                    <g:else>
                        <li class="pull-left active">
                            ${path}
                        </li>
                    </g:else>
                </g:each>
            </g:if>
            <li class="pull-right">
                <a id="refresher"
<<<<<<< HEAD
                   href="${request.contextPath}/fileManager?courseId=${course.id}&currentPath=${FilenameUtils.normalizeNoEndSeparator(currentPath)}">
=======
                   href="${request.contextPath}/fileManager?courseId=${course?.id}&currentPath=${FilenameUtils.normalizeNoEndSeparator(currentPath)}">
>>>>>>> 560b91b4a6cf542808796cfb86134fd7d5824ede
                    <i class="icon-refresh"></i>
                </a>
            </li>
        </ul>
    </div>

    <div class="navbar navbar-fixed-top">
        <div class="navbar-inner">
            <div class="row-fluid">
                <button class="btn upload-btn" title="上传"><i
                        class="icon-upload"></i>上传文件</button>
                <button class="btn new-folder-btn" title="新建文件夹">
                    <i class="icon-folder-open"></i>
                    <span style="padding-left: 5px;">新建文件夹</span>
                </button>
            </div>
        </div>
    </div>
    <ul class="thumbnails">
        <g:each in="${files}" var="file">
            <li class="span2">
                <g:if test="${file.isDirectory()}">
                    <div class="thumbnail" style="text-align: center;">
<<<<<<< HEAD
                        <a href="${createLink(controller: 'fileManager', params: [courseId: course.id, target: file.name, currentPath: currentPath])}"
=======
                        <a href="${createLink(controller: 'fileManager', params: [courseId: course?.id, target: file.name, currentPath: currentPath])}"
>>>>>>> 560b91b4a6cf542808796cfb86134fd7d5824ede
                           class="directory-link">
                            <g:img file="folder.jpeg" class="file-item"
                                   alt="目录"></g:img>
                        </a>

                        <div class="box">
                            <p rel="tooltip" title="${file.getName()}"
                               class="file-item-title">${file.getName()}</p>
                        </div>

                        <div class="commandsDiv">
                            <ul class="item-command">
                                <li rel="tooltip" title="重命名">
                                    <a href="#"><i class="icon-pencil"></i>
                                    </a>
                                </li>
                                <li rel="tooltip" title="删除">
                                    <a href="#"><i class="icon-trash"></i>
                                    </a></li>
                            </ul>
                        </div>
                    </div>
                </g:if>
                <g:else>
                    <g:set var="fileType"
                           value="${file.getName().substring(file.getName().lastIndexOf('.') + 1).toLowerCase()}"/>
                    <g:if test="${com.sanwn.mousika.FileManagerController.IMAGES[fileType]}">
                        <div class="thumbnail" style="text-align: center;">
                            <g:set var="imgPath"
<<<<<<< HEAD
                                   value="${org.apache.commons.io.FilenameUtils.normalizeNoEndSeparator('courseFiles/' + course.courseToken + '/repo/' + currentPath)}"/>
=======
                                   value="${org.apache.commons.io.FilenameUtils.normalizeNoEndSeparator(
                                           course ?
                                               'courseFiles/' + course.courseToken + '/repo/' + currentPath :
                                               'notifications/' + currentPath)}"/>
>>>>>>> 560b91b4a6cf542808796cfb86134fd7d5824ede
                            <g:img dir="${imgPath}"
                                   class="file-item"
                                   file="${file.name}"></g:img>

                            <div class="box">
                                <p rel="tooltip" title="${file.getName()}"
                                   class="file-item-title">
                                    ${file.getName()}
                                </p>
                            </div>

                            <div class="commandsDiv">
                                <ul class="item-command">
                                    <li rel="tooltip" title="查看大图">
                                        <a rel="tooltip"
                                           title="点击查看大图"
                                           href="${resource(dir: imgPath, file: file.name)}"
                                           data-dojo-type="dojox.image.Lightbox"><i
                                                class="icon-zoom-in"></i></a>
                                    </li>
                                    <li rel="tooltip" title="重命名">
                                        <a href="#">
                                            <i class="icon-pencil"></i>
                                        </a>
                                    </li>
                                    <li rel="tooltip" title="删除">
                                        <a href="#">
                                            <i class="icon-trash"></i>
                                        </a>
                                    </li>
                                    <li rel="tooltip" title="下载">
                                        <a href="${createLink(controller: 'fileManager', action: 'download',
<<<<<<< HEAD
                                                params: [courseId: course.id, filename: file.name, currentPath: currentPath])}">
=======
                                                params: [courseId: course?.id, filename: file.name, currentPath: currentPath])}">
>>>>>>> 560b91b4a6cf542808796cfb86134fd7d5824ede
                                            <i class="icon-download"></i>
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </g:if>
                    <g:else>
                        <div class="thumbnail">
                            <g:img dir="images/ico"
                                   file="${fileType}.png"
                                   alt="${fileType}文件"
                                   class="file-item"></g:img>
                            <div class="box">
                                <p rel="tooltip" title="${file.getName()}"
                                   class="file-item-title">${file.getName()}</p>
                            </div>

                            <div class="commandsDiv">
                                <ul class="item-command">
                                    <li rel="tooltip" title="重命名">
                                        <a href="#">
                                            <i class="icon-pencil"></i>
                                        </a>
                                    </li>
                                    <li rel="tooltip" title="删除">
                                        <a href="#">
                                            <i class="icon-trash"></i>
                                        </a>
                                    </li>
                                    <li rel="tooltip" title="下载">
                                        <a href="${createLink(controller: 'fileManager', action: 'download',
<<<<<<< HEAD
                                                params: [courseId: course.id, filename: file.name, currentPath: currentPath])}">
=======
                                                params: [courseId: course?.id, filename: file.name, currentPath: currentPath])}">
>>>>>>> 560b91b4a6cf542808796cfb86134fd7d5824ede
                                            <i class="icon-download"></i>
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </g:else>
                </g:else>
            </li>
        </g:each>
    </ul>
</div>

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
                window.location.href = $('#refresher').attr('href') + '&' + new Date().getTime();
            }, 1000);
        });
        $('.new-folder-btn').click(function () {
            var folder = window.prompt("新建文件夹", "新文件夹");
            if (folder) {
                $.ajax({
                    type: 'post',
                    url: "${createLink(controller: 'fileManager', action: 'newFolder')}",
<<<<<<< HEAD
                    data: {folder: folder, courseId: ${course.id}, currentPath: "${currentPath}"}
=======
                    data: {folder: folder, courseId: ${course ? course.id : -1}, currentPath: "${currentPath}"}
>>>>>>> 560b91b4a6cf542808796cfb86134fd7d5824ede
                }).done(function (response) {
                            if (!response.success) {
                                alert(response.error);
                                return;
                            }
<<<<<<< HEAD
                            window.location.href = "${request.contextPath}/fileManager?courseId=${course.id}&currentPath=" + response.currentPath;
=======
                            window.location.href = "${request.contextPath}/fileManager?courseId=${course?.id}&currentPath=" + response.currentPath;
>>>>>>> 560b91b4a6cf542808796cfb86134fd7d5824ede
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
                    url: "${createLink(controller: 'fileManager', action: 'rename')}",
<<<<<<< HEAD
                    data: {title: title, newTitle: newTitle, courseId: ${course.id}, currentPath: "${currentPath}"}
                }).done(function (response) {
                            if (response.success) {
                                window.location.href = "${request.contextPath}/fileManager?courseId=${course.id}&currentPath=" + response.currentPath;
=======
                    data: {title: title, newTitle: newTitle, courseId: ${course ? course.id : -1}, currentPath: "${currentPath}"}
                }).done(function (response) {
                            if (response.success) {
                                window.location.href = "${request.contextPath}/fileManager?courseId=${course?.id}&currentPath=" + response.currentPath;
>>>>>>> 560b91b4a6cf542808796cfb86134fd7d5824ede
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
                    url: "${createLink(controller: 'fileManager', action: 'remove')}",
<<<<<<< HEAD
                    data: {filename: title, courseId:${course.id}, currentPath: "${currentPath}"}
                }).done(function (response) {
                            if (response.success) {
                                window.location.href = "${request.contextPath}/fileManager?courseId=${course.id}&currentPath=" + response.currentPath;
=======
                    data: {filename: title, courseId:${course ? course.id : -1}, currentPath: "${currentPath}"}
                }).done(function (response) {
                            if (response.success) {
                                window.location.href = "${request.contextPath}/fileManager?courseId=${course?.id}&currentPath=" + response.currentPath;
>>>>>>> 560b91b4a6cf542808796cfb86134fd7d5824ede
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
<<<<<<< HEAD
            var href = "${request.contextPath}/fileManager/download?courseId=${course.id}&currentPath=${FilenameUtils.normalizeNoEndSeparator(currentPath)}";
=======
            var href = "${request.contextPath}/fileManager/download?courseId=${course?.id}&currentPath=${FilenameUtils.normalizeNoEndSeparator(currentPath)}";
>>>>>>> 560b91b4a6cf542808796cfb86134fd7d5824ede
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
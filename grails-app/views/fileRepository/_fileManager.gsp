<%@ page import="org.apache.commons.io.FilenameUtils" %>
<div id="personal-fileRepository" class="content scaffold-list"
     role="main">
    <h4 style="border-bottom: 1px solid black;">
        我的文件
    </h4>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <div class="uploader" style="height: 80%;">
        <button class="btn btn-inverse close-uploader">
            <i class="icon-backward icon-white"></i>返回
        </button>

        <div class="space10"></div>

        <div class="space10"></div>
        <g:uploadForm controller="fileRepository" action="upload"
                      id="uploadForm" class="dropzone" style="height: 80%;">
            <input type="hidden" name="username" value="${user?.username}"/>
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
                    <a href="${createLink(controller: 'fileRepository', action: 'show', id: user.username)}">
                        <i class="icon-home"></i>
                    </a>
                    <span class="divider">/</span>
                </li>
                <input id="editor_track" type="hidden"
                       value="${editor}"/>
                <g:set var="normalizedPath"
                       value="${org.apache.commons.io.FilenameUtils.normalizeNoEndSeparator(currentPath)}"/>
                <input class="norm-path" type="hidden"
                       name="normalizedPath"
                       value="${normalizedPath}"/>
                <g:if test="${!normalizedPath.isEmpty() && normalizedPath != '/'}">
                    <g:set var="splittedPaths"
                           value="${normalizedPath.split('/')}"/>
                    <g:each in="${splittedPaths}" status="i"
                            var="path">
                        <g:if test="${i < splittedPaths.size() - 1}">
                            <li class="pull-left">
                                <a href="${createLink(controller: 'fileRepository', action: 'show', id: user?.username,
                                        params: [currentPath:
                                                normalizedPath.substring(0,
                                                        normalizedPath.indexOf(path) + path.length())])}">${path}</a>
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
                       href="${createLink(controller: 'fileRepository', action: 'show', id: user?.username,
                               params: [currentPath: FilenameUtils.normalizeNoEndSeparator(currentPath)])}">
                        <i class="icon-refresh"></i>
                    </a>
                </li>
            </ul>
        </div>

        <div class="navbar">
            <div class="navbar-inner">
                <div class="row-fluid">
                    <button class="btn upload-btn" title="上传">
                        <i class="icon-upload"></i>上传文件</button>
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
                            <a href="${createLink(controller: 'fileRepository', action: 'show', id: user?.username, params: [target: file.name, currentPath: currentPath])}"
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
                                       value="${org.apache.commons.io.FilenameUtils.normalizeNoEndSeparator(
                                               'userFiles/' + user.username + '/' + currentPath)}"/>
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
                                    <ul class="image-command">
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
                                            <a href="${createLink(controller: 'fileRepository', action: 'download',
                                                    params: [username: user?.username, filename: file.name, currentPath: currentPath])}">
                                                <i class="icon-download"></i>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </g:if>
                        <g:else>
                            <div class="thumbnail">
                                <mousika:img dir="images/ico" file="${fileType}.png" altImg="Default.png"
                                             class="file-item"></mousika:img>
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
                                            <a href="${createLink(controller: 'fileRepository', action: 'download',
                                                    params: [username: user?.username, filename: file.name, currentPath: currentPath])}">
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
</div>
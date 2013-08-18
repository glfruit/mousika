<html>
<head>
    <shiro:hasRole name="学生">
        <meta name="layout" content="student">
    </shiro:hasRole>
    <shiro:hasAnyRole in="['教师', '系统管理员','课程负责人']">
        <meta name="layout" content="course">
    </shiro:hasAnyRole>
    <title>${courseInstance?.title}</title>
    <style>
    .commands {
        white-space: nowrap;
        display: inline;
    }

    li {
        cursor: text;
    }
    </style>
    <link rel="stylesheet"
          href="${resource(dir: 'css', file: 'jplayer/jplayer.blue.monday.css')}"
          type="text/css"/>
</head>

<body>
<div id="edit-deliver-info-div" class="modal hide fade">
    <div class="modal-header">
        <h4>编辑授课信息</h4>
    </div>

    <div class="modal-body">
        <g:form class='form-horizontal'>
            <div class='control-group'>
                <label class='control-label' for='deliverPlace'>
                    授课地点：
                </label>

                <div class='controls'>
                    <input name='deliverPlace' id='deliverPlace' type='text'/>
                </div>
            </div>

            <div class='control-group'>
                <label class='control-label' for='deliverTime'>
                    授课时间：
                </label>

                <div class='controls'>
                    <g:textArea name="deliverTime" id="deliverTime" cols="10"
                                rows="10"/>
                </div>
            </div>
        </g:form>
    </div>

    <div class="modal-footer">
        <p class="pull-right">
            <a id="updateBtn" class="btn btn-primary" href="#">更新</a>
            <button class="btn" data-dismiss="modal"
                    aria-hidden="true">取消</button>
        </p>
    </div>
</div>
<h4 style="border-bottom: 1px solid #DEDEDE;color: #777777;padding-bottom: 5px;padding-top: 20px;">
    ${courseInstance?.title}
</h4>
<g:if test="${flash.message}">
    <div class="text-success" role="status">${flash.message}</div>
</g:if>

<div class="modal hide fade" id="jPlayerVideoDlg"
     tabindex="-1" role="dialog"
     aria-labelledby="jPlayerVideoLabel" aria-hidden="true">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"
                aria-hidden="true">×</button>
    </div>

    <div class="modal-body">
        <div id="jp_video_container" class="jp-video ">
            <div class="jp-type-single">
                <div id="jquery_video_jplayer" class="jp-jplayer"></div>

                <div class="jp-gui">
                    <div class="jp-video-play">
                        <a href="javascript:;" class="jp-video-play-icon"
                           tabindex="1">play</a>
                    </div>

                    <div class="jp-interface">
                        <div class="jp-progress">
                            <div class="jp-seek-bar">
                                <div class="jp-play-bar"></div>
                            </div>
                        </div>

                        <div class="jp-current-time"></div>

                        <div class="jp-duration"></div>

                        <div class="jp-controls-holder">
                            <ul class="jp-controls">
                                <li><a href="javascript:;" class="jp-play"
                                       tabindex="1">play</a></li>
                                <li><a href="javascript:;" class="jp-pause"
                                       tabindex="1">pause</a></li>
                                <li><a href="javascript:;" class="jp-stop"
                                       tabindex="1">stop</a></li>
                                <li><a href="javascript:;" class="jp-mute"
                                       tabindex="1" title="mute">mute</a></li>
                                <li><a href="javascript:;" class="jp-unmute"
                                       tabindex="1" title="unmute">unmute</a>
                                </li>
                                <li><a href="javascript:;" class="jp-volume-max"
                                       tabindex="1"
                                       title="max volume">max volume</a></li>
                            </ul>

                            <div class="jp-volume-bar">
                                <div class="jp-volume-bar-value"></div>
                            </div>
                            <ul class="jp-toggles">
                                <li><a href="javascript:;"
                                       class="jp-full-screen" tabindex="1"
                                       title="full screen">full screen</a></li>
                                <li><a href="javascript:;"
                                       class="jp-restore-screen" tabindex="1"
                                       title="restore screen">restore screen</a>
                                </li>
                                <li><a href="javascript:;" class="jp-repeat"
                                       tabindex="1" title="repeat">repeat</a>
                                </li>
                                <li><a href="javascript:;" class="jp-repeat-off"
                                       tabindex="1"
                                       title="repeat off">repeat off</a></li>
                            </ul>
                        </div>

                        <div class="jp-title">
                            <ul>
                                <li>Big Buck Bunny Trailer</li>
                            </ul>
                        </div>
                    </div>
                </div>

                <div class="jp-no-solution">
                    <span>Update Required</span>
                    To play the media you will need to either update your browser to a recent version or update your <a
                        href="http://get.adobe.com/flashplayer/"
                        target="_blank">Flash plugin</a>.
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal hide fade" id="jPlayerAudioDlg"
     tabindex="-1" role="dialog"
     aria-labelledby="jPlayerLabel" aria-hidden="true">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"
                aria-hidden="true">×</button>
    </div>

    <div class="modal-body">
        <div id="jquery_jplayer_1" class="jp-jplayer"></div>

        <div id="jp_container_1" class="jp-audio">
            <div class="jp-type-single">
                <div class="jp-gui jp-interface">
                    <ul class="jp-controls">
                        <li><a href="javascript:;" class="jp-play"
                               tabindex="1">play</a>
                        </li>
                        <li><a href="javascript:;" class="jp-pause"
                               tabindex="1">pause</a></li>
                        <li><a href="javascript:;" class="jp-stop"
                               tabindex="1">stop</a>
                        </li>
                        <li><a href="javascript:;" class="jp-mute" tabindex="1"
                               title="mute">mute</a></li>
                        <li><a href="javascript:;" class="jp-unmute"
                               tabindex="1"
                               title="unmute">unmute</a></li>
                        <li><a href="javascript:;" class="jp-volume-max"
                               tabindex="1"
                               title="max volume">max volume</a></li>
                    </ul>

                    <div class="jp-progress">
                        <div class="jp-seek-bar">
                            <div class="jp-play-bar"></div>
                        </div>
                    </div>

                    <div class="jp-volume-bar">
                        <div class="jp-volume-bar-value"></div>
                    </div>

                    <div class="jp-time-holder">
                        <div class="jp-current-time"></div>

                        <div class="jp-duration"></div>
                        <ul class="jp-toggles">
                            <li><a href="javascript:;" class="jp-repeat"
                                   tabindex="1"
                                   title="repeat">repeat</a></li>
                            <li><a href="javascript:;" class="jp-repeat-off"
                                   tabindex="1"
                                   title="repeat off">repeat off</a>
                            </li>
                        </ul>
                    </div>
                </div>

                <div class="jp-title">
                    <ul>
                        <li>Bubble</li>
                    </ul>
                </div>

                <div class="jp-no-solution">
                    <span>Update Required</span>
                    To play the media you will need to either update your browser to a recent version or update your <a
                        href="http://get.adobe.com/flashplayer/"
                        target="_blank">Flash plugin</a>.
                </div>
            </div>
        </div>
    </div>

    <div id="modal-footer"></div>
</div>

<div class="modal hide fade" id="addActivityOrResourceModal"
     tabindex="-1" role="dialog"
     aria-labelledby="activityOrResourceLabel" aria-hidden="true">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"
                aria-hidden="true">×</button>

        <h4 id="myModalLabel">添加活动或资源</h4>
    </div>

    <g:form class="form-horizontal" controller="course" action="addResource">
        <div class="modal-body">
            <input type="hidden" id="sectionSeq" name="sectionSeq"/>
            <input type="hidden" id="courseId" name="courseId"
                   value="${courseInstance.id}"/>
            <label class="radio">
                <input type="radio" name="itemContentType"
                       value="assignment" checked>作业<i
                    class="icon-question-sign"></i>
            </label>
            <label class="radio">
                <input type="radio" name="itemContentType"
                       value="fileResource">文件<i class="icon-question-sign"></i>
            </label>
            <label class="radio">
                <input type="radio" name="itemContentType"
                       value="page">页面<i class="icon-question-sign"></i>
            </label>
            <label class="radio">
                <input type="radio" name="itemContentType"
                       value="label">标签<i class="icon-question-sign"></i>
            </label>
            <label class="radio">
                <input type="radio" name="itemContentType"
                       value="urlResource">URL<i class="icon-question-sign"></i>
            </label>
        </div>

        <div class="modal-footer">
            <g:submitButton name="addResourceBtn"
                            class="btn btn-primary" value="添加"/>
            <button id="add-done" class="btn" data-dismiss="modal"
                    aria-hidden="true">关闭</button>
        </div>
    </g:form>
</div>

<div style="border: 1px solid #DEDEDE;width: 100%;">
    <div class="row-fluid">
        <div class="span5" style="padding-left: 35px;">
            <h5><i class="icon-volume-up"></i>
                <span style="padding-left: 5px;">授课信息</span>
                <span class="edit-course-region"
                      style="padding-left: 5px;">
                    <a href="#edit-deliver-info-div" rel="tooltip" title="编辑"
                       data-toggle="modal"
                       class="edit-deliver-info">
                        <i class="icon-pencil"></i>
                    </a>
                </span>
            </h5>

            <div class="deliver-info">
                <p>上课地点：${courseInstance?.deliverPlace}</p>

                <p>上课时间：<%=courseInstance?.deliverTime%></p>
            </div>
        </div>

        <div class="span7 notification" style="padding-left: 5px;">
            <h5><i class="icon-list"></i>
                <span style="padding-left: 5px;">课程通知</span>
                <span class="edit-course-region"
                      style="padding-left: 5px;">
                    <a href="${createLink(controller: 'notification', action: 'create', params: [courseId: courseInstance.id])}">
                        <i class="icon-plus-sign" rel="tooltip"
                           title="发布通知"></i>
                    </a>
                </span>
            </h5>
            <ul class="notification">
                <g:each in="${notifications}" var="notification">
                    <li>
                        <a href="${createLink(controller: 'notification', action: 'show', id: notification.id, params: [courseId: courseInstance.id])}">
                            ${notification.title}
                        </a>
                    </li>
                </g:each>
            </ul>
            <g:if test="${notifications?.size() >= 5}">
                <p class="pull-right"
                   style="padding-right: 30px; position: relative; bottom: 0;right: 0;">
                    <a href="${createLink(controller: 'notification', action: 'list', params: [courseId: courseInstance?.id])}">更多...</a>
                </p>
            </g:if>
        </div>
    </div>
</div>

<div data-dojo-type="dojo.dnd.Source"
     data-dojo-props="accept: ['section'], withHandles: true, autoSync: true"
     class="dojoDndSource">
    <g:each in="${courseInstance.units}" var="unit">
        <g:render template="section"
                  model="['startDate': courseInstance.startDate, 'course': courseInstance,
                          'section': unit, 'order': unit.sequence]"/>
    </g:each>
</div>
<script>
    require(['dojo/query', 'dojo/topic', 'dojo/request', 'dojo/dom-attr', 'dojo/on', 'dojo/dnd/Source', 'dojo/io-query', 'jquery', 'dojo/_base/event',
        'dojo/dom-style', 'dojo/dom-class', 'dojo/json', 'dojo/dom',
        'jplayer', 'bootstrap/Modal', 'dojo/domReady!'],
            function (query, topic, request, domAttr, on, Source, ioQuery, $, event, domStyle, domClass, json, dom) {
                query("i.icon-eye-open,i.icon-eye-close").on('click', function (e) {
                    event.stop(e);
                    var classes = query(e.target).attr('class')[0].split(' ');
                    for (var i = 0; i < classes.length; i++) {
                        var c = classes[i];
                        var matched = c.match(/^courseSection(\d+)($|item(\d+)$)/);
                        if (matched) {
                            var opacity = domStyle.get(c, 'opacity');
                            opacity = parseFloat(opacity) < 1 ? 1 : 0.5;
                            request.post("${request.contextPath}/course/toggleUnitOrItem", {
                                data: {
                                    courseId: ${courseInstance.id},
                                    unitSeq: matched[1],
                                    itemSeq: matched[3] ? matched[3] : -1,
                                    visible: opacity == 1
                                }}).then(function (response) {
                                        var result = json.parse(response);
                                        if (result.success) {
                                            if (parseFloat(opacity) < 1) {
                                                domStyle.set(c, 'opacity', opacity);
                                                query(e.target).replaceClass('icon-eye-close', 'icon-eye-open');
                                            } else {
                                                domStyle.set(c, 'opacity', opacity);
                                                query(e.target).replaceClass('icon-eye-open', 'icon-eye-close');
                                            }
                                        } else {
                                            console.error(result.error);
                                        }
                                    });
                            break;
                        }
                    }
                });
                define.amd.jQuery = true;
                query(".addContent").on('click', function (e) {
                    var csid = query(e.target).parent().attr('id');
                    csid = /csl(\d+)/.exec(csid)[1];
                    query('#sectionSeq').attr('value', csid);
                });

                var courseId = "${courseInstance.id}";
                var requestData = {
                    courseId: courseId,
                    targetUnitItemSeq: 0
                };
                query(".fileType").forEach(function (node) {
                    var params = node.search.substring(1);
                    var supportedAudioFormats = "mp3,m4a,wav";
                    var supportedVideoFormats = "flv,m4v";
                    var fileType = ioQuery.queryToObject(params)['type'];
                    var supported = supportedAudioFormats.indexOf(fileType) != -1 ||
                            supportedVideoFormats.indexOf(fileType) != -1;
                    if (supported) {
                        on(node, 'click', function (e) {
                            event.stop(e);
                            if (supportedAudioFormats.indexOf(fileType) != -1) {
                                $("#jquery_jplayer_1").jPlayer({
                                    ready: function () {
                                        $(this).jPlayer("setMedia", {
                                            mp3: node.pathname
                                        });
                                    },
                                    swfPath: "${request.contextPath}/js/jplayer",
                                    supplied: supportedAudioFormats
                                });
                                query('#jPlayerAudioDlg').modal();
                            } else {
                                $("#jquery_video_jplayer").jPlayer({
                                    cssSelectorAncestor: "#jp_video_container",
                                    ready: function () {
                                        $(this).jPlayer("setMedia", {
                                            flv: node.pathname
                                        });
                                    },
                                    swfPath: "${request.contextPath}/js/jplayer",
                                    supplied: supportedVideoFormats
                                });
                                query('#jPlayerVideoDlg').modal();
                            }
                        })
                    }
                });
                topic.subscribe("/dnd/drop/before", function (source, nodes) {
                    var sourceUnitSeq = source.id.match(/.*(\d+)$/)[1];
                    var sourceUnitItemSeq = nodes[0].id.match(/.*(\d+)$/)[1];
                    requestData.sourceUnitSeq = sourceUnitSeq;
                    requestData.sourceUnitItemSeq = sourceUnitItemSeq;
                    requestData.before = true;
                    var q = query(".dojoDndItemBefore");
                    var targetUnitSeq;
                    if (q.length > 0) {
                        targetUnitSeq = q[0].id.match(/.*(\d+)$/)[1];
                        requestData.targetUnitItemSeq = targetUnitSeq;
                    } else {
                        q = query(".dojoDndItemAfter");
                        if (q.length > 0) {
                            targetUnitSeq = q[0].id.match(/.*(\d+)$/)[1];
                            requestData.targetUnitItemSeq = targetUnitSeq;
                            requestData.before = false;
                        } else {
                            console.error("oops! Something is wrong or empty target!");
                            return;
                        }
                    }
                });
                topic.subscribe("/dnd/drop", function (source, nodes, copy, target) {
                    var type = domAttr.get(nodes[0], 'dndType');
                    if (type == 'unit') {
                        return;
                    }
                    var updateUrl = "${request.contextPath}/courseUnit/updateUnit";
                    var targetUnitSeq = target.id.match(/.*(\d+)$/)[1];
                    requestData.targetUnitSeq = targetUnitSeq;
                    var responseHandler = function (response) {
                        require(['dojo/json'], function (json) {
                            var responseJson = json.parse(response);
                            if (!responseJson.success) {
                                alert("更新失败:" + responseJson.error);
//                                dojo.dnd.manager().stopDrag(); //TODO: 如何正确取消拖拽？
                                return;
                            }
                            if (source == target) {
                                source.getAllNodes().forEach(function (node) {
                                    var m = node.id.match(/(.*)(\d+)$/);
                                    var seq = parseInt(m[2]);
                                    if (requestData.sourceUnitItemSeq < requestData.targetUnitItemSeq) {
                                        if (seq > requestData.sourceUnitItemSeq && seq <= requestData.targetUnitItemSeq) {
                                            query(node).attr('id', m[1] + (seq - 1));
                                        }
                                    } else if (requestData.sourceUnitItemSeq > requestData.targetUnitItemSeq) {
                                        if (seq >= requestData.targetUnitItemSeq && seq < requestData.sourceUnitItemSeq) {
                                            query(node).attr('id', m[1] + (seq + 1));
                                        }
                                    }
                                    if (seq == requestData.sourceUnitItemSeq) {
                                        query(node).attr('id', m[1] + requestData.targetUnitItemSeq);
                                    }
                                });
                            } else {
                                target.getAllNodes().forEach(function (node) {
                                    var m = node.id.match(/(.*)(\d+)$/);
                                    var seq = parseInt(m[2]);
                                    if (seq >= requestData.targetUnitItemSeq) {
                                        query(node).attr('id', m[1] + (seq + 1));
                                    }
                                });
                                var newId = "courseSection" + targetUnitSeq + "item" + requestData.targetUnitItemSeq;
                                query(nodes[0]).attr('id', newId);
                                source.getAllNodes().forEach(function (node) {
                                    var m = node.id.match(/(.*)(\d+)$/);
                                    var seq = parseInt(m[2]);
                                    if (seq > requestData.sourceUnitItemSeq) {
                                        query(node).attr('id', m[1] + (seq - 1));
                                    }
                                });
                            }
                        });
                    };
                    if (target.getAllNodes().length == 0) {
                        console.log("no node found in target unit");
                        require(['dojo/request'], function (request) {
                            request.post(updateUrl, {
                                data: requestData
                            }).then(responseHandler);
                        });
                    } else {
                        console.log("ready to process moving unit item:" + target.selection.length);
                        if (target.current == null) { // 未拖拽到任何一个节点上，当最后一个节点处理
                            console.log("add node to last");
                            require(['dojo/request'], function (request) {
                                requestData.targetUnitItemSeq = target.getAllNodes().length;
                                request.post(updateUrl, {
                                    data: requestData
                                }).then(responseHandler);
                            });
                        } else {
                            console.log("add node to specified pos");
                            require(['dojo/request'], function (request) {
                                requestData.targetUnitItemSeq = target.current.id.match(/.*(\d+)$/)[1];
                                request.post(updateUrl, {
                                    data: requestData
                                }).then(responseHandler);
                            });
                        }
                    }
                });
                query('#updateBtn').on('click', function (e) {
                    event.stop(e);
                    var deliverPlace = dom.byId('deliverPlace').value;
                    var deliverTime = dom.byId('deliverTime').value;
                    request.post("${createLink(controller: 'course', action: 'updateDeliverInfo')}",
                            {data: {
                                courseId: ${courseInstance.id},
                                deliverPlace: deliverPlace,
                                deliverTime: deliverTime
                            }}).then(function (response) {
                                var r = json.parse(response);
                                if (r.success) {
                                    query('.deliver-info').innerHTML("<p>授课地点：" + deliverPlace + "</p>" +
                                            "<p>授课时间：" + deliverTime + "</p>");
                                    query('#edit-deliver-info-div').hide();
                                } else {
                                    alert("更新失败！");
                                }
                            });
                });
            });
</script>
</body>
</html>

<html>
<head>
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
<h4 style="border-bottom: 1px solid #000;color: #777777;">
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

    <g:form class="form-horizontal" action="addResource">
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

<div data-dojo-type="dojo.dnd.Source"
     data-dojo-props="accept: ['section'], withHandles: true, autoSync: true"
     class="dojoDndSource">
    <g:each in="${courseInstance.units}" var="unit">
        <g:render template="section"
                  model="['startDate': courseInstance.startDate,
                          'section': unit, 'order': unit.sequence]"/>
    </g:each>
</div>
<script>
    require(['dojo/query', 'dojo/topic', 'dojo/request', 'dojo/dom-attr', 'dojo/on', 'dojo/dnd/Source', 'dojo/io-query', 'jquery', 'dojo/_base/event', 'jplayer', 'bootstrap/Modal', 'dojo/domReady!'],
            function (query, topic, request, domAttr, on, Source, ioQuery, $, event) {
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
            });
</script>
</body>
</html>

<html>
<head>
    <meta name="layout" content="student"/>
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
</head>

<body>
    <h4 style="border-bottom: 1px solid #000;color: #777777;">
        ${courseInstance?.title}
    </h4>
    <g:if test="${flash.message}">
        <div class="text-success" role="status">${flash.message}</div>
    </g:if>

    <div class="modal hide fade" id="addActivityOrResourceModal"
         tabindex="-1" role="dialog"
         aria-labelledby="activityOrResourceLabel" aria-hidden="true">
        <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal"
                    aria-hidden="true">×</button>

            <h4 id="myModalLabel">添加活动或资源</h4>
        </div>

    <div class="modal-body">
        <g:form class="form-horizontal" action="addResource">
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
                       value="quiz">测验<i class="icon-question-sign"></i>
            </label>
            <label class="radio">
                <input type="radio" name="itemContentType"
                       value="vocabulary">词汇表<i
                    class="icon-question-sign"></i>
            </label>
            <label class="radio">
                <input type="radio" name="itemContentType"
                       value="file">文件<i class="icon-question-sign"></i>
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
                       value="url">URL<i class="icon-question-sign"></i>
            </label>
            <!--
                <form method="post" action="UploadFile.php" id="myForm"
                      enctype="multipart/form-data">
                    <input name="uploadedfile" multiple="true" type="file"
                           data-dojo-type="dojox.form.Uploader"
                           label="Select Some Files" id="uploader"/>
                    <input type="submit" label="Submit"
                           data-dojo-type="dijit.form.Button"/>
                </form>
                -->
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
                  model="['startDate': courseInstance.startDate, 'course': courseInstance,
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

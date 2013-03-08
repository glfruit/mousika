<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main"/>
        %{--<r:require modules="bootstrap"/>--}%
        <style type="text/css" media="screen">
        body {
            padding-top: 60px;
            padding-bottom: 40px;
        }

        .sidebar-nav {
            padding: 9px 0;
        }

        .bs-docs-social {
            padding: 15px 0;
            text-align: center;
            background-color: #f5f5f5;
            border-top: 1px solid #fff;
            border-bottom: 1px solid #ddd;
        }

        .dijitCalendarDateTemplate {
            margin: 25px auto;
            width: 600px;
        }
        </style>
        <dojo:require modules="['dijit.dijit', 'dijit.Calendar']"/>
    </head>

    <body>

        <!-- Example row of columns -->
        <div class="row">
            <div class="span3">
                <h4 style="border-bottom: 1px solid #000;color: #777777;">新闻通知</h4>
            </div>

            <div class="span6">
                <h4 style="border-bottom: 1px solid #000;color: #777777;"><g:message
                        code="label.course.list"/></h4>

                <p>暂时没有任何课程</p>
            </div>

            <div class="span3">
                <div class="pull-right" data-dojo-type="dijit.Calendar"
                     data-dojo-props="onChange:function(){dojo.byId('formatted').innerHTML=dojo.date.locale.format(arguments[0], {formatLength: 'full', selector:'date'})}"></div>

                <p id="formatted"></p>
            </div>
        </div>



    </div> <!-- /container -->
    </body>
</html>

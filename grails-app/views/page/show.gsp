<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="dojo">
        <title>${pageInstance?.title}</title>
    </head>

    <body>
        <div id="show-page" class="content scaffold-show" role="main">
            <h4>${pageInstance?.title}</h4>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>
            ${pageInstance?.content}
        </div>
    </body>
</html>

var profile = (function () {
    var testResourceRe = /^mousika\/tests\//,
        copyOnly = function (filename, mid) {
            var list = {
                "mousika/mousika.profile.js": true,
                "mousika/package.json": true
            };
            return (mid in list) || (/^mousika\/resources\//.test(mid)
                && ~/\.css$/.test(filename)) || /(png|jpg|jpeg|gif|tiff)$/.test(filename);
        };
    return {
        basePath: '../dojo-release-1.9.1',
        action: 'release',
        cssOptimize: 'comments',
        mini: true,
        optimize: 'closure',
        layerOptimize: 'closure',
        stripConsole: 'all',
        selectorEngine: 'acme',
        resourceTags: {
            test: function (filename, mid) {
                return testResourceRe.test(mid) || mid == "mousika/tests";
            },
            copyOnly: function (filename, mid) {
                return copyOnly(filename, mid);
            },
            amd: function (filename, mid) {
                return !testResourceRe.test(mid) && !copyOnly(filename, mid) && /\.js$/.test(filename);
            }
        }
    };
})();
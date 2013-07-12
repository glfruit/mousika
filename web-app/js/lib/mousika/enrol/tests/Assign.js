define(["doh/runner"], function (doh) {
    doh.register("MyTests", [
        function assertTrueTest() {
            doh.assertTrue(true);
        }
    ]);
});
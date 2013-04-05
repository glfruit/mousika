if (typeof jQuery !== 'undefined') {
    (function ($) {
        $('#spinner').ajaxStart(function () {
            $(this).fadeIn();
        }).ajaxStop(function () {
                $(this).fadeOut();
            });
    })(jQuery);
}

//var App = Ember.Application.create({
//    LOG_TRANSITIONS: true
//});
//App.Router.map(function () {
//    this.route("enrolUser", {paths: '/course/enrol/:course_id'});
//});
//App.CourseEnrolController = Ember.Controller.extend();

package com.sanwn.mousika

class PostStatisticsException extends RuntimeException {

    String message

    PostStatistics postStatistics
}

class PostStatisticsService {

    def addNewStatistics(Date dateViewed, Long postId) {
        def post = Post.get(postId)
        def statistics = post.statistics
        statistics.dateViewed = dateViewed
        statistics.total = statistics.total + 1
        if (!statistics.validate() || !post.save()) {
            throw new PostStatisticsException(message: "创建记录失败", postStatistics: statistics)
        }
        return statistics
    }

}

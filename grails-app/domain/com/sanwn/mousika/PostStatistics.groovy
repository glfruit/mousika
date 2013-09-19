package com.sanwn.mousika

/**
 *
 * @author glix
 * @version 1.0
 *
 */
class PostStatistics {

    int total

    Date dateViewed

    static belongsTo = [post: Post]
}

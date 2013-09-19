package com.sanwn.mousika

class PageViewFilterFilters {

    def postStatisticsService

    def filters = {
        postViewed(controller: 'post', action: 'show') {
            before = {

            }
            after = { Map model ->

            }
            afterView = { Exception e ->
                if (!e) {
                    PostStatistics.lock(params.id)
                    try {
                        postStatisticsService.addNewStatistics(new Date(),params.long('id'))
                    } catch (Exception ex) {
                        log.error("添加统计数据失败：$ex")
                    }
                }
            }
        }
    }
}

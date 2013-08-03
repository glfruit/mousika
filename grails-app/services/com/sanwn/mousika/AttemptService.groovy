package com.sanwn.mousika

/**
 *
 * @author glix
 * @version 1.0
 *
 */
class AttemptService {

    static transactional = true

    def evaluate(Long attemptId, double score, String suggestion) {
        def attempt = Attempt.get(attemptId)
        if (attempt == null) {
            throw new AttemptException(message: "指定的作业回答未找到：${attemptId}")
        }
        attempt.score = score
        def feedback = attempt.feedback
        if (!feedback) {
            feedback = new Feedback(suggestion: suggestion)
        }
        feedback.suggestion = suggestion
        attempt.addFeedback(feedback)
        if (feedback.validate() && attempt.save(flush: true)) {
            return attempt
        }
        throw new AttemptException(message: "更新作业成绩失败", attempt: attempt)
    }
}

class AttemptException extends RuntimeException {

    String message

    Attempt attempt
}

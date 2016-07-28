class User < ActiveRecord::Base

  validates :name, presence: true, uniqueness: true

  has_many :authored_polls,
  class_name: :Poll,
  primary_key: :id,
  foreign_key: :author_id

  has_many :responses,
  class_name: :Response,
  primary_key: :id,
  foreign_key: :user_id

  def completed_polls
    sub_query = AnswerChoice.select("answer_choices.question_id AS question_id, COUNT(responses.id) AS response_count")
    .joins("LEFT JOIN responses ON responses.answer_choice_id = answer_choices.id")
    .where("responses.user_id = ?", id)
    .group("answer_choices.question_id")
    Poll
    .select("polls.*")
    .joins("JOIN questions ON questions.poll_id = polls.id")
    .joins("LEFT JOIN (#{sub_query.to_sql}) AS filtered_responses ON filtered_responses.question_id = questions.id")
    .group("polls.id")
    .having("COUNT(questions.id) = COUNT(filtered_responses)").to_a
    # Poll.fin
  end

end

#   SELECT
#     polls.*
#   FROM
#     polls
#     JOIN questions
#     ON questions.poll_id = polls.id
#     LEFT JOIN (
#       SELECT
#         answer_choices.question_id AS question_id, COUNT(responses.id) AS response_count
#       FROM
#         answer_choices
#         LEFT JOIN responses
#         ON responses.answer_choice_id = answer_choices.id
#       WHERE
#         responses.user_id = ?
#       GROUP BY
#         answer_choices.question_id
#     ) AS filtered_responses
#     ON filtered_responses.question_id = questions.id
#   GROUP BY
#     polls.id
#   HAVING
#     COUNT(questions.id) = COUNT(filtered_responses)

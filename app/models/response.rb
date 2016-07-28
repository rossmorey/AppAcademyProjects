class Response < ActiveRecord::Base

  validates :user_id, :answer_choice_id, presence: true
  validate :not_duplicate_response
  validate :not_poll_author

  belongs_to :answer_choice,
  class_name: :AnswerChoice,
  primary_key: :id,
  foreign_key: :answer_choice_id

  belongs_to :respondent,
  class_name: :User,
  primary_key: :id,
  foreign_key: :user_id

  has_one :question,
  through: :answer_choice,
  source: :question

  def sibling_responses
    Response
      .select("r2.*")
      .joins("JOIN answer_choices AS ac_one ON ac_one.id = #{answer_choice_id}")
      .joins("JOIN questions ON ac_one.question_id = questions.id")
      .joins("JOIN answer_choices ac_two ON ac_two.question_id = questions.id")
      .joins("JOIN responses AS r2 ON responses.answer_choice_id = ac_two.id")
      .where("ac_one.id = ?", answer_choice_id)
  end

  def respondent_already_answered?
    sibling_responses.exists?(user_id: user_id)
  end
  #
  # SELECT
  #   responses.*
  # FROM
  #   answer_choices ac_one
  #   JOIN questions
  #     ON ac_one.question_id = questions.id
  #   JOIN answer_choices ac_two
  #     ON ac_two.question_id = questions.id
  #   JOIN responses
  #     ON responses.answer_choice_id = ac_two.id
  # WHERE
  #   ac_one.id = 1#answer_choice_id



  def not_duplicate_response
    if respondent_already_answered?
      self.errors[:duplicate] << "You've already answered this question."
    end
  end

  def not_poll_author
    poll = Poll.joins(:questions).select("polls.author_id").joins("JOIN answer_choices ON answer_choices.question_id = questions.id").where("answer_choices.id = ?", answer_choice_id)
    if poll.first.author_id == user_id
      self.errors[:author] << "You can't answer your own polls!"
    end
    # p poll.first.author_id
  end

end
#
# SELECT
#   poll.author_id
# FROM
#   polls
#   JOIN questions
#   ON questions.poll_id = polls.id
#   JOIN answer_choices
#   ON answer_choices.question_id = questions.id
# WHERE
#   answer_choices.id = 1

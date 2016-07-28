class Question < ActiveRecord::Base

  validates :text, :poll_id, presence: true

  has_many :answer_choices,
  class_name: :AnswerChoice,
  primary_key: :id,
  foreign_key: :question_id

  belongs_to :poll,
  class_name: :Poll,
  primary_key: :id,
  foreign_key: :poll_id

  has_many :responses,
  through: :answer_choices,
  source: :responses

  # def results
  #   response_count = {}
  #
  #   answer_choice.each do |choice|
  #     response_count[choice.text] = choice.responses.count
  #   end
  # end

  # def results
  #   response_count = {}
  #
  #   choices = answer_choice.includes(:responses)
  #
  #   choices.each do |choice|
  #     response_count[choice.text] = choice.responses.length
  #   end
  # end

  def results
    counted_responses = answer_choices
      .select("answer_choices.*, COUNT(*) AS response_count")
      .joins("LEFT OUTER JOIN responses ON answer_choices.id = responses.answer_choice_id ")
      .group("answer_choices.id")

    result = {}

    counted_responses.each do |response|
      result[response.text] = response.response_count
    end

    result
  end
  
end

require_relative 'questionsdb'
require_relative 'question_follow'
load './model_base.rb'

class Question < ModelBase
  attr_accessor :id, :user_id, :title, :body

  def self.all
    db = QuestionsDatabase.instance.execute("SELECT * FROM questions")
    db.map { |datum| Question.new(datum) }
  end

  def self.find_by_author_id(user_id)
    result = QuestionsDatabase.instance.execute(<<-SQL, user_id: user_id)
      SELECT
        *
      FROM
        questions
      WHERE
        user_id = :user_id
    SQL
    result.map { |datum| Question.new(datum) }
  end

  def self.most_followed(n)
    QuestionFollow.most_followed_questions(n)
  end

  def self.question_most_liked(n)
    QuestionLike.most_liked_questions(n)
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @user_id = options['user_id']
  end

  def author
    User.find_by_id(@user_id)
  end

  def replies
    Reply.find_by_question_id(@id)
  end

  def followers
    QuestionFollow.followers_for_question_id(@id)
  end

  def likers
    QuestionLike.likers_for_question_id(@id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(@id)
  end

end

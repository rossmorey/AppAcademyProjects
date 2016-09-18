require_relative 'questionsdb'
require_relative 'question'
require_relative 'reply'
require_relative 'question_follow'
load './model_base.rb'
require 'byebug'

class User < ModelBase
  attr_accessor :id, :fname, :lname

  def self.all
    db = QuestionsDatabase.instance.execute("SELECT * FROM users")
    db.map { |datum| User.new(datum) }
  end

  def self.find_by_name(name)
    fname, lname = name.split(' ')
    result = QuestionsDatabase.instance.execute(<<-SQL, fname: fname, lname: lname)
      SELECT
        *
      FROM
        users
      WHERE
        fname = :fname AND
        lname = :lname
    SQL
    # debugger
    User.new(result.first)

  end

  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def authored_questions
    Question.find_by_author_id(@id)
  end

  def authored_replies
    Reply.find_by_author_id(@id)
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(@id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(@id)
  end

  def average_karma
    result = QuestionsDatabase.instance.execute(<<-SQL, @id)
      SELECT
        AVG(COALESCE(likes.num_likes, 0)) karma
      FROM questions
        LEFT OUTER JOIN (
          SELECT
            question_id, COUNT(*) num_likes
          FROM
            question_likes
          GROUP BY
            question_id
          ) likes
          ON likes.question_id = questions.id
      WHERE questions.user_id = ?
    SQL
    result.first['karma']
  end

end

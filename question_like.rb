require 'byebug'
require_relative 'questionsdb'
require_relative 'user'

class QuestionLike
  attr_accessor :id, :user_id, :question_id

  def self.all
    db = QuestionsDatabase.instance.execute("SELECT * FROM question_likes")
    db.map { |datum| QuestionLike.new(datum) }
  end

  def self.find_by_id(id)
    result = QuestionsDatabase.instance.execute(<<-SQL, id: id)
      SELECT
        *
      FROM
        question_likes
      WHERE
        id = :id
    SQL
    # debugger
    QuestionLike.new(result.first)
  end

  def self.most_liked_questions(n)
    result = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        question_id, COUNT(*)
      FROM
        question_likes
      GROUP BY
        question_id
      ORDER BY
        2 DESC
      LIMIT
        ?
    SQL
    result.map { |datum| Question.find_by_id(datum["question_id"])}
  end

  def self.liked_questions_for_user_id(user_id)
    result = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
      question_id
      FROM
      question_likes
      WHERE
      user_id = ?
    SQL
    result.map { |datum| Question.find_by_id(datum["question_id"]) }
  end

  def self.num_likes_for_question_id(question_id)
    result = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
      COUNT(*) num_likes
      FROM
      question_likes
      JOIN
      users ON question_likes.user_id = users.id
      WHERE
      question_likes.question_id = ?
    SQL
    result.first["num_likes"]
  end

  def self.likers_for_question_id(question_id)
    result = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
      users.id
      FROM
      question_likes
      JOIN
      users ON question_likes.user_id = users.id
      WHERE
      question_likes.question_id = ?
    SQL
    result.map { |datum| User.find_by_id(datum["id"]) }
  end

  def initialize(options)
    @id = options['id']
    @question_id = options['question_id']
    @user_id = options['user_id']
  end

  def create
    raise "#{self} already in database" if @id
    QuestionsDatabase.instance.execute(<<-SQL, @user_id, @question_id)
      INSERT INTO
        question_likes (user_id, question_id)
      VALUES
        (?, ?)
    SQL
    @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def update
    raise "#{self} already in database" unless @id
    QuestionsDatabase.instance.execute(<<-SQL, @user_id, @question_id, @id)
      UPDATE
        question_likes
      SET
        user_id = ?, question_id = ?
      WHERE
        id = ?
    SQL
  end

end

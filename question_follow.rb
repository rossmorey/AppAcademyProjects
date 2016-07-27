require_relative 'questionsdb'
require_relative 'user'
require_relative 'question'
require 'byebug'

class QuestionFollow
  attr_accessor :id, :user_id, :question_id

  def self.all
    db = QuestionsDatabase.instance.execute("SELECT * FROM question_follows")
    db.map { |datum| QuestionFollow.new(datum) }
  end

  def self.find_by_id(id)
    result = QuestionsDatabase.instance.execute(<<-SQL, id: id)
      SELECT
        *
      FROM
        question_follows
      WHERE
        id = :id
    SQL
    QuestionFollow.new(result.first)
  end

  def self.followers_for_question_id(question_id)
    result = QuestionsDatabase.instance.execute(<<-SQL, question_id: question_id)
      SELECT
        qf.user_id
      FROM
        question_follows AS qf
        JOIN questions AS q
          ON qf.question_id = q.id
      WHERE
        q.id = :question_id
    SQL
    # debugger
    result.map { |datum| User.find_by_id(datum["user_id"]) }
  end

  def self.followed_questions_for_user_id(user_id)
    result = QuestionsDatabase.instance.execute(<<-SQL, user_id: user_id)
      SELECT
        qf.question_id
      FROM
        question_follows AS qf
        JOIN users AS u
          ON qf.user_id = u.id
      WHERE
        u.id = :user_id
    SQL
    # debugger
    result.map { |datum| Question.find_by_id(datum["question_id"]) }
  end

  def self.most_followed_questions(n)
    result = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        question_id, COUNT(*)
      FROM
        question_follows
      GROUP BY
        question_id
      ORDER BY
        2 DESC
      LIMIT
        ?
    SQL
    result.map { |datum| Question.find_by_id(datum["question_id"]) }
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
        question_follows (user_id, question_id)
      VALUES
        (?, ?)
    SQL
    @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def update
    raise "#{self} already in database" unless @id
    QuestionsDatabase.instance.execute(<<-SQL, @user_id, @question_id, @id)
      UPDATE
        question_follows
      SET
        user_id = ?, question_id = ?
      WHERE
        id = ?
    SQL
  end

end

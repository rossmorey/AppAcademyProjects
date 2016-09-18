require_relative 'questionsdb'

class Reply
  attr_accessor :id, :user_id, :parent_id, :question_id, :body

  def self.all
    db = QuestionsDatabase.instance.execute("SELECT * FROM replies")
    db.map { |datum| Reply.new(datum) }
  end

  def self.find_by_id(id)
    result = QuestionsDatabase.instance.execute(<<-SQL, id: id)
      SELECT
        *
      FROM
        replies
      WHERE
        id = :id
    SQL
    # debugger
    Reply.new(result.first)
  end

  def self.find_by_author_id(user_id)
    result = QuestionsDatabase.instance.execute(<<-SQL, user_id: user_id)
      SELECT
        *
      FROM
        replies
      WHERE
        user_id = :user_id
    SQL
    result.map { |datum| Reply.new(datum) }
  end

  def self.find_by_question_id(question_id)
    result = QuestionsDatabase.instance.execute(<<-SQL, question_id: question_id)
      SELECT
        *
      FROM
        replies
      WHERE
        question_id = :question_id
    SQL
    result.map { |datum| Reply.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @user_id = options['user_id']
    @parent_id = options['parent_id']
    @question_id = options['question_id']
    @body = options['body']

  end

  def create
    raise "#{self} already in database" if @id
    QuestionsDatabase.instance.execute(<<-SQL, @user_id, @parent_id, @question_id, @body)
      INSERT INTO
        replies (user_id, parent_id, question_id, body)
      VALUES
        (?, ?, ?, ?)
    SQL
    @id = QuestionsDatabase.instance.last_insert_row_id
  end

  def update
    raise "#{self} already in database" unless @id
    QuestionsDatabase.instance.execute(<<-SQL, @user_id, @parent_id, @question_id, @body, @id)
      UPDATE
        replies
      SET
        user_id = ?, parent_id = ?, question_id = ?, body = ?
      WHERE
        id = ?
    SQL
  end

  def author
    User.find_by_id(@user_id)
  end

  def question
    Question.find_by_id(@question_id)
  end

  def parent_reply
    Reply.find_by_id(@parent_id)
  end

  def child_replies
    result = QuestionsDatabase.instance.execute(<<-SQL, @id)
      SELECT
        *
      FROM
        replies
      WHERE
        parent_id = ?
    SQL
    result.map { |datum| Reply.new(datum) }
  end

end

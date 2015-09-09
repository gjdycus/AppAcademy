require_relative 'questions_database.rb'
require_relative 'user.rb'
require_relative 'question.rb'
require_relative 'model_base'

class Reply < ModelBase

  def self.table
    'replies'
  end

  def self.find_by_user_id(id)
    results = QuestionsDatabase.instance.execute(<<-SQL, id: id)
      SELECT
        *
      FROM
        replies
      WHERE
        user_id = :id
    SQL
    results.map { |result| Reply.new(result) }
  end

  def self.find_by_question_id(id)
    results = QuestionsDatabase.instance.execute(<<-SQL, id: id)
      SELECT
        *
      FROM
        replies
      WHERE
        subject_question_id = :id
    SQL
    results.map { |result| Reply.new(result) }
  end

  def self.find_by_parent_id(id)
    results = QuestionsDatabase.instance.execute(<<-SQL, id: id).first
      SELECT
        *
      FROM
        replies
      WHERE
        parent_reply_id = :id
    SQL
    Reply.new(results)
  end

  attr_accessor :id, :subject_question_id, :parent_reply_id, :user_id, :body
  def initialize(attributes)
    @id = attributes['id']
    @subject_question_id = attributes['subject_question_id']
    @parent_reply_id = attributes['parent_reply_id']
    @body = attributes['body']
    @user_id = attributes['user_id']
  end

  def author
    User::find_by_id(user_id)
  end

  def question
    Question::find_by_id(subject_question_id)
  end

  def parent_reply
    Reply::find_by_id(parent_reply_id)
  end

  def child_replies
    Reply::find_by_parent_id(id)
  end

  def save
    if id.nil?
      QuestionsDatabase.instance.execute(<<-SQL, subject_question_id: subject_question_id, parent_reply_id: parent_reply_id, body: body, user_id: user_id)
        INSERT INTO
          replies (subject_question_id, parent_reply_id, body, user_id)
        VALUES
          (:subject_question_id, :parent_reply_id, :body, :user_id)
      SQL
    else
      QuestionsDatabase.instance.execute(<<-SQL, id: id, subject_question_id: subject_question_id, parent_reply_id: parent_reply_id, body: body, user_id: user_id)
        UPDATE
          replies
        SET
          subject_question_id = :subject_question_id,
          parent_reply_id = :parent_reply_id,
          body = :body,
          user_id = :user_id
        WHERE
          id = :id
      SQL
    end
  end
end

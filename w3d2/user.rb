require_relative 'questions_database.rb'
require_relative 'question.rb'
require_relative 'reply.rb'
require_relative 'question_follow'
require_relative 'question_like'
require_relative 'model_base'

class User < ModelBase

  def self.table
    'users'
  end

  def self.find_by_name(fname, lname)
    results = QuestionsDatabase.instance.execute(<<-SQL, fname: fname, lname: lname).first
      SELECT
        *
      FROM
        users
      WHERE
        fname = :fname
        AND lname = :lname
    SQL

    User.new(results)
  end

  attr_accessor :fname, :lname, :id

  def initialize(attributes)
    @id = attributes['id']
    @fname = attributes['fname']
    @lname = attributes['lname']
  end

  def authored_questions
    Question::find_by_author_id(id)
  end

  def authored_replies
    Reply::find_by_user_id(id)
  end

  def followed_questions
    QuestionFollow::followed_questions_for_user_id(id)
  end

  def liked_questions
    QuestionLike::liked_questions_for_user_id(id)
  end

  def average_karma
    results = QuestionsDatabase.instance.execute(<<-SQL, user_id: id)
      SELECT
        CAST(COUNT(question_likes.id) as FLOAT)/COUNT(DISTINCT questions.id)
      FROM
        questions
      LEFT OUTER JOIN
        question_likes ON questions.id = question_likes.question_id
      WHERE
        questions.author_id = :user_id
      GROUP BY
        questions.author_id
    SQL

    return nil if results.empty?
    results.first.values.first
  end

  def save
    if id.nil?
      QuestionsDatabase.instance.execute(<<-SQL, fname: fname, lname: lname)
        INSERT INTO
          users (fname, lname)
        VALUES
          (:fname, :lname)
      SQL
    else
      QuestionsDatabase.instance.execute(<<-SQL, fname: fname, lname: lname, id: id)
        UPDATE
          users
        SET
          fname = :fname,
          lname = :lname
        WHERE
          id = :id
      SQL
    end
  end
end

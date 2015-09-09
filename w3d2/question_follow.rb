require_relative 'questions_database'
require_relative 'user'
require_relative 'question'
require_relative 'model_base'

class QuestionFollow < ModelBase

  def self.table
    'questions_follows'
  end

  def self.followers_for_question_id(question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, question_id: question_id)
      SELECT
        users.id, users.fname, users.lname
      FROM
        questions_follows
      INNER JOIN
        users ON questions_follows.user_id = users.id
      WHERE
        questions_follows.question_id = :question_id
    SQL
    results.map {|result| User.new(result)}
  end

  def self.followed_questions_for_user_id(user_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, user_id: user_id)
      SELECT
        questions.id, questions.title, questions.body, questions.author_id
      FROM
        questions_follows
      JOIN
        questions ON questions_follows.question_id = questions.id
      WHERE
        questions_follows.user_id = :user_id
    SQL

    results.map {|result| Question.new(result)}
  end

  def self.most_followed_questions(n)
    results = QuestionsDatabase.instance.execute(<<-SQL, n: n)
      SELECT
        questions.id, questions.title, questions.body, questions.author_id
      FROM
        questions_follows
      JOIN
        questions ON questions_follows.question_id = questions.id
      GROUP BY
        questions.id
      ORDER BY
        COUNT(questions.id) DESC
      LIMIT
        :n
    SQL

    results.map {|result| Question.new(result)}
  end

  attr_accessor :id, :user_id, :question_id

  def initialize(attributes)
    @id = attributes['id']
    @user_id = attributes['user_id']
    @question_id = attributes['question_id']
  end
end

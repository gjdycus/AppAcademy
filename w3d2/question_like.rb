require_relative 'questions_database'
require_relative 'user'
require_relative 'question'
require_relative 'model_base'

class QuestionLike < ModelBase

  def self.table
    'question_likes'
  end

  def self.likers_for_question_id(question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, question_id: question_id)
      SELECT
        users.id, users.fname, users.lname
      FROM
        question_likes
      JOIN
        users ON question_likes.user_id = users.id
      WHERE
        question_likes.question_id = :question_id
    SQL

    results.map {|result| User.new(result)}
  end

  def self.num_likes_for_question_id(question_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, question_id: question_id)
      SELECT
        COUNT(question_likes.user_id)
      FROM
        question_likes
      WHERE
        question_likes.question_id = :question_id
      GROUP BY
        question_likes.question_id
    SQL
    return 0 if results.empty?
    results.first.values.first
  end

  def self.liked_questions_for_user_id(user_id)
    results = QuestionsDatabase.instance.execute(<<-SQL, user_id: user_id)
      SELECT
        questions.id, questions.title, questions.body, questions.author_id
      FROM
        question_likes
      JOIN
        questions ON question_likes.question_id = questions.id
      WHERE
        question_likes.user_id = :user_id
    SQL

    results.map {|result| Question.new(result)}
  end

  def self.most_liked_questions(n)
    results = QuestionsDatabase.instance.execute(<<-SQL, n: n)
      SELECT
        questions.id, questions.title, questions.body, questions.author_id
      FROM
        question_likes
      JOIN
        questions ON question_likes.question_id = questions.id
      GROUP BY
        question_likes.question_id
      ORDER BY
        COUNT(question_likes.user_id) DESC
      LIMIT
        :n
    SQL
    results.map {|result| Question.new(result)}
  end

  attr_accessor :id, :question_id, :user_id
  def initialize(attributes)
    @id = attributes['id']
    @question_id = attributes['question_id']
    @user_id = attributes['user_id']
  end
end

require_relative 'questions_database.rb'
require_relative 'user.rb'
require_relative 'reply.rb'
require_relative 'question_follow'
require_relative 'question_like'
require_relative 'model_base'


class Question < ModelBase

  def self.table
    'questions'
  end

  def self.find_by_author_id(id)
    results = QuestionsDatabase.instance.execute(<<-SQL, id: id)
      SELECT
        *
      FROM
        questions
      WHERE
        author_id = :id
    SQL
    results.map { |result| Question.new(result) }
  end

  def self.most_followed(n)
    QuestionFollow::most_followed_questions(n)
  end

  def self.most_liked(n)
    QuestionLike::most_liked_questions(n)
  end

  attr_accessor :title, :body, :author_id, :id

  def initialize(attributes)
    @id = attributes['id']
    @title = attributes['title']
    @body = attributes['body']
    @author_id = attributes['author_id']
  end

  def author
    User::find_by_id(author_id)
  end

  def replies
    Reply::find_by_question_id(id)
  end

  def followers
    QuestionFollow::followers_for_question_id(id)
  end

  def num_likes
    QuestionLike::num_likes_for_question_id(id)
  end

  def likers
    QuestionLike::likers_for_question_id(id)
  end

  def save
    if id.nil?
      QuestionsDatabase.instance.execute(<<-SQL, title: title, body: body, author_id: author_id)
        INSERT INTO
          questions (title, body, author_id)
        VALUES
          (:title, :body, :author_id)
      SQL
    else
      QuestionsDatabase.instance.execute(<<-SQL, id: id, title: title, body: body, author_id: author_id)
        UPDATE
          questions
        SET
          title = :title,
          body = :body,
          author_id = :author_id
        WHERE
          id = :id
      SQL
    end
  end
end

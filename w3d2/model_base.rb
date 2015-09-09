require_relative 'questions_database'
require 'byebug'

class ModelBase

  def self.table
    'model_base'
  end

  def self.find_by_id(id)
    sql = <<-SQL
      SELECT
        *
      FROM
        #{self.table}
      WHERE
        id = :id
    SQL
    results = QuestionsDatabase.instance.execute(sql, id: id).first
    self.new(results)
  end

  def self.all
    results = QuestionsDatabase.instance.execute(<<-SQL)
      SELECT
        *
      FROM
        #{self.table}
    SQL
    results.map {|result| self.new(result)}
  end
end

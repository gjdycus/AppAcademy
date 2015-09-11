# == Schema Information
#
# Table name: responses
#
#  id               :integer          not null, primary key
#  user_id          :integer          not null
#  answer_choice_id :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Response < ActiveRecord::Base
  validates :answer_choice_id, :user_id, presence: true
  validates :user_id, uniqueness: { scope: :answer_choice_id }
  validate :respondent_has_not_already_answered_question

  belongs_to :answer_choice,
    class_name: "AnswerChoice",
    foreign_key: :answer_choice_id,
    primary_key: :id

  belongs_to :respondents,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id

  has_one :question, through: :answer_choice, source: :question

  def sibling_responses
    self.question.responses.where("responses.id != ? AND ? IS NOT NULL", self.id, self.id)
  end

  def respondent_has_not_already_answered_question
    if sibling_responses.exists?(user_id: :user_id)
      errors[:base] << "You already answered this question"
    end
  end
end

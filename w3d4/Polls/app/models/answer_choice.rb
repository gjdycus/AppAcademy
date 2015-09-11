# == Schema Information
#
# Table name: answer_choices
#
#  id          :integer          not null, primary key
#  item        :text             not null
#  question_id :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class AnswerChoice < ActiveRecord::Base
  validates :question_id, :item, presence: true

  belongs_to :question,
    class_name: "Question",
    foreign_key: :question_id,
    primary_key: :id

  has_one :response,
    class_name: "Response",
    foreign_key: :answer_choice_id,
    primary_key: :id
end

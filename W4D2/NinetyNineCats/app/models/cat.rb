# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  birth_date  :date             not null
#  color       :string           not null
#  sex         :string(1)        not null
#  description :text             not null
#  created_at  :datetime
#  updated_at  :datetime
#

class Cat < ActiveRecord::Base
  include CatsHelper

  validates :name, :birth_date, :color, :sex, :description, presence: true
  validates :color, inclusion: ["Black", "White", "Calico"]

  has_many :cat_rental_requests,
    -> { order 'cat_rental_requests.start_date asc' },
    class_name: "CatRentalRequest",
    foreign_key: :cat_id,
    primary_key: :id

end

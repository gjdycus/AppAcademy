# == Schema Information
#
# Table name: tracks
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  album_id   :integer          not null
#  ttype      :string           not null
#  lyrics     :text             not null
#  created_at :datetime
#  updated_at :datetime
#

class Track < ActiveRecord::Base
  validates :name, :ttype, :album_id, :lyrics, presence: true

  belongs_to :album,
    class_name: "Album",
    foreign_key: :album_id,
    primary_key: :id

  has_many :notes,
    -> { order "created_at DESC" },
    class_name: "Note",
    foreign_key: :track_id,
    primary_key: :id,
    dependent: :destroy
end

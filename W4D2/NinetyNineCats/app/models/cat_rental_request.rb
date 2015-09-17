class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: ["APPROVED", "DENIED", "PENDING"]
  validate :overlapping_approved_requests

  after_initialize do
    self.status ||= "PENDING"
  end

  belongs_to :cat,
    class_name: "Cat",
    foreign_key: :cat_id,
    primary_key: :id,
    dependent: :destroy

  def overlapping_requests(other_request)
    (self.start_date .. self.end_date).include?(other_request.start_date) ||
    (self.start_date .. self.end_date).include?(other_request.end_date)
  end

  def overlapping_approved_requests
    CatRentalRequest.all.each do |request|
      if request.status == "APPROVED" && overlapping_requests(request)
        errors[:request] << "The cat is not available for those dates"
      end
    end
  end

  def approve!
    ActiveRecord::Base.transaction do
      self.status = "APPROVED"
      if self.save
        CatRentalRequest.each do |request|
          if request.status == "PENDING" && self.overlapping_requests(request)
            request.deny!
          end
        end
      else
        raise "hell"
      end
    end
  end

  def deny!
    self.status = "DENIED"
  end

end

module CatsHelper
  def age
    (Date.today - birth_date).to_i/365
  end
end

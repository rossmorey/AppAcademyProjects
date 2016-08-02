class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: { in: ['PENDING', 'APPROVED', 'DENIED'] }
  validate :overlapping_approved_requests
  validate :bad_start_dates

  belongs_to :cat

  def overlapping_requests
    return false if self.status != "APPROVED"
    cat.cat_rental_requests.each do |request|
      next if request.id == self.id
      next unless request.status == "APPROVED"
      return true if self.start_date <= request.end_date && self.start_date >= request.start_date
      return true if self.end_date <= request.end_date && self.end_date >= request.start_date
    end
    false
  end

  def bad_start_dates
    if self.end_date < self.start_date
      self.errors[:dates] << "start date must be before end date"
    end
  end

  def overlapping_approved_requests
    if overlapping_requests
      self.errors[:dates] << "overlap"
    end
  end

end

module Validation
  def self.validate_date(date)
    if date.empty?
      ''
    else
      date = DateRef.find_or_create_by(date: date)
      date.id
    end
  end
end
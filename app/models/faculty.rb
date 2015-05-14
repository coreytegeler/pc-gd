class Faculty < ActiveRecord::Base

	scope :visible, lambda {where(:visible => true)}
	scope :invisible, lambda {where(:visible => false)}
	scope :first_to_last, lambda {order("faculties.position ASC")}
	scope :a_to_z, lambda {order("faculties.last_name ASC")}
	scope :search, lambda {|query|
		where(["name LIKE ?", "%#{query}%"])
	}

	acts_as_list scope: [:position]

	has_many :alma_maters
	accepts_nested_attributes_for :alma_maters, reject_if: proc { |attributes| attributes['college'].blank? }, :allow_destroy => true

  	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  	
  	validates_presence_of :first_name, :last_name
  	validates_format_of :email, :with => VALID_EMAIL_REGEX
	validates_confirmation_of :email
	validates_associated :alma_maters
end
class Alumnus < ActiveRecord::Base

	scope :visible, lambda {where(:visible => true)}
	scope :invisible, lambda {where(:visible => false)}
	scope :first_to_last, lambda {order("alumni.position ASC")}
	scope :last_to_first, lambda {order("alumni.position ASC")}
	scope :new_to_old, lambda {order("alumni.created_at DESC")}
	scope :old_to_new, lambda {order("alumni.created_at ASC")}
	scope :search, lambda {|query|
		where(["name LIKE ?", "%#{query}%"])
	}

	acts_as_list scope: [:position]

	validates_presence_of :first_name, :last_name, :link
	before_validation :format_url

	private

	def format_url
		unless self.url[/\Ahttp:\/\//] || self.url[/\Ahttps:\/\//]
    		self.url = "http://#{self.url}"
  		end
	end

end

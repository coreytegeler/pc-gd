class CourseImage < ActiveRecord::Base

  belongs_to :course
  scope :sorted, lambda {order("course_images.position ASC")}

  has_attached_file :image,
  :styles => { 
		:small =>  ['300x300'],
		:medium => ['400x350']
	},
	:default_url => "image.svg"
		
	validates_attachment_content_type :image, 
  content_type: /^image\/(jpg|jpeg|pjpeg|png|x-png|gif)/

  validates_presence_of :image

end

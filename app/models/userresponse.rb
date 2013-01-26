class Userresponse < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :user
  belongs_to :response

  validates :user_id, :presence => true
  validates :response_id, :presence => true

  validates :user_id, :uniqueness => {:response => :poll_id}
end

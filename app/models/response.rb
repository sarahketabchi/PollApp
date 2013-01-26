class Response < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :poll
  has_many :userresponses
  has_many :users, :through => :userresponses

end

class Poll < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :user
  has_many :responses
  has_many :userresponses, :through => :responses

  validates :user_id, :presence => true
  validates :question, :presence => true

  def add_options(response_array)
    response_array.each do |response|
      r = Response.new
      r.option = response
      r.poll_id = self.id
      r.save
    end
  end

  def get_results
    # We did it the way ned wanted us to, but it doesnt return the responses
    # that nobody picked. so we used the hacky way :)
    # join_table = self.responses.joins(:userresponses).group(:response_id)
    # results = join_table.select("responses.*, COUNT(userresponses.id) AS num_responses")
    # results.map! {|r| [r.num_responses, r]}
    # => Array of Response objects (Not [Response, UserResponse])
    self.responses.map do |response|
      [response.userresponses.count, response]
    end.sort.reverse
  end

  def get_options
    self.responses
  end

end

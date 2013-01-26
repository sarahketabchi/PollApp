class User < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :polls
  has_many :userresponses
  has_many :responses, :through => :userresponses

  validates :name, :presence => true

  def create_poll(question)
    p = Poll.new
    p.question = question
    p.user = self
    p.save
    p
  end

  def answer_poll(response)
    r = Userresponse.new
    r.user = self
    r.response = response
    r.save
  end

  def get_polls
    self.polls
  end

  def get_answers
    answers = self.responses.joins(:poll).select("responses.option, polls.question AS q")
    answers.map {|answer| [answer.q, answer]}
  end

  def self.create_user(name)
    find_or_create_by_name(name)
  end
end

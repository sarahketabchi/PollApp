
class PollCLI

  def initialize
    @user = get_user
  end

  def get_user
    puts "Welcome to the Poll App!"
    puts "What is your name?"
    User.create_user(gets.chomp.capitalize)
  end

  def run
    while true
      option = get_initial_option
      puts
      run_initial_option(option)
      break unless wanna_do_more?
    end

    puts "Thanks for using our polling application"
    puts "Bye!"
  end

  def get_initial_option
    puts "1. Create a poll"
    puts "2. Answer a poll"
    puts "3. Get some fun statistics"
    get_option
  end

  def get_option
    print "Which would u like to do (enter the s.no.): "
    gets.chomp.to_i
  end

  def run_initial_option(option)
    case option
    when 1
      create_poll
    when 2
      answer_poll
    when 3
      run_statistics
    else
      puts "Invalid input"
    end
    puts
  end

  def create_poll
    puts "Please enter your poll question:"
    poll = @user.create_poll(gets.chomp)
    puts
    puts "Please enter all its possible responses (e.g. yes,no,maybe)"
    poll.add_options(gets.chomp.split(","))
    puts
    puts "Congrats! Your poll has been created!"
    puts "Your poll's id: #{poll.id}"
    puts
  end

  def print_all_polls
    Poll.all.each { |poll| puts "#{poll.id}. #{poll.question}" }
  end

  def answer_poll
    print_all_polls
    print "Pick a poll to answer (enter the s.no.): "

    if poll = Poll.find(gets.chomp.to_i)
      puts
      response = get_response(poll)

      if @user.answer_poll(response)
        puts "The poll has been updated!"
      else
        puts "You have already answered this poll!"
        puts
      end
    else
      puts "Invalid input"
      puts
    end
  end

  def get_response(poll)
    puts "These are your response choices"
    options = poll.responses
    options.each_with_index { |option, i| puts "#{i+1}. #{option.option}"}
    print "Please choose one! (enter the s.no.): "
    Response.find(options[(gets.chomp.to_i-1)].id)
  end

  def wanna_do_more?
    puts "Do you wanna continue (y/n)?"
    return true if gets.chomp.downcase[0] == "y"
    false
  end

  def run_statistics
    option = get_statistics_option
    run_statistics_option(option)
  end

  def run_statistics_option(option)
    case option
    when 1
      print_user_polls(@user)
    when 2
      print_user_answers(@user)
    when 3
      print_user_polls(get_other_user)
    when 4
      print_user_answers(get_other_user)
    when 5
      print_results(get_poll)
    when 6
      puts "We cant do this one yet"
    else
      puts "Invalid Input"
    end
    puts
  end

  def print_user_polls(user)
    polls = user.polls
    polls.each_with_index { |poll, i| puts "#{i + 1}. #{poll.question}" }
  end

  def print_user_answers(user)
    user.get_answers.each do |answer|
      puts "Q: #{answer[0]}"
      puts "A: #{answer[1].option}"
    end
  end

  def get_other_user
    puts "Please enter the name of the user: "
    if user = User.find_by_name(gets.chomp.capitalize)
      return user
    else
      puts "This user does not exist in our database"
      puts
    end
  end

  def print_results(poll)
    if poll
      poll.get_results.each do |response|
        puts "#{response[1].option} - #{response[0]} votes"
      end
    else
      puts "Invalid input"
      puts
    end
  end

  def get_poll
    print_all_polls
    print "Which polls results do u want? (enter the s.no.): "
    Poll.find(gets.chomp.to_i)
  end

  def get_statistics_option
    puts "1. See your submitted polls"
    puts "2. See all the polls you've already answered"
    puts "3. See polls submitted by another user"
    puts "4. See the polls answered by another user"
    puts "5. See the results of a poll"
    puts "6. See the most popular poll"
    get_option
  end
end

poll_app = PollCLI.new
poll_app.run

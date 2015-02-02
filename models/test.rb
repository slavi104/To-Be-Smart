class TestUser < ActiveRecord::Base
  has_many :tracks
  require 'json'

  def self.get_tests(category)
    @tests = TestUser.where(:category => category) unless category == 'all'
    @tests = TestUser.all() if category == 'all'
    result = ''
    @tests.each { |test| 
      result << "<a class='test_item' href='test?id=#{test.id}'><div><img class='category_img test_img' style='width:200px;' src='#{test.image}'/></div><span class='testTitle'>#{test.title}</span></a>"
    }
    result
  end

  def self.get_test(id)
    test = TestUser.find_by(:id => id)
  end

  def grade_json(params)

    hash = Hash.new
    questions = self.content.split('@')
    question_answer_switch = false
    question1 = ''
    questions.each do |question|
      if question_answer_switch 
        answers = question.split('$')
        hash[question1] = Hash.new
        answer_points_switch = false
        index = 0
        answers.each do |answer|
          if answer_points_switch
            hash[question1][answers[index-1].gsub(" ", "_")] = answer.gsub(" ", "_")
          end
          index += 1
          answer_points_switch = !answer_points_switch
        end
      else 
        question1 = question.gsub(" ", "_")
      end
      question_answer_switch = !question_answer_switch
    end

    TestUser.calculate_test_points(params, hash)

    hash.to_json

  end

  def generate_test

    questions = self.content.split('@');
    html = "<h1><div id='testName'>#{self.title}</div></h1>"
    question_answer_switch = true
    under_scored_question = ''
    questions.each do |question|
      if question_answer_switch
        under_scored_question = question.gsub(" ", "_")
        html << "<br><div id='#{under_scored_question}' class='question'><b>#{question}</b></div>"
      else 
        answers = question.split('$')
        answer_points_switch = true
        answers.each do |answer|
          if answer_points_switch
            html << "<input class='answer #{under_scored_question}' name='#{under_scored_question}' type='radio' value='#{answer.gsub(" ", "_")}'><i>#{answer}</i><br>"
          end
          answer_points_switch = !answer_points_switch
        end
      end
      question_answer_switch = !question_answer_switch
    end
    html

  end

  def self.calculate_test_points(user_answers_hash, correct_answers_hash)
    points = 0
    user_answers_hash.each do |u_question, u_answer|
      if correct_answers_hash[u_question]
        points += correct_answers_hash[u_question][u_answer].to_i
      end
    end
    SESSION['current_user'].test_points = points + SESSION['current_user'].test_points
    SESSION['current_user'].save
  end
    
end
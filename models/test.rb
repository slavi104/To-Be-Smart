class TestUser < ActiveRecord::Base
  has_many :tracks
  require 'json'
  require_relative '../helpers/constants.rb'

  def self.get_tests(category, session)
    @tests = TestUser.where(:category => category) unless category == 'all'
    @tests = TestUser.all() if category == 'all'

    result = ''
    @tests.each { |test|
      graded_test = GradedTest.where(:user_id => session['current_user'].id, :test_id => test.id).first if session['current_user']
      if graded_test
        result << "<a class='test_item' href='tests'>
                    <div>
                      <span class='graded_test'>#{Constants::GRADED_TEST}<br>#{Constants::POINTS}:#{graded_test.points}</span>
                      <img class='category_img test_img' style='width:200px;' src='#{test.image}'/>
                    </div>
                    <span class='testTitle'>#{test.title}</span>
                  </a>"
      else
        result << "<a class='test_item' href='test?id=#{test.id}'>
                    <div>
                      <img class='category_img test_img' style='width:200px;' src='#{test.image}'/>
                    </div>
                    <span class='testTitle'>#{test.title}</span>
                  </a>"
      end
    }
    result
  end

  def self.get_test(id)
    test = TestUser.find_by(:id => id)
  end

  def grade_json(params, session)
    # puts params.to_s
    result = Hash.new
    questions = self.content.split('@')
    question_answer_switch = false
    question1 = ''
    questions.each do |question|
      if question_answer_switch 
        answers = question.split('$')
        result[question1] = Hash.new
        answer_points_switch = false
        index = 0
        answers.each do |answer|
          if answer_points_switch
            result[question1][answers[index-1].gsub(" ", "_")] = answer.gsub(" ", "_")
          end
          index += 1
          answer_points_switch = !answer_points_switch
        end
      else 
        question1 = question.gsub(" ", "_")
      end
      question_answer_switch = !question_answer_switch
    end

    TestUser.calculate_test_points(params, result, self.id, session)

    # puts result.to_json
    result.to_json

  end

  def generate_test

    questions = self.content.split('@');
    html = "<h1><div id='testName'>#{self.title}</div></h1>"
    question_answer_switch = true
    under_scored_question = ''
    question_number = 0
    questions.each do |question|
      if question_answer_switch
        question_number += 1
        under_scored_question = question.gsub(" ", "_")
        html << "<br><div id='#{under_scored_question}' class='question'><b>#{question_number}. #{question}</b></div>"
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

  def self.calculate_test_points(user_answers_hash, correct_answers_hash, test_id, session)
    points = 0
    user_answers_hash.each do |u_question, u_answer|
      if correct_answers_hash[u_question]
        points += correct_answers_hash[u_question][u_answer].to_i
      end
    end

    # save this test as graded
    GradedTest.add_graded(test_id, points, session)

    session['current_user'].test_points = points + session['current_user'].test_points
    session['current_user'].save unless Object::IS_TEST
  end
    
end
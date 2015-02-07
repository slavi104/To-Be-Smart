class GradedTest < ActiveRecord::Base

  require "Date"
  require_relative '../helpers/constants.rb'

  def self.get_graded(session)
    graded_tests = GradedTest.where(:user_id => session['id'])
    html = ''
    graded_tests.each do |graded_test|
      test_user = TestUser.where(:id => graded_test.test_id).first

      html<<"<tr>
                <th>#{graded_test.date}</th>
                <th>#{test_user.title}</th>
                <th>#{Constants::CATEGORIES[test_user.category]}</th>
                <th>#{graded_test.points} (#{test_user.max_points})</th>
            </tr>"
    end
    html
  end

  def self.add_graded(test_id, points, session)
    graded_test = GradedTest.new()
    graded_test.test_id = test_id
    graded_test.points = points
    graded_test.user_id = session['id']
    graded_test.date = Date.today.to_s
    graded_test.save
  end

  def self.success_tests(session)
    graded_tests = GradedTest.where(:user_id => session['current_user'].id)
    success_procent = 0
    graded_tests.each do |graded_test|
      test = TestUser.where(:id => graded_test.test_id).first
      success_procent += Rational(graded_test.points, test.max_points)
    end
    graded_tests.count.to_i > 0 ? (Rational(success_procent, graded_tests.count.to_i)*100.00).round(2) : 0
  end

  def self.procent_tests(session)
    ((Rational(GradedTest.where(:user_id => session['current_user'].id).count.to_i, TestUser.all().count.to_i))*100.00).round(2)
  end

end
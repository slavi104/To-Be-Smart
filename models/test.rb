class Test < ActiveRecord::Base
  has_many :tracks

  def self.get_tests(category)
    @tests = Test.where(:category => category)
    result = ''
    @tests.each { |test| 
      result << "<a href='test?id=#{test.id}'><div><img style='width:200px;' src='#{test.image}'/></div><span class='testTitle'>#{test.title}</span></a>"
    }
    result
  end

  def self.get_test(id)
    test = Test.find_by(:id => id)
  end
end
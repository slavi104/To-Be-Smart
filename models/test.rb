class Test < ActiveRecord::Base
  has_many :tracks

  def self.get_test
    @tests = Test.all()
  end
end
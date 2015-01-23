require "erb"
class Index
	def initialize(args)
		
	end
	
	def self.show_main_page()
	  erb :index
	end
end

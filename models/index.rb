class Index
	def self.show_main_page
	filename = 'C:\dev\views\index.erb'   # 'arg1' and 'arg2' are used in example.rhtml
  File.read(filename).to_s
	end
end

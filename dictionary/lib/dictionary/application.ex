defmodule Dictionary.Application do
	
	use Application

	def start( _type, _args ) do
		Dictionary.Word_list.start_link()
	end

end
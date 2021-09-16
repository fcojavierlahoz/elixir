defmodule Dictionary.Application do
	
	use Application

	# start application
	#def start( _type, _args ) do
	#		Dictionary.Word_list.start_link()
	#end

	# star supervisor
	def start( _type, _args ) do
		
		import Supervisor.Spec

		children = [
			worker(Dictionary.Word_list, []),
		]

		options = [
			name: Dictionary.Supervisor,
			strategy: :one_for_one,
		]

		Supervisor.start_link(children,options)
	end
end
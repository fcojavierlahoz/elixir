defmodule TextClient.Player do

	alias TextClient.{Mover,Prompter,State,Summary}

	# won, lost, good_guess, bad_guess, already user, initializing
	def play(game = %State{tally: %{ game_state: :won}}) do
		Summary.display(game)
		exit_with_message("You Won!!")
	end

	def play(game = %State{tally: %{ game_state: :lost}}) do
		exit_with_message("Sorry, you Lost!!") #Letters:  #{Enum.join(tally.letters, "")}")
	end

	def play(game = %State{tally: %{ game_state: :good_guess}}) do
		continue_with_message(game,"Goog guess!")
	end

	def play(game = %State{tally: %{ game_state: :bad_guess}}) do
		continue_with_message(game,"Sorry, that isn't in the word")
	end

	def play(game = %State{tally: %{ game_state: :already_used}}) do
		continue_with_message(game,"You've already used that letter")
	end

	def play(game) do
		continue(game)
	end

	def continue(game) do
		game
		|> Summary.display()
		|> Prompter.accept_move()
		|> Mover.move()
		|> play()
	end


	defp continue_with_message(game,msg) do
		IO.puts(msg)
		continue(game)
	end

	defp exit_with_message(msg) do
		IO.puts(msg)
		exit(:normal)
	end
end
defmodule Hangman do
  
  def new_game() do
    #Hangman.Server.start_link()
    {:ok, pid} = Supervisor.start_child(Hangmans.Supervisor, [])
    pid
  end

  def make_move(game_pid,guess) do
    GenServer.call(game_pid, { :make_move, guess })
  end

  def tally(game_pid) do
    GenServer.call(game_pid, { :tally })
  end

end

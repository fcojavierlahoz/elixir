defmodule Dictionary.Word_list do
  
  @me __MODULE__

  def start_link() do
    Agent.start_link(&word_list/0, name: @me)  
  end

  def word_list() do
    "/Users/javierlahoz/Documents/elixir/dictionary/assets/words.txt" 
    |> File.read! 
    |> String.split(~r/\n/)
  end

  def random_word() do
    Agent.get(@me, &Enum.random/1)
  end

  ##################################

  defp read_file({ :ok, file }) do 
    file
    |> IO.read(:line)
  end

  defp read_file({ :error, reason }) do 
    IO.puts "File error: #{reason}"
  end
  

end
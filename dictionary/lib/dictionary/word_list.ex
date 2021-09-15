defmodule Dictionary.Word_list do
  

  def start() do
    #contents = File.read!("assets/words.txt")
    #String.split(contents, ~r/\n/)
    "/Users/javierlahoz/Documents/elixir/dictionary/assets/words.txt" 
    |> File.read! 
    |> String.split(~r/\n/)
  end

  def random_word(word_list) do
    #Enum.random(word_list())
    word_list
    |> Enum.random
  end

  defp read_file({ :ok, file }) do 
    file
    |> IO.read(:line)
  end

  defp read_file({ :error, reason }) do 
    #use Logger
    #Logger.error("File error: #{reason}")
    #[]
    IO.puts "File error: #{reason}"
  end
  

end
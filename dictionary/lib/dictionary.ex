defmodule Dictionary do
  
  def random_word do
    #Enum.random(word_list())
    word_list()
    |> Enum.random
  end

  def word_list do
    #contents = File.read!("assets/words.txt")
    #String.split(contents, ~r/\n/)
    "assets/words.txt" 
    |> File.read! 
    |> String.split(~r/\n/)
  end

  def read_file({ :ok, file }) do 
    file
    |> IO.read(:line)
  end

  def read_file({ :error, reason }) do 
    #use Logger
    #Logger.error("File error: #{reason}")
    #[]
    IO.puts "File error: #{reason}"
  end
  

end
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
end
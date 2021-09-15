defmodule Dictionary do
  
  alias Dictionary.Word_list

  defdelegate start(),                to: Word_list
  defdelegate random_word(word_list), to: Word_list

end
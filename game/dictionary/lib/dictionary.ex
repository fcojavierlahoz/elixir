defmodule Dictionary do
  
  alias Dictionary.Word_list

  #defdelegate start(),                to: Word_list, as: :word_list
  defdelegate random_word(), to: Word_list

end
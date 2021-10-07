defmodule Demo do
  
  def reverse do
    receive do
      msg ->
	result = msg |> String.reverse
	IO.puts result
	reverse()
     end
  end

end

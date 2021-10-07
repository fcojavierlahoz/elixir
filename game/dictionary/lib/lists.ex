defmodule Lists do
	def len( [] ), do: 0
	def len([ _head | tail]), do: 1 + len(tail)

	def sum( [] ), do: 0
	def sum([ head | tail]), do: head + sum(tail)

	def double([]), do: []
	def double([ head | tail ]), do: [ 2*head | double(tail) ]

	def square([]), do: []
	def square([ head | tail ]), do: [ head*head | square(tail) ]

	def sum_pairs([]), do: []
	def sum_pairs([ h1, h2 | t]), do: [ h1 + h2 | sum_pairs(t) ]

	def permute({ a, b}), do: {b,a}

	def validate({a,a}), do: :true
  	def validate({a,b}), do: :false

	def even_length(l), do: validate({Lists.len(l) |> Integer.mod(2) , 0})
	def even_length(l), do: validate({Lists.len(l) |> Integer.mod(2) , 1})
	 
end
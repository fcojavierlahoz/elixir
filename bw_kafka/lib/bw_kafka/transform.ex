defmodule BwKafka.Transform do

  def process_data(data) do
    IO.inspect(data, label: "Got message")
  end
    
end
  
defmodule Test do
  defstruct [:id, :field1, :field2, :field3]
end

defmodule BwKafka.Transform do

  def process_data(data) do
    #IO.inspect(data, label: "Got message")
    data 
    |> decode_data()
    data
  end

  def insert_data(data) do
    IO.inspect(data, label: "Got message")
    data 
    |> insert()
    data
  end


  defp decode_data(data) do
    json = Poison.decode!(data)
    %Test{
      id: json["id"],
      field1: json["field1"],
      field2: json["field2"],
      field3: json["field3"],
    }
    |>
    IO.inspect(label: "Got message")  
  end

  defp insert(data) do
    Poison.decode!(data)
    |> BwKafka.Mysql.insert()
  end
    
end
  
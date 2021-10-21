defmodule BwKafka.Hdfs do

    def put(messages) do
        list_msg = messages |> Enum.map(fn e -> e.data <> "\n" end)
        |> http_create() 
    end

    defp http_create(message) do
        name = "test-" <> Integer.to_string(:os.system_time(:millisecond))
        HTTPoison.put("http://localhost:50070/webhdfs/v1/tmp/test/#{name}?user.name=hadoop&op=CREATE") 
        |> get_location(message)
    end

    defp get_location( {:ok, response}, message ) do
        {"Location", path} = List.keyfind(response.headers,"Location",0) 
        path
        |> http_location(message)
    end
    defp get_location( {:error, reason} , _), do: raise RuntimeError, message: reason

    defp http_location(path,message) do
        case HTTPoison.put(path,message,[],[]) do
            {:ok,response} ->
                response 
            {:error,reason} ->
                IO.inspect(reason, label: "ERROR - put location: ")
        end
    end
  
end
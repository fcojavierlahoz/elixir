defmodule BwKafka.Hdfs do

    def put(message) do
        name = "test-" <> Integer.to_string(:os.system_time(:millisecond))
        {:ok, response } = HTTPoison.put("http://localhost:50070/webhdfs/v1/tmp/test/#{name}?user.name=hadoop&op=CREATE") 
        {"Location", path} = List.keyfind(response.headers,"Location",0) 
        HTTPoison.put(path,message,[],[])
    end
      
end
defmodule BwKafka.Mysql do

    def insert(json_message) do
        #IO.inspect MyXQL.query!(:myxql, "SELECT NOW()").rows
        #IO.inspect(json_message["id"], label: "Insert: Id")
        MyXQL.query!(:myxql, 
            "
            INSERT INTO test.test1 (id,field1) 
            VALUES (
                #{json_message["id"]},
                #{json_message["field3"]}
                );
            "
        )
    end
  
end
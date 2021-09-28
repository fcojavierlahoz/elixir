defmodule BwKafkaTest do
  use ExUnit.Case
  doctest BwKafka

  test "greets the world" do
    assert BwKafka.hello() == :world
  end
end

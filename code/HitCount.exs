defmodule HitCount do

  def start() do
    Agent.start_link(fn -> 0 end)
  end
  
  def record_hit(agent) do
    Agent.update(agent, &(&1 + 1))
  end
  
  def get_count(agent) do
    Agent.get(agent, &(&1))
  end

end

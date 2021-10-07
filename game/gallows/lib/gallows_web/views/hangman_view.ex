defmodule GallowsWeb.HangmanView do
  use GallowsWeb, :view

  def turn(left, target) when target >= left do
    "opacity: 1"
  end 

  def turn(_left, _target) do
    "opacity: 0.1"
  end 

  def game_over?(%{ game_state: game_state}) do
    game_state in [ :won, :lost]
  end

  def new_game_button(conn) do
    button("New Game", to: Routes.hangman_path(conn, :create_game))
  end

  @responses %{
    :won          => { :success, "Yow Won!"},
    :lost         => { :danger, "You Lost!"},
    :good_guess   => { :success, "Good guess"},
    :bad_guess    => { :warning, "Bad guess"},
    :already_used => { :info, "You already guessed that"},
  }

  @responses2 %{
    :won          => "Yow Won!",
    :lost         => "You Lost!",
    :good_guess   => "Good guess",
    :bad_guess    => "Bad guess",
    :already_used => "You already guessed that",
  }

  def game_state(state) do
    @responses2[state]
    #|> alert()
  end

  defp alert(nil), do: ""

  defp alert(class, message) do
    """
    <div class="alert alert-#{class}">
      #{message}
    </div>
    """
    |> raw()
  end


  def get_letter(tally) do
    tally.letters |> Enum.join(" ")
  end

  def get_used(tally) do
    tally.used |> Enum.join(" ")
  end

  def get_result(tally) do
    tally.result |> Enum.join(" ")
  end

end

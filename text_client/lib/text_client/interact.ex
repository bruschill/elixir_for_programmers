defmodule TextClient.Interact do
  alias TextClient.{State, Player}

  def start() do
    Hangman.new_game()
    |> setup_state()
    |> Player.play()
  end

  defp setup_state(game) do
    %State{
      game_service: game,
      tally: Hangman.tally(game),
    }
  end

  def play(state) do
    # interact
    # interact
    # state = interact(state)
    # state = interact(state)
    play(state)
  end
end

defmodule GameTest do
  use ExUnit.Case

  alias Hangman.Game

  test "new game returns structure" do
    game = Game.new_game()

    assert game.turns_left == 7
    assert game.game_state == :initializing
    assert length(game.letters) > 0
  end

  test "state isn't changed for :won or :lost state" do
    for state <- [:won, :lost] do
      game = Game.new_game()
             |> Map.put(:game_state, state)

      assert { ^game } = Game.make_move(game, "x")
    end
  end

  test "first occurrence of letter isn't already used" do
    game = Game.new_game()
    { game } = Game.make_move(game, "x")

    assert game.game_state != :already_used
  end

  test "second occurrence of letter is already used" do
    game = Game.new_game()
    { game } = Game.make_move(game, "x")
    { game } = Game.make_move(game, "x")

    assert game.game_state == :already_used
  end

  test "a good guess is recognized" do
    game = Game.new_game("wiggle")
    { game } = Game.make_move(game, "w")

    assert game.game_state == :good_guess
    assert game.turns_left == 7
  end

  test "a guessed word is a won game" do
    game = Game.new_game("wiggle")
    { game } = Game.make_move(game, "w")
    { game } = Game.make_move(game, "i")
    { game } = Game.make_move(game, "g")
    { game } = Game.make_move(game, "g")
    { game } = Game.make_move(game, "l")
    { game } = Game.make_move(game, "e")

    assert game.game_state == :won
  end

  test "a bad guess is recognized" do
    game = Game.new_game("wiggle")
    { game } = Game.make_move(game, "x")

    assert game.game_state == :bad_guess
    assert game.turns_left == 6
  end

  test "a lost game is recognized" do
    game = Game.new_game("z")
    { game } = Game.make_move(game, "a")
    { game } = Game.make_move(game, "b")
    { game } = Game.make_move(game, "c")
    { game } = Game.make_move(game, "d")
    { game } = Game.make_move(game, "e")
    { game } = Game.make_move(game, "f")
    { game } = Game.make_move(game, "g")

    assert game.game_state == :lost
  end
end

extends CanvasLayer

signal start_game

func _on_start_button_pressed():
    start_game.emit(false)

func _on_start_two_player_button_pressed():
    start_game.emit(true)
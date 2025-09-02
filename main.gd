extends Node

var game_scene = preload("res://game.tscn")
var game

func start_game():
	$MainMenu.hide()
	game = game_scene.instantiate()
	get_tree().root.add_child(game)
	game.game_end.connect(end_game)
	game.reset_game()

func end_game(player_did_win: bool):
	game.queue_free()
	$EndScreen.set_end_screen_text(player_did_win)
	$EndScreen.show()

func _on_end_screen_back_to_main_menu() -> void:
	$MainMenu.show()
	$EndScreen.hide()

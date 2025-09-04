extends Node

var single_player_game_scene = preload("res://single_player_game.tscn")
var two_player_game_scene = preload("res://two_player_game.tscn")

var game

func start_game(start_two_player_game: bool):
	$MainMenu.hide()
	if start_two_player_game:
		game = two_player_game_scene.instantiate()
	else:
		game = single_player_game_scene.instantiate()

	get_tree().root.add_child(game)
	game.game_end.connect(end_game)
	game.reset_game()

func end_game(end_text: String):
	game.queue_free()
	$EndScreen.set_end_screen_text(end_text)
	$EndScreen.show()

func _on_end_screen_back_to_main_menu() -> void:
	$MainMenu.show()
	$EndScreen.hide()

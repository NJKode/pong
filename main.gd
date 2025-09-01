extends Node

var game = preload("res://game.tscn").instantiate()

func start_game():
	$MainMenu.hide()
	get_tree().root.add_child(game)

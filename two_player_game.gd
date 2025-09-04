extends Game

func _ready() -> void:
	super._ready()
	player_two = get_node("PlayerTwo")

func end_game(player_one_win: bool) -> void:
	var end_text = "Player one wins!" if player_one_win else "Player two wins!"
	game_end.emit(end_text)

extends Game

func end_game(player_did_win: bool) -> void:
	var end_text = "You win!" if player_did_win else "You lose!"
	game_end.emit(end_text)

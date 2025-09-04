extends CanvasLayer

func update_player_score(number: int) -> void:
	$PlayerScore.text = str(number)

func update_player_two_score(number: int) -> void:
	$OpponentScore.text = str(number)

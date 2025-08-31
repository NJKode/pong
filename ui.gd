extends CanvasLayer

func update_player_score(number: int) -> void:
	$PlayerScore.text = str(number)

func update_opponent_score(number: int) -> void:
	$OpponentScore.text = str(number)

extends CanvasLayer

func update_player_one_score(number: int) -> void:
	$PlayerOneScore.text = str(number)

func update_player_two_score(number: int) -> void:
	$PlayerTwoScore.text = str(number)

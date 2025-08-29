extends Area2D

var ball: Area2D

func _ready() -> void:
	ball = get_parent().get_node("Ball")

func _track_ball() -> void:
	position.y = ball.position.y


func _process(_delta: float) -> void:
	_track_ball()
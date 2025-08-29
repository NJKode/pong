extends Area2D

@export var speed = 150

var ball: Area2D

func _ready() -> void:
	ball = get_parent().get_node("Ball")

func _track_ball(delta: float) -> void:
	var y_delta = ball.position.y - position.y
	var direction = y_delta / abs(y_delta)

	position.y += direction * speed * delta

func _process(delta: float) -> void:
	_track_ball(delta)
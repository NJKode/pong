extends "res://paddle.gd"

@export var speed = 150

var ball: Area2D

func _ready() -> void:
	super._ready()
	ball = get_parent().get_node("Ball")

func _track_ball(delta: float) -> void:
	var y_delta = ball.position.y - position.y
	if (is_zero_approx(y_delta)):
		return

	var direction = y_delta / abs(y_delta)

	vertical_velocity = direction * speed
	_move(delta)

func _process(delta: float) -> void:
	_track_ball(delta)
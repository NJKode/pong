extends "res://paddle.gd"

@export var speed = 400

enum PlayerMode {SINGLE_PLAYER, PLAYER_ONE, PLAYER_TWO}

@export var player_mode = PlayerMode.SINGLE_PLAYER


func _handle_movement(delta: float) -> void:
	var direction = 0
	if (
		(
			(player_mode == PlayerMode.SINGLE_PLAYER or player_mode == PlayerMode.PLAYER_TWO)
			and Input.is_action_pressed("move_up_p2")
		) or (
			(player_mode == PlayerMode.SINGLE_PLAYER or player_mode == PlayerMode.PLAYER_ONE)
			and Input.is_action_pressed("move_up_p1")
		)
	):
		direction = -1
	elif (
		(
			(player_mode == PlayerMode.SINGLE_PLAYER or player_mode == PlayerMode.PLAYER_TWO)
			and Input.is_action_pressed("move_down_p2")
		) or (
			(player_mode == PlayerMode.SINGLE_PLAYER or player_mode == PlayerMode.PLAYER_ONE)
			and Input.is_action_pressed("move_down_p1")
		)
	):
		direction = 1

	vertical_velocity = direction * speed

	_move(delta)
	

func _process(delta: float) -> void:
	_handle_movement(delta)

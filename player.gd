extends "res://paddle.gd"

@export var speed = 400

func _handle_movement(delta: float) -> void:
    var direction = 0
    if Input.is_action_pressed("move_up"):
       direction = -1
    elif Input.is_action_pressed("move_down"):
        direction = 1

    vertical_velocity = direction * speed

    _move(delta)
    

func _process(delta: float) -> void:
    _handle_movement(delta)

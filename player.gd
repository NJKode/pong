extends Area2D

@export var speed = 400

var screen_size: Vector2

func _ready():
    screen_size = get_viewport_rect().size

func _handle_movement(delta: float) -> void:
    var velocity = Vector2.ZERO
    if Input.is_action_pressed("move_up"):
        velocity.y -= 1
    elif Input.is_action_pressed("move_down"):
        velocity.y += 1

    velocity = velocity.normalized() * speed

    var new_position = position + (velocity * delta)
    new_position = new_position.clamp((Vector2.ZERO), screen_size)
    position = new_position
    

func _process(delta: float) -> void:
    _handle_movement(delta)

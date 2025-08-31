class_name Paddle
extends Area2D

var vertical_velocity: float
var screen_size: Vector2

func _ready():
    vertical_velocity = 0
    screen_size = get_viewport_rect().size


func _move(delta: float):
    var new_y_position = position.y + (vertical_velocity * delta)
    new_y_position = clampf(new_y_position, 0, screen_size.y)
    position.y = new_y_position
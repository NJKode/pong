extends Node2D

@export var ball_speed: int = 200
@export var initial_position = Vector2(450, 300)

var ball: Area2D
var ball_velocity: Vector2
var screen_size: Vector2

var player: Paddle
var opponent: Paddle
var victory_zone_id: String
var defeat_zone_id: String
var game_reset_timer: Timer

var player_score = 0
var opponent_score = 0

func _ready() -> void:
	# get nodes
	screen_size = get_viewport_rect().size
	ball = get_node("Ball")
	player = get_node("Player")
	opponent = get_node("Opponent")
	game_reset_timer = $GameResetTimer

	var field = get_node("Field")
	victory_zone_id = field.get_node("VictoryZone").name
	defeat_zone_id = field.get_node("DefeatZone").name

	reset_game()


func reset_game() -> void:
	ball_velocity = Vector2.ZERO
	ball.position = initial_position
	game_reset_timer.start()

func _on_game_reset_timer_timeout() -> void:
	game_reset_timer.stop()
	ball_velocity = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0))
	ball_velocity = ball_velocity.normalized()


func opponent_score_point() -> void:
	opponent_score += 1
	print("Opponent score is now ", opponent_score)
	reset_game()

func score_point() -> void:
	player_score += 1
	print("Score is now ", player_score)
	reset_game()


func _handle_bounce() -> void:
	if (
		(ball.position.y <= 5.0 and ball_velocity.y < 0) or
		(ball.position.y >= screen_size.y - 5 and ball_velocity.y > 0)
	):
		ball_velocity = Vector2(ball_velocity.x, -1 * ball_velocity.y)

	# Handle player/enemy hit

	 
func _process(delta: float) -> void:
	# var horizontal_line = Vector2(1.0, 0.0)
	_handle_bounce()
		
	ball.position += ball_velocity * ball_speed * delta

func _horizontal_bounce(surface: Paddle) -> void:
	var surface_spin = surface.vertical_velocity / 1000

	ball_velocity = Vector2(
		-1 * ball_velocity.x,
		ball_velocity.y + surface_spin
	).normalized()

	
func _on_ball_area_entered(area: Area2D) -> void:
	match area.name:
		player.name, opponent.name:
			_horizontal_bounce(area)
		defeat_zone_id:
			opponent_score_point()
		victory_zone_id:
			score_point()

class_name Game extends Node2D

signal game_end

@export var ball_speed: int = 200
@export var initial_position = Vector2(450, 300)
@export var spin_coeff: int = 15
@export var score_needed_to_win: int = 10

@export var player_one: Paddle
@export var player_two: Paddle

var ball: Area2D
var ball_velocity: Vector2
var screen_size: Vector2

var victory_zone_id: String
var defeat_zone_id: String
var game_reset_timer: Timer
var ui: CanvasLayer

var player_one_score = 0
var player_two_score = 0

func _ready() -> void:
	screen_size = get_viewport_rect().size
	ball = get_node("Ball")
	game_reset_timer = $GameResetTimer
	ui = $UI

	var field = get_node("Field")
	victory_zone_id = field.get_node("VictoryZone").name
	defeat_zone_id = field.get_node("DefeatZone").name


func reset_game() -> void:
	ball_velocity = Vector2.ZERO
	ball.position = initial_position
	game_reset_timer.start()


func _on_game_reset_timer_timeout() -> void:
	game_reset_timer.stop()
	_set_initial_ball_velocity()


func _set_initial_ball_velocity() -> void:
	ball_velocity = Vector2(1, 0).rotated(randf_range(PI / -8, PI / 8))
	var go_left = randi() % 2 == 0
	if go_left:
		ball_velocity.x *= -1
	ball_velocity = ball_velocity.normalized()


func end_game(player_one_win: bool) -> void:
	var end_text = "Player one wins!" if player_one_win else "Player two wins!"
	game_end.emit(end_text)


func _player_one_score_point() -> void:
	player_one_score += 1
	ui.update_player_one_score(player_one_score)
	if player_one_score >= score_needed_to_win:
		return end_game(true)
	reset_game()


func _player_two_score_point() -> void:
	player_two_score += 1
	ui.update_player_two_score(player_two_score)
	if player_two_score >= score_needed_to_win:
		return end_game(false)
	reset_game()


func _handle_barrier_bounce() -> void:
	if (
		(ball.position.y <= 5.0 and ball_velocity.y < 0) or
		(ball.position.y >= screen_size.y - 5 and ball_velocity.y > 0)
	):
		ball_velocity = Vector2(ball_velocity.x, -1 * ball_velocity.y)


func _handle_paddle_bounce(surface: Paddle) -> void:
	var surface_spin = surface.vertical_velocity * spin_coeff / 10000
	$Hit.play()

	ball_velocity = Vector2(
		-1 * ball_velocity.x,
		ball_velocity.y + surface_spin
	).normalized()

	
func _on_ball_area_entered(area: Area2D) -> void:
	match area.name:
		player_one.name, player_two.name:
			_handle_paddle_bounce(area)
		defeat_zone_id:
			_player_two_score_point()
		victory_zone_id:
			_player_one_score_point()


func _process(delta: float) -> void:
	_handle_barrier_bounce()
		
	ball.position += ball_velocity * ball_speed * delta

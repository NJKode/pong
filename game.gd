extends Node2D

signal game_end

@export var ball_speed: int = 200
@export var initial_position = Vector2(450, 300)
@export var spin_coeff: int = 15
@export var score_needed_to_win: int = 10

var ball: Area2D
var ball_velocity: Vector2
var screen_size: Vector2

var player: Paddle
var opponent: Paddle
var victory_zone_id: String
var defeat_zone_id: String
var game_reset_timer: Timer
var ui: CanvasLayer

var player_score = 0
var opponent_score = 0

func _ready() -> void:
	# get nodes
	screen_size = get_viewport_rect().size
	ball = get_node("Ball")
	player = get_node("Player")
	opponent = get_node("Opponent")
	game_reset_timer = $GameResetTimer
	ui = $UI

	var field = get_node("Field")
	victory_zone_id = field.get_node("VictoryZone").name
	defeat_zone_id = field.get_node("DefeatZone").name

	# reset_game()


func reset_game() -> void:
	ball_velocity = Vector2.ZERO
	ball.position = initial_position
	game_reset_timer.start()


func _on_game_reset_timer_timeout() -> void:
	game_reset_timer.stop()
	_set_initial_ball_velocity()


func _set_initial_ball_velocity() -> void:
	ball_velocity = Vector2(1, 0).rotated(randf_range(PI / -4, PI / 4))
	var go_left = randi() % 2 == 0
	if go_left:
		ball_velocity.x *= -1
	ball_velocity = ball_velocity.normalized()

func end_game(player_did_win: bool) -> void:
	game_end.emit(player_did_win)

func opponent_score_point() -> void:
	opponent_score += 1
	ui.update_opponent_score(opponent_score)
	if opponent_score >= score_needed_to_win:
		return end_game(false)
	reset_game()

func score_point() -> void:
	player_score += 1
	ui.update_player_score(player_score)
	if player_score >= score_needed_to_win:
		return end_game(true)
	reset_game()


func _barrier_bounce() -> void:
	if (
		(ball.position.y <= 5.0 and ball_velocity.y < 0) or
		(ball.position.y >= screen_size.y - 5 and ball_velocity.y > 0)
	):
		ball_velocity = Vector2(ball_velocity.x, -1 * ball_velocity.y)

	 
func _process(delta: float) -> void:
	_barrier_bounce()
		
	ball.position += ball_velocity * ball_speed * delta


func _paddle_bounce(surface: Paddle) -> void:
	var surface_spin = surface.vertical_velocity * spin_coeff / 10000
	$Hit.play()

	ball_velocity = Vector2(
		-1 * ball_velocity.x,
		ball_velocity.y + surface_spin
	).normalized()

	
func _on_ball_area_entered(area: Area2D) -> void:
	match area.name:
		player.name, opponent.name:
			_paddle_bounce(area)
		defeat_zone_id:
			opponent_score_point()
		victory_zone_id:
			score_point()

extends CanvasLayer

signal back_to_main_menu

func set_end_screen_text(player_did_win: bool) -> void:
    $HeaderText.text = "You Win!" if player_did_win else "You Lose!"

func _on_main_menu_button_pressed() -> void:
    back_to_main_menu.emit()

extends CanvasLayer

signal back_to_main_menu

func set_end_screen_text(end_text: String) -> void:
    $HeaderText.text = end_text

func _on_main_menu_button_pressed() -> void:
    back_to_main_menu.emit()

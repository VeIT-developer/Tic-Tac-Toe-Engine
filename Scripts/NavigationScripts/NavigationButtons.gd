extends HBoxContainer

signal start_game()
signal start_error()
@onready var button_panel: Panel = $"../.."
@onready var game_preparing_menu: VBoxContainer = $".."

func _on_start_game_pressed():
	if game_preparing_menu.win_length > game_preparing_menu.board_size:
		start_error.emit()
	else:
		start_game.emit()


func _on_back_pressed():
	button_panel.change_panel("Menu")

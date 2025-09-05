extends Panel

@onready var game_preparing_menu: VBoxContainer = $".."

func _on_line_edit_text_changed(new_text):
	match new_text:
		"3":
			game_preparing_menu.win_length = 3
		"4":
			game_preparing_menu.win_length = 4
		"5":
			game_preparing_menu.win_length = 5
		_:
			game_preparing_menu.win_length = 3

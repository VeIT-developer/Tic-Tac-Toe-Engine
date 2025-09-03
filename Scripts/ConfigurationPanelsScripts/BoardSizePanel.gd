extends Panel

@onready var game_preparing_menu: VBoxContainer = $".."

func _on_option_button_item_selected(index):
	match index:
		0:
			game_preparing_menu.board_size = 3
		1:
			game_preparing_menu.board_size = 4
		2:
			game_preparing_menu.board_size = 5

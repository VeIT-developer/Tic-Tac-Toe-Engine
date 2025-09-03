extends Panel

@onready var gamemode_button: OptionButton = $"../GamemodePanel/GamemodeButton"
@onready var move_button: OptionButton = $MoveButton
@onready var game_preparing_menu: VBoxContainer = $".."
func _on_option_button_item_selected(index):
	if gamemode_button.selected == 1:
		move_button.set_item_disabled(1, true)
		move_button.set_item_disabled(2, true)
		game_preparing_menu.current_first_move = BoardManager.FIRST_MOVE.RANDOM
		move_button.selected = 0
	else:
		move_button.set_item_disabled(1, false)
		move_button.set_item_disabled(2, false)


func _on_move_button_item_selected(index):
	match index:
		0:
			game_preparing_menu.current_first_move = BoardManager.FIRST_MOVE.RANDOM
		1:
			game_preparing_menu.current_first_move = BoardManager.FIRST_MOVE.ENEMY
		2:
			game_preparing_menu.current_first_move = BoardManager.FIRST_MOVE.YOU

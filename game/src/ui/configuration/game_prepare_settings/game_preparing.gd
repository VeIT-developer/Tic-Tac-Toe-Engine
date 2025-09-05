extends VBoxContainer

@onready var start_game_button: Button = $NavigationButtons/StartGame

# TODO: Сделать все преднастройки через синглтоны
var current_mode := BoardManager.GAMEMODE.PvE
var current_first_move := BoardManager.FIRST_MOVE.RANDOM
var difficulty: int = 0
var board_size: int = 3
var win_length: int = 3

func _on_navigation_buttons_start_game():
	BoardManager.current_mode = current_mode
	BoardManager.current_first_move = current_first_move
	BoardManager.board_size = board_size
	BoardManager.win_length = win_length
	BoardManager.prepare_board.emit()

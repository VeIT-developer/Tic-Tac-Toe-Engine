extends Control

@onready var message_label: Label = $MessageLabel

func _ready():
	BoardManager.move_accepted.connect(_on_move_accepted)
	BoardManager.prepare_board.connect(_on_prepare_board)
func _on_move_accepted():
	match BoardManager.game_state():
		"Draw":
			message_label.text = "Ничья"
		"Crosses_win":
			message_label.text = "Крестики победили!"
		"Noughts_win":
			message_label.text = "Нолики победили!"
		_:
			message_label.text = ""

func _on_prepare_board():
	message_label.text = ""

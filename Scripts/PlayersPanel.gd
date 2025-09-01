extends HBoxContainer

@onready var crosses_player_label: Label = $CrossesPlayer
@onready var move_label: Label = $Move
@onready var noughts_player_label: Label = $NoughtsPlayer

func _ready():
	BoardManager.prepare_board.connect(_on_prepare_board)
	BoardManager.move_accepted.connect(_on_move_accepted)

func _on_prepare_board():
	if BoardManager.current_mode != BoardManager.GAMEMODE.PvP_PC:
		match BoardManager.player:
			true:
				crosses_player_label.text = "Вы"
				noughts_player_label.text = "ИИ"
			false:
				crosses_player_label.text = "ИИ"
				noughts_player_label.text = "Вы"
	else:
		crosses_player_label.text = "Вы"
		noughts_player_label.text = "Вы"
	_change_move_label()

func _on_move_accepted():
	_change_move_label()

func _change_move_label():
	match BoardManager.turn:
		true:
			move_label.text = "<"
		false:
			move_label.text = ">"

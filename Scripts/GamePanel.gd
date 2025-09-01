extends Control

@onready var board = $Board 
@onready var players_panel = $PlayersPanel

func _ready():
	create_board()
	BoardManager.prepare_board.connect(_on_prepare_board)
	BoardManager.move_accepted.connect(_on_move_accepted)
	get_tree().create_timer(0.1)
	
## Генерирует доску
func create_board():
	
	for child in board.get_children():
		child.queue_free()
	
	board.columns = BoardManager.board_size
	
	for i in range(int(pow(BoardManager.board_size, 2))):
		var button = Button.new()
		button.name = "Cell"
		button.add_theme_font_size_override("font_size", 60)
		button.custom_minimum_size = Vector2(100, 100)
		button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		button.size_flags_vertical = Control.SIZE_EXPAND_FILL
		button.add_theme_stylebox_override("focus", StyleBoxEmpty.new())
		button.pressed.connect(_on_button_pressed.bind(i))
		board.add_child(button)

## Выводит позицию на доску
func draw_position():
	var total_cells = BoardManager.board_size * BoardManager.board_size
	for bit in range(total_cells):
		# Инвертируем порядок битов для правильного отображения
		var display_bit = total_cells - 1 - bit
		var button = board.get_child(display_bit)
		
		if (BoardManager.crosses_board & (1 << bit)) != 0:
			button.text = "X"
		elif (BoardManager.noughts_board & (1 << bit)) != 0:
			button.text = "O"
		else:
			button.text = ""
			
func _on_button_pressed(button_index: int):
	print("Нажата клетка ", 1 << int((pow(BoardManager.board_size, 2) - button_index)))
	var bit_position = int(pow(BoardManager.board_size, 2)) - 1 - button_index
	BoardManager.accept_move(bit_position)
#	BoardManager.accept_move(1 << int((pow(BoardManager.board_size, 2) - button_index)))
	

func _on_prepare_board():
	create_board()

func _on_move_accepted():
	print("Move accepted")
	draw_position()

#
#func _on_timer_timeout():
#	draw_position()

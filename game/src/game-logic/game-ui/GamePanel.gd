extends Control

@onready var board = $Board 
@onready var players_panel = $PlayersPanel
#@onready var buttons_normal_style: StyleBoxFlat = load("res://Themes/Buttons_themes/Buttons_normal_style_box_flat.tres")
#@onready var buttons_hover_style: StyleBoxFlat = load("res://Themes/Buttons_themes/Buttons_hover_style_box_flat.tres")
#@onready var buttons_pressed_style: StyleBoxFlat = load("res://Themes/Buttons_themes/Buttons_pressed_style_box_flat.tres")
func _ready():
	create_board()
	BoardManager.prepare_board.connect(_on_prepare_board)
	BoardManager.move_accepted.connect(_on_move_accepted)
	get_tree().create_timer(0.1)
	
## Генерирует доску
func create_board():
	
#	Удаляем все клетки доски, для создания новых
	for child in board.get_children():
		child.queue_free()
	
	board.columns = BoardManager.board_size
	
	for i in range(int(pow(BoardManager.board_size, 2))):
		var button = Button.new()
#		Задаем имя
		button.name = "Cell"
#		Задаем размер шрифта
		button.add_theme_font_size_override("font_size", 60)
#		Задаем минимальный размер
		button.custom_minimum_size = Vector2(100, 100)
#		Задаем флаги
		button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		button.size_flags_vertical = Control.SIZE_EXPAND_FILL
		
#		button.add_theme_stylebox_override("normal", buttons_normal_style)
#		button.add_theme_stylebox_override("hover", buttons_hover_style)
#		button.add_theme_stylebox_override("pressed", buttons_pressed_style)
#		Задаем стиль
		button.add_theme_stylebox_override("focus", StyleBoxEmpty.new())
#		Подключаем к кнопкам доски сигнал с их индексом в аргументаз
		button.pressed.connect(_on_button_pressed.bind(i))
#		Добавляем в сцену
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
	var bit_position = int(pow(BoardManager.board_size, 2)) - 1 - button_index
	BoardManager.accept_move(bit_position)
	

func _on_prepare_board():
	create_board()

func _on_move_accepted():
	draw_position()

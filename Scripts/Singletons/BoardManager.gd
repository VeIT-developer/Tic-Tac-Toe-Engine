extends Node

signal prepare_board
signal move_accepted

@onready var win_patterns: Array = calculate_win_patterns()
@onready var crosses_board: int = 0
@onready var noughts_board: int = 0
@onready var game_started: bool = false
@onready var turn: bool = true
@onready var player: bool = true

enum GAMEMODE {
	PvP_PC,
	PvE,
	EvE
}

enum FIRST_MOVE {
	RANDOM,
	ENEMY,
	YOU
}

var difficulty: int = 0
var board_size: int = 5
var win_length: int = 4
var current_mode: GAMEMODE
var current_first_move: FIRST_MOVE

func _ready():
	print(noughts_board)
	print(turn)
	prepare_board.connect(_on_prepare_board)
func calculate_win_patterns() -> Array:
	
	var patterns: Array = []
	
	if win_length > board_size:
		return []
	
	#Создание горизонтальных выигрышных комбинаций
	for row in range(board_size):
		for start_col in range(board_size - win_length + 1):
			var pattern: int = 0
			for i in range(win_length):
				var pos := row * board_size + (start_col + i)
				pattern |= 1 << pos
			patterns.append(pattern)
			
	#Создание вертикальных выигрышных комбинаций
	for col in range(board_size):
		for start_row in range(board_size - win_length + 1):
			var pattern: int = 0
			for i in range(win_length):
				var pos := (start_row + i) * board_size + col
				pattern |= 1 << pos
			patterns.append(pattern)
		
	#Создание диагоналей слева верх вниз справа
	for start_row in range(board_size - win_length + 1):
		for start_col in range(board_size - win_length + 1):
			var pattern: int = 0
			for i in range(win_length):
				var pos := ((start_row + i) * board_size) + (start_col + i)
				pattern |= 1 << pos
			patterns.append(pattern)
	
	#Создание диагоналей слева вниз справа вверх
	for start_row in range(board_size - win_length + 1):
		for start_col in range(win_length - 1, board_size):
			var pattern: int = 0
			for i in range(win_length):
				var pos := ((start_row + i) * board_size) + (start_col - i)
				pattern |= 1 << pos
			patterns.append(pattern)
	return patterns

func bitboard_to_board(bitboard: int):
	var bit_array: Array = []
	var result: String = ""
	var transfer_counter: int = 0
	for bit in range(pow(board_size, 2) - 1, -1, -1):
		if (bitboard >> bit) & 1 == 1:
			result += "1"
			transfer_counter += 1
		else:
			result += "."
			transfer_counter += 1
		result += " "
		if transfer_counter == board_size:
			result += "\n"
			transfer_counter = 0
	return result
	
func is_game_over() -> bool:
	return game_state() != "Continue"
	
func is_win(board: int) -> bool:
	for pattern in win_patterns:
		if (board & pattern) == pattern:
			return true
	return false
	
func is_draw(crosses_board: int, noughts_board: int):
	return (crosses_board | noughts_board) == 0b111111111
	
func game_state() -> String:
	if is_win(crosses_board):
		return "Crosses_win"
	elif is_win(noughts_board):
		return "Noughts_win"
	elif is_draw(crosses_board, noughts_board):
		return "Draw"
	else:
		return "Continue"

func count_bits(n: int) -> int:
	var count = 0
	while n != 0:
		count += n & 1
		n >>= 1
	return count 



func make_a_move(bit: int):
	print("Бит: ", bit)
	if current_mode != GAMEMODE.PvP_PC:
		match turn:
			true:
				crosses_board |= (1 << bit)
				print(crosses_board)
			false:
				noughts_board |= (1 << bit)
				print(noughts_board)
	else:
		match turn:
			true:
				crosses_board |= (1 << bit)
				print(crosses_board)
			false:
				noughts_board |= (1 << bit)
				print(noughts_board)
	turn = not turn
	print("Ход сделан")
	move_accepted.emit()
	if turn != player and current_mode == GAMEMODE.PvE:
		var best_move = MaxArtificialIntelligence.find_best_move(crosses_board, noughts_board, not player, difficulty)
		print("Лучший ход: ", best_move)
		accept_move(best_move)
	
func accept_move(bit: int):
	
	if not game_started:
		push_warning("Игра не начата")
		return false
		
	if is_game_over():
		push_warning("Игра закончена")
		return false
	if current_mode == GAMEMODE.PvE and turn != player:
		make_a_move(bit)
		return true
	if turn != player and current_mode != GAMEMODE.PvP_PC:
		push_warning("Ход другого игрока")
		return false
		
	if (crosses_board | noughts_board) & (1 << bit):
		push_warning("Клетка уже занята")
		return false
#	move_accepted.emit()
	make_a_move(bit)
	return true

func _on_prepare_board():
	print("Первый ход: ", current_first_move)
	win_patterns = calculate_win_patterns()
#	match current_first_move:
#		FIRST_MOVE.RANDOM:
#			player = true if randf() <= 0.5 else false
#			turn = true if randf() <= 0.5 else false
#		FIRST_MOVE.ENEMY:
#			player = true if randf() <= 0.5 else false
#			turn = not player
#		FIRST_MOVE.YOU:
#			player = true if randf() <= 0.5 else false
#			turn = player
	if current_first_move == FIRST_MOVE.RANDOM:
		player = randf() < 0.5
		turn = randf() < 0.5
	elif current_first_move == FIRST_MOVE.ENEMY:
		player = randf() < 0.5
		turn = not player
	elif current_first_move == FIRST_MOVE.YOU:
		player = randf() < 0.5
		turn = player
	else:
		push_error("Неизвестный режим первого хода: ", current_first_move)
	game_started = true
	crosses_board = 0
	noughts_board = 0
	print("Подготовка игры...")
	await get_tree().create_timer(0.1).timeout
	if turn != player and current_mode == GAMEMODE.PvE:
		var best_move = MaxArtificialIntelligence.find_best_move(crosses_board, noughts_board, not player, 2)
		print("Лучший ход: ", best_move)
		accept_move(best_move)

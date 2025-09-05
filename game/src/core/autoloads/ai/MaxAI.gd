class_name MaxAI
extends Node
## Движок способный играть в Крестики-нолики, использует алгоритм Минимакс с альфа бета отсечением и Битборды, что позволяет ему быть очень оптимизированным
## Beta. Ранняя версия, способна адаптироваться к любому размеру доски

## Функция считает оценку позиции по контролю
func heuristic_evaluate(crosses_board: int, noughts_board: int):
	var score: float = 0.0
	
	for pattern in BoardManager.win_patterns:
		
		var x = BoardManager.count_bits(crosses_board & pattern)
		var o = BoardManager.count_bits(noughts_board & pattern)
		
		if x > 0 and o == 0:
			score += pow(x, 2)
		elif o > 0 and x == 0:
			score -= pow(o, 2)
	return score

## Общая оценка позиции
func evaluate(depth: int, crosses_board: int, noughts_board: int):
	match BoardManager.game_state():
		"Crosses_win":
			return 100 - depth
		"Noughts_win":
			return -100 + depth
		"Draw":
			return 0
		"Continue":
			return heuristic_evaluate(crosses_board, noughts_board)

## Симулирует ход, и возвращает копию доски
func simulate_move(board: int, move: int) -> int:
	return board | move

## Счетчик считает сколько позиций проверил минимакс
var check_count: int = 0

## Минимакс оценивает ход с помощью рекурсивного алгоритма
func minimax(crosses_board: int, noughts_board: int, depth: int, is_maximizing: bool, alpha: float, beta: float) -> float:
	check_count += 1
	if BoardManager.is_game_over() or depth == 0:
		return evaluate(depth, crosses_board, noughts_board)
#	if evaluate(depth, crosses_board, noughts_board):
#		return evaluate(depth, crosses_board, noughts_board)

	if is_maximizing:
		var max_eval := -INF

		for cell in range(int(pow(BoardManager.board_size, 2))):
			var mask := 1 << cell
		
			if (crosses_board | noughts_board) & mask == 0:
				var simulated_move: int = simulate_move(crosses_board, mask)
				var eval := minimax(simulated_move, noughts_board, depth - 1, false, alpha, beta)
				
				max_eval = max(max_eval, eval)
				alpha = max(alpha, eval)
				
				if beta <= alpha:
					break
		return max_eval
	else:
		var min_eval := INF

		for cell in range(int(pow(BoardManager.board_size, 2))):
			var mask := 1 << cell
		
			if (crosses_board | noughts_board) & mask == 0:
				var simulated_move: int = simulate_move(noughts_board, mask)
				var eval := minimax(crosses_board, simulated_move, depth - 1, true, alpha, beta)
				
				min_eval = min(min_eval, eval)
				beta = min(beta, eval)
				
				if beta <= alpha:
					break
		return min_eval

## Находит лучший ход на основе оценки Минимакса
func find_best_move(crosses_board: int, noughts_board: int, is_maximazing: bool, depth: int) -> int:
	
	var best_move: int = -1
	var best_value: float = -INF if is_maximazing else INF
	var candidates = []
	
	var start_time: float = Time.get_ticks_msec()
	
	for cell in range(int(pow(BoardManager.board_size, 2))):
		var mask = 1 << cell
		if (crosses_board | noughts_board) & mask != 0:
			continue
			
		var new_crosses = simulate_move(crosses_board, mask) if is_maximazing else crosses_board
		var new_noughts = simulate_move(noughts_board, mask) if not is_maximazing else noughts_board

		var current_value = minimax(new_crosses, new_noughts, depth, not is_maximazing, -INF, INF)
		
		if (is_maximazing and current_value > best_value) or (not is_maximazing and current_value < best_value):
			best_value = current_value
			best_move = cell
			candidates = [cell]
		elif current_value == best_value:
			candidates.append(cell)
#		if Time.get_ticks_msec() - start_time > 1000:
#			break
	var result_time: float = Time.get_ticks_msec() - start_time
#	print("Лучшие ходы: ", candidates)
#	print("Лучшая оценка: ", best_value)
#	print("Проверено позиций: ", check_count)
#	print("Время поиска: ", float(result_time))
	check_count = 0
	
	if candidates.size() == 0:
		return -1
	elif candidates.size() == 1:
		return candidates[0]
	else:
		return candidates[randi_range(0, candidates.size() - 1)]
		
		
		

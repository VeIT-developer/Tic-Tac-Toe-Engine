class_name Board
extends GridContainer

#func _ready():
#	create_board()
	
#func _notification(what):
#	if get_child_count() == 0:
#		return
#	if what == NOTIFICATION_RESIZED:
#		_scale_grid()
#
#func _scale_grid():
#	var container_size = size
#	var grid_size = custom_minimum_size
#
#	var scale_factor = max(
#		container_size.x / grid_size.x,
#		container_size.y / grid_size.y
#	)
#
#	scale = Vector2(scale_factor, scale_factor)
#	position = (container_size - grid_size * scale_factor) / 2
#func _update_button_size():
#
#	var available_width = size.x - (columns - 1) * get_theme_constant("h_separation")
#	var available_height = size.y - (get_child_count() / columns - 1) * get_theme_constant("v_separation")
#
#	var square_size = min(
#		available_width / columns,
#		available_height / (get_child_count() / columns)
#	)
#
#	for button in get_children():
#		if button is Button:
#			button.custom_minimum_size = Vector2(square_size, square_size)
#			button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
#			button.size_flags_vertical = Control.SIZE_EXPAND_FILL
#
#func create_board():
#
#	for child in get_children():
#		child.queue_free()
#
#	columns = BoardManager.board_size
#
#	for i in range(int(pow(BoardManager.board_size, 2))):
#		var button = Button.new()
##		button.texture_normal = preload("res://Sprites/empty_cell.png")
##		button.stretch_mode = TextureButton.STRETCH_KEEP_ASPECT_CENTERED
#		button.custom_minimum_size = Vector2(100, 100)
#		button.name = "Cell"
#		button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
#		button.size_flags_vertical = Control.SIZE_EXPAND_FILL
#		button.pressed.connect(_on_button_pressed.bind(i))
#		add_child(button)
#func _on_button_pressed(button_index: int):
#	print("Нажата клетка ", button_index)

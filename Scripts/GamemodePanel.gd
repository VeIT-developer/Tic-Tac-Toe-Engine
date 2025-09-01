extends Panel

@onready var difficulty_panel: Control = $DifficultyPanel
@onready var difficulty_option_button: OptionButton = $DifficultyPanel/OptionButton
@onready var game_preparing_menu: VBoxContainer = $".."

func _ready():
	switch_difficulty_panel(difficulty_option_button.selected)

func switch_difficulty_panel(index: int):
	print("Переключить панель выбора сложности")
	if index == 0:
		difficulty_panel.visible = true
		custom_minimum_size.y = 115
	else:
		difficulty_panel.visible = false
		custom_minimum_size.y = 60

# Принимаем выбор из списка и меняем параметры игры
func _on_gamemode_button_item_selected(index):
	match index:
		0:
			game_preparing_menu.current_mode = BoardManager.GAMEMODE.PvE
		1:
			game_preparing_menu.current_mode = BoardManager.GAMEMODE.PvP_PC
		2:
			game_preparing_menu.current_mode = BoardManager.GAMEMODE.EvE
	switch_difficulty_panel(index)



func _on_option_button_item_selected(index):
	match index:
		0:
			game_preparing_menu.difficulty = 0
		1:
			game_preparing_menu.difficulty = 1
		2:
			game_preparing_menu.difficulty = 2

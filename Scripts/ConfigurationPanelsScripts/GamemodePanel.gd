extends Panel

signal game_setting

func _on_gamemode_button_item_selected(index):
	match index:
		0:
			GlobalSettings.change_theme_mode("bright")
		1:
			GlobalSettings.change_theme_mode("dark")


func _on_option_button_item_selected(index):


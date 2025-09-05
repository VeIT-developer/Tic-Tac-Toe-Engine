extends Panel

func _on_theme_button_item_selected(index):
	match index:
		0:
			GlobalSettings.change_theme_mode("bright")	
		1:
			GlobalSettings.change_theme_mode("dark")

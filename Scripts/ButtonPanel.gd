extends Panel

func change_panel(panel_name: String):
	for child in get_children():
		if child.name != panel_name:
			child.visible = false
		else:
			child.visible = true

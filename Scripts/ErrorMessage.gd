extends Label

func _on_navigation_buttons_start_error():
	visible = true
	await  get_tree().create_timer(3).timeout
	visible = false

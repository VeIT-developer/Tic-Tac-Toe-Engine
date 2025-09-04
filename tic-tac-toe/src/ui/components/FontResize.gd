class_name FontResize
extends Node

func _on_viewport_resized():
	var font = SystemFont.new()
	font.size = int(16 * (get_viewport()).size.x / 1024.0)
	
	
	get_parent().add_font_override("font", font)
	

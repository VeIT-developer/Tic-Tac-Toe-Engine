extends HBoxContainer

@onready var button_panel: Panel = $"../.."

func _on_back_pressed():
	button_panel.change_panel("Menu")

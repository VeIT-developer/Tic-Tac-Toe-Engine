extends MarginContainer

@onready var button_panel: Panel = $"../.."

func _on_settings_pressed():
	button_panel.change_panel("Settings")

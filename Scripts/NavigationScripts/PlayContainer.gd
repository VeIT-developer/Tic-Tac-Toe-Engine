extends MarginContainer

@onready var button_panel: Panel = $"../.."

func _on_play_pressed():
	button_panel.change_panel("GamePreparing")

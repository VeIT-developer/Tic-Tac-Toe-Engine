extends Button

@onready var button_panel: Panel = $"../../.."

func _on_pressed():
	button_panel.change_panel("GamePreparing")

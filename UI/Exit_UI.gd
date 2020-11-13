extends PopupPanel

signal reset

func _on_Resume_pressed():
	self.visible = false


func _on_Restart_pressed():
	emit_signal("reset")
	self.visible = false


func _on_Exit_pressed():
	get_tree().change_scene_to(load("res://MainMenu/MainMenu/MainMenu.tscn"))

func _set(property, value):
	match property:
		"visible":
			visible = value
			popup_exclusive = !value

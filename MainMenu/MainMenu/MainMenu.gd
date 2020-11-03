extends PanelContainer

onready var levelSelectScene = preload("res://MainMenu/LevelSelect/LevelSelect.tscn")

func _on_LevelSelect_pressed():
	if not get_tree().change_scene_to(levelSelectScene) == OK:
		printerr("Error loading level select scene.")

func _on_Options_pressed():
	$OptionsPopup.popup_centered()


func _on_Quit_pressed():
	get_tree().quit()


func _on_Done_pressed():
	$OptionsPopup.hide()

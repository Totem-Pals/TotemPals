extends PopupPanel


signal reset

func _on_Restart_pressed():
	emit_signal("reset")


func _on_BackToMenu_pressed():
	get_tree().change_scene_to(load("res://MainMenu/MainMenu/MainMenu.tscn"))


func _on_NextLevel_pressed():
	for i in range(LevelManager.levels.size()):
		
		if get_parent().get_parent().filename == LevelManager.levels[i].resource_path:
			if  i + 1 >= LevelManager.levels.size():
				return
			get_tree().change_scene_to(LevelManager.levels[i+1])
			return

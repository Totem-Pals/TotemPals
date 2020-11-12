extends PanelContainer

export(Array) var levels
onready var levelSelectButton = preload("res://MainMenu/LevelSelect/levelSelectButton.tscn")
onready var levelButtonContainer = get_node("MarginContainer/ScrollContainer/LevelButtonContainer")

func _ready():
	LevelManager.load_game()
	print(LevelManager.availableLevels)
	for i in range(levels.size()):
		if i > LevelManager.availableLevels:
			return
		
		var newBtn = levelSelectButton.instance()
		newBtn.text = String(i)
		
		levelButtonContainer.add_child(newBtn)
		newBtn.connect("pressed", self, "_on_level_select_button_pressed", [i])

func _on_level_select_button_pressed(var btn_id : int):
	# Change scene
	if levels[btn_id] == null:
		printerr("Empty level selected!")
		return
	
	if not get_tree().change_scene_to(levels[btn_id]) == OK:
		printerr("Error loding scene from level select!")
	
	LevelManager.currentLevelIndex = btn_id


func _on_UnlockAllLevels_pressed():
	LevelManager.levelsComplete = levels.size()
	LevelManager.save_game()
	get_tree().change_scene_to(load("res://MainMenu/MainMenu/MainMenu.tscn"))


func _on_Back_pressed():
	get_tree().change_scene_to(load("res://MainMenu/MainMenu/MainMenu.tscn"))


func _on_ResetLevels_pressed():
	LevelManager.levelsComplete = -1
	LevelManager.save_game()
	get_tree().change_scene_to(load("res://MainMenu/MainMenu/MainMenu.tscn"))

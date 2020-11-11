extends PanelContainer

export(Array) var levels
onready var levelSelectButton = preload("res://MainMenu/LevelSelect/levelSelectButton.tscn")

func _ready():
	LevelManager.load_game()
	
	for i in range(levels.size()):
		if i > LevelManager.availableLevels:
			return
		
		var newBtn = levelSelectButton.instance()
		newBtn.text = String(i)
		
		$ScrollContainer/LevelButtonContainer.add_child(newBtn)
		newBtn.connect("pressed", self, "_on_level_select_button_pressed", [i])

func _on_level_select_button_pressed(var btn_id : int):
	# Change scene
	if levels[btn_id] == null:
		printerr("Empty level selected!")
		return
	
	if not get_tree().change_scene_to(levels[btn_id]) == OK:
		printerr("Error loding scene from level select!")
	
	LevelManager.currentLevelIndex = btn_id

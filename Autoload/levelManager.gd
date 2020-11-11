extends Node

var currentLevelIndex : int = 0
var levelsComplete : int = 0
var availableLevels : int = 0 setget ,_get_available_levels

func level_completed():
	if currentLevelIndex > levelsComplete:
		levelsComplete = currentLevelIndex
	
	save_game()

func _get_available_levels() -> int:
	return levelsComplete + 1

func save_game():
	var file = File.new()
	file.open("res://saveFile.dat", File.WRITE)
	file.store_line(to_json({"levels_complete" : levelsComplete}))
	file.close()


func load_game():
	var file = File.new()
	if not file.open("res://saveFile.dat", File.READ) == OK:
		levelsComplete = -1
		return
	
	levelsComplete = parse_json(file.get_line())["levels_complete"]
	file.close()

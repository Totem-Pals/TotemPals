# most code from Heartbeast on youtube
extends Area2D

onready var levelSelectScreen = "res://MainMenu/LevelSelect/LevelSelect.tscn"


func _on_LevelGate_body_entered(body):
	LevelManager.level_completed()
	get_tree().change_scene_to(load(levelSelectScreen))

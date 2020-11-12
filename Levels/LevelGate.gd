# most code from Heartbeast on youtube
extends Area2D

onready var levelSelectScreen = "res://MainMenu/LevelSelect/LevelSelect.tscn"

signal levelComplete

func _on_LevelGate_body_entered(body):
	if(body.is_in_group("Player")):
		LevelManager.level_completed()
		emit_signal("levelComplete")

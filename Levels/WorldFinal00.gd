extends Node2D


signal RespawnHappened

onready var exitUI = get_node("CanvasLayer/Exit_UI")
onready var levelCompleteUI = get_node("CanvasLayer/LevelCompleteUI")

func _ready():
	exitUI.connect("reset", self, "reset")
	levelCompleteUI.connect("reset", self, "reset")
	connect_player_kill()

func listeningForRespawn():
	emit_signal("RespawnHappened")

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		exitUI.popup_centered()

func reset():
	get_tree().change_scene_to(load(self.filename))

func _on_LevelGate_levelComplete():
	levelCompleteUI.popup_centered()

func connect_player_kill(var player = get_node("Player")):
	$CanvasLayer/Exit_UI.connect("kill_player", player, "on_death")

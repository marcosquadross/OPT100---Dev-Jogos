extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$LabelScore.text = "Score: %04d" % gc.score

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://level/credits.tscn");
	#get_tree().call_deferred("change_scene_to_file", "res://level_exit/level_clear.tscn")

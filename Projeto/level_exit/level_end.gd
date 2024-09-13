extends Area2D
class_name level_end


func _on_body_entered(body):
	# load next level
	get_tree().change_scene_to_file("res://level/level2.tscn");
	# get_tree().call_deferred("change_scene_to_file", "res://level_exit/level_clear.tscn")

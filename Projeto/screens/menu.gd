extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://level/level1.tscn");


func _on_instructions_button_pressed():
	get_tree().change_scene_to_file("res://screens/instructions.tscn")


func _on_credits_button_pressed():
	pass # Replace with function body.


func _on_quit_button_pressed():
	get_tree().quit()

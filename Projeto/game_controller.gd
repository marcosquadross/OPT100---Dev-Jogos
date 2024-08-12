extends Node
class_name Gamecontroller

var _label_item: LabelItems = null

var score: int = 0:
	get:
		return score
	set(value):
		score = value


func _ready() -> void:
	_label_item = $/root/World/CanvasLayerHud/LabelScore

func update_hud_items(value: int) -> void:
	_label_item.update_value(value)
	score = value

extends Area2D
class_name ItemCollector

var _total_items: int = 0
@onready var player: PlayerBot = get_node("/root/World/PlayerBot")
var power_up_time = 10.0
signal item_collected(item: Item)

func _on_area_entered(item) -> void:
	print(item.name)
	if item is Item:
		item_collected.emit(item)
		_total_items += item.get_value()
		gc.update_hud_items(_total_items)
	elif item is KeyItem:
		player.has_key = true
		item.get_key()
	else:
		item.has_collided()	
		print("Here")


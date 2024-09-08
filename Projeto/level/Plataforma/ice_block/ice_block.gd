extends AnimatableBody2D

@export var slide_factor := 40.0 
var player_velocity := Vector2.ZERO  

func _ready():
	set_physics_process(true)

func has_collided_with(collider: CharacterBody2D):
	if collider.is_in_group("Player"):
		player_velocity = collider.velocity

		if collider.scale.x > 0:
			player_velocity.x = slide_factor 
		else:
			player_velocity.x = -slide_factor  

		collider.velocity = player_velocity
 

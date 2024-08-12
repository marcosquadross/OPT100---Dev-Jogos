extends CharacterBody2D
class_name PlayerBot

const SPEED: float = 100
const ACCELERATION: float = 800
const FRICTION: float = 900
const JUMP_VELOCITY: float = -1400
const JUMP_VELOCITY_MIN: float = JUMP_VELOCITY/3
const MAX_JUMP_HOLD: int = 2000
const DOUBLE_JUMP_FORCE: int = 500

@onready var _animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
var jump_time: float = 0
var _gravity = 980*2
var _direction = 1
var _is_double_jump: bool = false
var _start_posisition: Vector2
var _last_checkpoint = 1
var double_jump_power_up: bool = true

func _ready():
	_start_posisition = position;

# override
func _process(delta: float) -> void:
	var weapon_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if not is_on_floor():
		velocity.y += _gravity * delta
		 # velocity.x += _gravity * delta # vento
	#else:
	#	_is_double_jump = false
	var input: float = Input.get_axis("ui_left", "ui_right")
	if Input.is_action_just_pressed("jump"):
		jump_time = Time.get_ticks_msec()
	if Input.is_action_just_released("jump"):
		if is_on_floor() or (not _is_double_jump and double_jump_power_up):
			var time_now = Time.get_ticks_msec() - jump_time
			var jump_force = min(time_now, MAX_JUMP_HOLD)
			if(not is_on_floor() and jump_force > MAX_JUMP_HOLD):
				jump_force = MAX_JUMP_HOLD 
			jump_force = jump_force/MAX_JUMP_HOLD
	
			if jump_force >= 0.7:
				jump_force = 0.7
			print(jump_force)
			if(is_on_floor()):
				velocity.y = JUMP_VELOCITY * jump_force
				velocity.x = input * JUMP_VELOCITY_MIN * jump_force * -1
			else:
				velocity.y = JUMP_VELOCITY * 0.5
				velocity.x = input * JUMP_VELOCITY_MIN * jump_force * -1
			
			print(jump_force)
			if not is_on_floor():
				_is_double_jump = true
			else:
				_is_double_jump = false
	elif Input.is_action_just_released("jump"):
		if velocity.y < JUMP_VELOCITY_MIN:
			velocity.y = JUMP_VELOCITY_MIN
	
	
	#var input: float = Input.get_axis("ui_left", "ui_right")
	if input:
			#velocity.x = input * SPEED
		if is_on_floor():
			velocity.x = move_toward(velocity.x, 0 * SPEED, ACCELERATION * delta)
			_direction = sign(input)
		else:
			#print(input)
			if(velocity.y <= 0):
				velocity.x = move_toward(velocity.x, input * 250, ACCELERATION * delta * 2)
			
			_direction = sign(input)
	else:
		velocity.x = move_toward(velocity.x, 0, FRICTION * delta)
	
	if velocity.y > 0:
		velocity.y = clamp(velocity.y, 0, 800)
	
	move_and_slide()
	_animate_player()


func _animate_player():
	if is_on_floor():
		if velocity.x != 0:
			_animated_sprite.play("run")
		else:
			_animated_sprite.play("idle")
	else:
		if velocity.y < 0:
			_animated_sprite.play("jump")
		else:
			_animated_sprite.play("fall")

	_animated_sprite.scale.x = _direction


@warning_ignore("unused_parameter")
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Checkpoint"):
		if _last_checkpoint != null:
			_last_checkpoint._deactivate()
		body._activate()
		_start_posisition = body.position
	else:
		position = _start_posisition

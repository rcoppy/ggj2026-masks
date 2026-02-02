extends CharacterBody3D

@export var travel_speed = 5
@export var gravity = 0
@export var distance_margin = 0.01

@onready var _move_target: Vector3 = position

enum MoveState {IDLE, MOVING}
var _is_frozen: bool = false
var _move_state: MoveState = MoveState.IDLE

signal moving(velocity: Vector3)

func _enter_tree() -> void:
	add_to_group("player")

func set_move_target(target_position: Vector3, should_move_immediately: bool = true):
	_move_target = target_position
	
	if should_move_immediately:
		_move_state = MoveState.MOVING

func set_move_state(value: MoveState):
	_move_state = value
	
func set_is_frozen(value: bool):
	_is_frozen = value

func _physics_process(delta):
	if _is_frozen or _move_state == MoveState.IDLE:
		return
	
	if position.distance_squared_to(_move_target) <= distance_margin * distance_margin:
		return
	
	var direction: Vector3 = position.direction_to(_move_target)
	velocity = travel_speed * direction  
	#velocity.y = 0 # flatten vertical movement
	move_and_slide()
	moving.emit(velocity)
	

extends Node3D

@onready var mask_sprite: AnimatedSprite3D = get_node("boywolf")
@onready var unmask_sprite: AnimatedSprite3D = get_node("wolf")

var is_animation_paused: bool = false:
	get: 
		return is_animation_paused
	set(value):
		is_animation_paused = value
		
		if is_animation_paused:
			mask_sprite.pause()
			unmask_sprite.pause()
		else: 
			mask_sprite.play()
			unmask_sprite.play()

var is_wearing_mask: bool = false:
	get:
		return is_wearing_mask
	set(value):
		is_wearing_mask = value
		
		mask_sprite.visible = is_wearing_mask
		unmask_sprite.visible = !is_wearing_mask

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	is_animation_paused = false
	is_wearing_mask = true
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_player_moving(velocity: Vector3) -> void:
	# vector math stuff
	var camera = get_viewport().get_camera_3d()
	var right: Vector3 = camera.transform.basis.x
	
	if velocity.dot(right) < 0: # moving left relative to camera
		scale.x = -1 * abs(scale.x)
	else:
		scale.x = abs(scale.x)

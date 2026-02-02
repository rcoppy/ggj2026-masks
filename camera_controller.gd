extends Camera3D

var bounds_xoffset: Vector3
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var bounding_shape: CollisionShape3D = get_node("BoundingVolume/CollisionShape3D")
	bounds_xoffset = bounding_shape.shape.size.x * bounding_shape.basis.x 
	
func _get_sign_of_screen_half(body: Node3D) -> int:
	# given a node3d, see if it's to the left or right of camera center
	# return -1, 1 for left, right
	
	# vector math stuff
	var right: Vector3 = basis.x
	var diff: Vector3 = body.position - position
	
	if diff.dot(right) < 0: # position is left relative to camera center
		return -1
	
	return 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_bounding_volume_body_shape_exited(body_rid: RID, body: Node3D, body_shape_index: int, local_shape_index: int) -> void:
	print("detected")
	if not body in Engine.get_main_loop().get_nodes_in_group("player"):
		return
		
	var dir = _get_sign_of_screen_half(body)
	position += dir * bounds_xoffset
	print("adjusted")
	

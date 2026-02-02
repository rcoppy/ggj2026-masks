extends StaticBody3D

signal floor_clicked(world_position: Vector3)

func _ready() -> void:
	set_ray_pickable(true)

func _input_event(camera: Camera3D, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed:
		floor_clicked.emit(event_position)

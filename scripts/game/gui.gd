extends RemoteTransform2D

signal camera_changed

func _changed():
	remote_path = get_viewport().get_camera_2d().get_path()

func _ready() -> void:
	camera_changed.connect(_changed)

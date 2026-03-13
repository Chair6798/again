extends ColorRect

@export_category("Offsets")
@export var left_offset:int = 0
@export var right_offset:int = 0
@export var top_offset:int = 0
@export var bottom_offset:int = 0

@onready var camera = get_viewport().get_camera_2d()

func _change():
	size=Vector2(get_viewport().size.x*(1/camera.zoom.x)-left_offset-right_offset,get_viewport().size.y*(1/camera.zoom.y)-top_offset-bottom_offset)
	position = Vector2(-get_viewport().size.x*(1/camera.zoom.x)/2+left_offset,-get_viewport().size.y*(1/camera.zoom.y)/2+top_offset)

func _ready() -> void:
	await get_tree().process_frame
	_change()
	get_viewport().size_changed.connect(_change)

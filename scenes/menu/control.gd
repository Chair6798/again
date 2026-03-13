extends Control
func _math():
	get_node("Game").position=size/2

func _ready() -> void:
	_math()
	get_viewport().size_changed.connect(_math)

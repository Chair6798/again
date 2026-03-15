extends Camera2D

signal size_changed

@export var real_zoom:Vector2=Vector2(1,1):
	set(value):
		# Коррекция: если компоненты <= 0, заменить на 1 чтобы не ломать рендер
		var new_x = value.x
		var new_y = value.y
		if new_x <= 0:
			new_x = 1
		if new_y <= 0:
			new_y = 1
		var corrected = Vector2(new_x, new_y)
		if real_zoom != corrected:
			real_zoom = corrected
			_sync_size()
@export var script_zoom:Vector2 = Vector2(1,1)
func _sync_size():
	var vp = get_viewport()
	if vp == null:
		return

	var sy = vp.size.y
	var sx = vp.size.x
	var s = min(sx, sy)
	if s <= 0:
		return
	var koeff = s / 600.0

	# применение коэффицента
	zoom = Vector2(koeff * real_zoom.x, koeff * real_zoom.y)
	script_zoom=Vector2(koeff,koeff)
	# отладочная печать — только в редакторе
	if Engine.is_editor_hint():
		print("camera _sync_size koeff=", koeff, " s=", s)

	emit_signal("size_changed")

func _ready() -> void:
	_sync_size()
	var vp = get_viewport()
	if vp:
		# использовать Callable для надёжного подключения
		vp.size_changed.connect(Callable(self, "_sync_size"))

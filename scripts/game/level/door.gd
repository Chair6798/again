extends "res://scripts/game/level/connectable.gd"

func use_start():
	get_parent().get_parent().get_node("Audio").get_node("Door").play()
	var t = create_tween()
	t.tween_property(self,"position",Vector2(position.x,-50),0.5)
	

func use_end():
	get_parent().get_parent().get_parent().get_node("Audio").get_node("Door").play()
	var t = create_tween()
	t.tween_property(self,"position",Vector2(position.x,141),0.5)

extends Node

var a = 0

func boolToInt(b:bool) -> int:
	if b==true:
		return 1
	else:
		return 0

func wait(sec):
	await get_tree().create_timer(sec).timeout

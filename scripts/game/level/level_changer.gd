extends Area2D

func _body_enter(body):
	print(typeof(body))
	if body is CharacterBody2D and get_parent().is_ready:
		get_node("/root/Root").next_level()

func _ready():
	body_entered.connect(_body_enter)

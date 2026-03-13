extends Area2D

func _body_entered(body):
	print("Entered. Type:",typeof(body))
	if body.name=="Player" and get_parent().is_ready:
		print("Die")
		body.die()

func _body_exited(_body):
	pass

func _ready() -> void:
	body_entered.connect(_body_entered)
	body_exited.connect(_body_exited)

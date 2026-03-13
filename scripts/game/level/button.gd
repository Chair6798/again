extends StaticBody2D

@export var ConnectedObject:Node

@export var enabled = true:
	set(value):
		if enabled!=value:
			enabled=value

signal down

signal up

@export var pressed = false:
	set(value):
		if pressed==value:
			return
		pressed=value
		if pressed:
			down.emit()
		else:
			up.emit()

var collided = 0

func _down():
	get_parent().get_parent().get_node("Audio").get_node("Button").play()
	$Sprite2D2.position=Vector2(0,0)
	ConnectedObject.use_start()

func _up():
	get_parent().get_parent().get_node("Audio").get_node("Button").play()
	$Sprite2D2.position=Vector2(0,-9)
	ConnectedObject.use_end()

func _entered(body):
	if not enabled:
		return
	
	if get_parent().is_ready==false:
		return
	if (body is CharacterBody2D)  or (body is RigidBody2D):
		collided+=1
		_down()

func _leaved(body):
	if not enabled:
		return
	
	if get_parent().is_ready==false:
		return
	if (body is CharacterBody2D)  or (body is RigidBody2D):
		collided-=1
		if collided==0:
			_up()

func _ready() -> void:
	get_node("collider").body_entered.connect(_entered)
	get_node("collider").body_exited.connect(_leaved)

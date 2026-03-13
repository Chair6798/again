extends CharacterBody2D
class_name Player
@export var freezed= false

@onready var gravity:float = -500

var on_floor_last_frame = false

var lastDelta=0.01

var jumping = false


var can_control = true

var current_picked:RigidBody2D=null

func pick(target:RigidBody2D):
	current_picked=target
	get_node("physcannon_pickup").play()

func reset_values():
	gravity=-500

func _apply_gravity(delta:float,custom:float=gravity):
	velocity.y-=custom*delta

func _apply_controls():
	velocity.x= (lib.boolToInt(UserInput.inputs["Right"])-lib.boolToInt(UserInput.inputs["Left"])  )*get_viewport().size.y/3 * lastDelta*80
	get_node("leftEye/subeye").position.x=(lib.boolToInt(UserInput.inputs["Right"])-lib.boolToInt(UserInput.inputs["Left"]))*30
	get_node("rightEye/subeye").position.x=(lib.boolToInt(UserInput.inputs["Right"])-lib.boolToInt(UserInput.inputs["Left"]))*30

func _apply_eyes():
	if velocity.y<get_viewport().size.y/10 and velocity.y>-get_viewport().size.y/10 :
		get_node("leftEye/subeye").position.y=0
		get_node("rightEye/subeye").position.y=0
	elif velocity.y>0:
		get_node("leftEye/subeye").position.y=30
		get_node("rightEye/subeye").position.y=30
	elif velocity.y<0:
		get_node("leftEye/subeye").position.y=-30
		get_node("rightEye/subeye").position.y=-30

func jump(power:float=100):
	if Root.pcontrol==false:
		return
	
	velocity.y-=power*lastDelta*300
	get_node("jump").play()



func _physics_process(delta: float) -> void:
	if freezed:
		return
	
	if not on_floor_last_frame and is_on_floor():
		get_node("floor").play()
	on_floor_last_frame = is_on_floor()
	_apply_gravity(delta)
	if Root.pcontrol and can_control:
		_apply_controls()
	else:
		velocity.x=0
		get_node("leftEye/subeye").position.x=0
		get_node("rightEye/subeye").position.x=0
	lastDelta=delta
	_apply_eyes()
	
	move_and_slide()

func _onJump():
	if is_on_floor() and gravity<0:
		jump()
		print("jump1")
	elif is_on_ceiling() and gravity>0:
		jump(-100)
		print("jump 2")
func remath():
	pass
	#gravity=-get_viewport().size.y/2


func _ready() -> void:
	UserInput.Jump.connect(_onJump)
	get_viewport().size_changed.connect(remath)
	
func die():
	Root.reload_level()
	

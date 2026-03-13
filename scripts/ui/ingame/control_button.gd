extends TouchScreenButton

@export var sortEnum = "r"

@onready var camera = get_parent().get_parent().get_node("Camera")

func _pressed():
	modulate=Color(0.1,0.1,0.1)
	print("pressed .. "+sortEnum)
	if sortEnum=="l":
		UserInput.LeftStart.emit()
		UserInput.inputs["Left"]=true
	elif sortEnum=="r":
		UserInput.RightStart.emit()
		UserInput.inputs["Right"]=true
	elif sortEnum=="j":
		UserInput.Jump.emit()
	if sortEnum=="home":
		Root.load_menu_level()
func _released():
	modulate=Color(1,1,1)
	if sortEnum=="l":
		UserInput.LeftEnd.emit()
		UserInput.inputs["Left"]=false
	elif sortEnum=="r":
		UserInput.RightEnd.emit()
		UserInput.inputs["Right"]=false

func _math():
	if sortEnum=="l":
		position.x = -get_viewport().size.x*(1/camera.zoom.x)/2
		
	if sortEnum=="r":
		position.x = -get_viewport().size.x*(1/camera.zoom.x)/2+texture_normal.get_width()*scale.x
	if sortEnum=="j":
		position.x = get_viewport().size.x*(1/camera.zoom.x)/2-texture_normal.get_width()*scale.x
	if sortEnum=="home":
		position.x = -get_viewport().size.x*(1/camera.zoom.x)/2
		position.y = -get_viewport().size.y*(1/camera.zoom.y)/2
	if sortEnum == "use":
		#position.x = get_viewport().size.x*(1/camera.zoom.x)/2-texture_normal.get_width()*scale.x-texture_normal.get_width()*scale.x
		visible=false
	#---------------------------------------------------------------------------------------
	if sortEnum=="hint" or sortEnum=="home":
		pass
	else:
		position.y = get_viewport().size.y*(1/camera.zoom.y)/2-texture_normal.get_height()*scale.y

func _mobile():
	if Root.is_menu:
		visible=false
		return
	if (sortEnum=="hint"or sortEnum=="home"):
		visible=true
	else:
		if Root.edition=="desktop":
			visible=false
		else:
			visible=true
	
	if sortEnum=="use":
		visible=false

func _other():
	if Root.is_menu==false:
		#print("SHOWED")
		visible=false
		if sortEnum=="hint" or sortEnum=="home":
			visible=true
	else:
		#print("HIDED")
		visible=false
	if sortEnum=="use":
		visible=false

func _update_camera():
	camera=get_viewport().get_camera_2d()

func _ready() -> void:
	await get_tree().process_frame
	visible=false
	_other()
	_math()
	print(sortEnum+" button has been inited")
	pressed.connect(_pressed)
	released.connect(_released)
	camera.size_changed.connect(_math)
	UserInput.Phone.connect(_mobile)
	UserInput.Console.connect(_other)
	UserInput.Desktop.connect(_other)
	
	

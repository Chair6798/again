extends TextureButton



func _press():
	match name:
		"LeftButton":
			UserInput.LeftStart.emit()
			UserInput.inputs["Left"]=true
		"RightButton":
			UserInput.RightStart.emit()
			UserInput.inputs["Right"]=true
		"JumpButton":
			UserInput.Jump.emit()

func _release():
	match name:
		"LeftButton":
			UserInput.LeftEnd.emit()
			UserInput.inputs["Left"]=false
		"RightButton":
			UserInput.RightEnd.emit()
			UserInput.inputs["Right"]=false

func _ready():
	button_down.connect(_press)
	button_up.connect(_release)

extends Node

signal OnInputStart
signal OnInputEnd

signal PickUp
signal Jump

signal LeftStart
signal LeftEnd

signal RightStart
signal RightEnd

signal Desktop
signal Phone
signal Console

var binds = {
	"Right":[KEY_D, KEY_RIGHT],
	"Left":[KEY_A, KEY_LEFT],
	"Jump":[KEY_W, KEY_UP, KEY_SPACE],
	"PickUp":[KEY_E,KEY_Q,KEY_SHIFT],
}
var inputs = {
	"Right" = false,
	"Left" = false,
}

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
#-------------------------------------------------------------#
		Desktop.emit()
#-------------------------------------------------------------#
		if event.is_pressed():
			OnInputStart.emit(event.keycode)
		if event.is_released():
			OnInputEnd.emit(event.keycode)
#--------------------------------------------------------------#
		if event.is_pressed():
			for key in binds:
				if event.keycode in binds[key]:
					if key=="Right":
						RightStart.emit()
						inputs["Right"] = true
					if key=="Left":
						LeftStart.emit()
						inputs["Left"] = true
					if key=="Jump" and not Root.is_menu:
						Jump.emit()
					if key=="PickUp":
						PickUp.emit()
		if event.is_released():
			for key in binds:
				if event.keycode in binds[key]:
					if key=="Right":
						RightEnd.emit()
						inputs["Right"] = false
					if key=="Left":
						LeftEnd.emit()
						inputs["Left"] = false
	if event is InputEventScreenTouch:
		Phone.emit()
	if event is InputEventJoypadButton or event is InputEventJoypadMotion:
		Console.emit()

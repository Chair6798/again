extends Node

@onready var game:Node2D = get_node("/root/Game/Flat")
@onready var camera:Camera2D = game.get_node("Camera")
@onready var player:Player = game.get_node("Player")



@onready var hint_button:TouchScreenButton = camera.get_node("hint_button")

@onready var levelobject

var level_count:int=0

@onready var loaded_counter:Label =get_node("/root/Game/PreloadInfo/counter")
@onready var intro_object:Control = get_node("/root/Game/Intro")
# signals
signal level_changed
signal level_closed
signal level_opened

var currentLevel = 1
var lastavaiable = currentLevel
var levels = []
var is_menu = false
var pcontrol=true

var edition="mobile"

func replace_camera(new_position:Vector2):
	camera.position=new_position

func fixcam():
	camera.make_current()
	camera.position=Vector2.ZERO
	camera.rotation=0
	camera.scale=Vector2.ONE

func rezoom_camera(new_zoom:Vector2):
	camera.real_zoom = new_zoom

func savedata():
	var progress_file = FileAccess.open("user://progress.dat",FileAccess.WRITE)
	progress_file.store_32(lastavaiable)
	progress_file.close()

func loaddata():
	var progress_file = FileAccess.open("user://progress.dat",FileAccess.READ)
	if progress_file==null:
		var pprogress_file = FileAccess.open("user://progress.dat",FileAccess.WRITE)
		pprogress_file.store_32(1)
		pprogress_file.close()
	else:
		lastavaiable=progress_file.get_32()

func resetdata():
	lastavaiable=1
	savedata()

#func _switch_camera(camera:Camera2D):
	#camera.make_current()

func _preloadLevels():
	var levelsDir = DirAccess.open("res://scenes/levels")
	print("LOADING LEVELS WAIT!!!")
	var levells = levelsDir.get_files()
	
	var levelscount:int = 0
	for v in levells:
		if v.ends_with(".tscn") or v.ends_with(".remap"):
			levelscount+=1
	level_count=levelscount
	loaded_counter.set_max(levelscount)
	loaded_counter.set_value(0)
	print("levels count: "+str(levelscount))
	for i in range(1,levelscount+1):
		var v = "level"+str(i)+".tscn"
		print(v)
		var loadd = load("res://scenes/levels/"+v)
		await get_tree().process_frame
		levels.append(loadd)
		print("Scene....",v," Has loaded!")
		loaded_counter.add()
	intro_object.run_intro()
	loaded_counter.get_parent().visible=false
func next_level():
	currentLevel+=1
	if currentLevel>lastavaiable:
		lastavaiable=currentLevel
	savedata()
	load_level_number(currentLevel)

func load_level(level:PackedScene,playerfreeze=false, playervis=true):
	if levelobject!=null:
		await get_tree().process_frame
		if hint_button.is_connected("pressed",levelobject.on_click_hint):
			hint_button.pressed.disconnect(levelobject.on_click_hint)
			print("Disconnected!")
		game.remove_child(levelobject)
	player.reset_values()
	pcontrol=true
	level_changed.emit()
	var nlevel = level.instantiate()
	nlevel.name="Level"
	game.add_child(nlevel)
	levelobject = nlevel
	player.position = levelobject.get_node("spawn").position
	player.velocity=Vector2.ZERO
	player.freezed=playerfreeze
	player.visible=playervis
	await get_tree().physics_frame
	await get_tree().physics_frame
	nlevel.is_ready=true
	camera.make_current()
	camera.real_zoom=nlevel.targetzoom
	hint_button.pressed.connect(nlevel.on_click_hint)

func load_level_number(level):
	print("Changing level to ",level)
	print("unsubscribed hint button")
	currentLevel=level
	if level>levels.size():
		print("NO LEVEL")
		load_thanks_level()
		return
	
	
	if is_menu:
		level_opened.emit()
	is_menu=false
	load_level(levels.get(currentLevel-1))



func reload_level():
	load_level_number(currentLevel)

func load_user_level(filetitle:String):
	var dir = DirAccess.open("user://userlevels/")
	if dir:
		var file = FileAccess.open("user://userlevels/"+filetitle,FileAccess.READ)
		if file:
			file.close()
			if is_menu:
				level_opened.emit()
				is_menu=false
			load_level(load("user://userlevels/"+filetitle))
		else:
			push_warning("Failed to load user level! No file!")
			return "err"
	else:
		push_warning("Failed to load user level! No folder!")
		return "err"


func load_menu_level():
	if levelobject!=null:
		await get_tree().process_frame
		game.remove_child(levelobject)
	level_closed.emit()
	is_menu = true
	load_level(load("res://scenes/menu/main_menu.tscn"),true,false)

func load_thanks_level():
	if levelobject!=null:
		await get_tree().process_frame
		game.remove_child(levelobject)
	is_menu = true
	level_closed.emit()
	load_level(load("res://scenes/menu/thanks.tscn"),true,false)

func _ready() -> void:
	TranslationServer.set_locale("ru")
	loaddata()
	is_menu=true
	await _preloadLevels()
	#########################
	load_menu_level()
	#########################

#func _input(event: InputEvent) -> void:
	#if event is InputEventKey:
		#if event.keycode==KEY_P and event.is_pressed():
			#next_level()
		#if event.keycode==KEY_O and event.is_pressed():
			#if currentLevel != 1:
				#load_level(currentLevel-1)

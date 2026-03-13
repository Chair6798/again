extends "res://scripts/ui/ingame/fullscreenattach.gd"



var hints:Array = [
	"Просто пройди вправо",
	"Встань на кнопку",
	"Пройди не нажимая на кнопку",
	"Кнопка спрятана под одним из шипов",
	"На этом уровне не получится просто нажать на кнопку\nУрони куб на кнопку, сломав платформу под ним.",
	"Нажав на кнопку ты увидишь изменение в стене - это проход",
	"",
	"Просто пройди к выходу(выход всегда справа)",
	"Толкни дверь персонажем",
	"Нажми на рычаг, который находится над лазером",
	"Нажимай на дверь чтобы ломать её",
	"Просто подожди, пока дверь откроется сама.",
	"Подчинись саймону.",
	"Верхушка кнопки-светофор. Не двигайся, когда горит красным.",
	"Встань в центр и прыгни",
	"Закрой 'Не'",
	"Нажми на затемнённую область и введи 'кнопка'",
	""
]
var avaiable = false

func setup():
	get_node("content").text = "LEVEL"+str(Root.currentLevel)+"_HINT"
func onclose():
	visible = false
func show_hint():
	if get_node("content").text!=""and get_node("content").text!="LEVEL7_HINT":
		visible=true
func _l_c():
	avaiable=false
func _l_o():
	avaiable=true
func _ready() -> void:
	super._ready()
	get_parent().get_node("hint_button").pressed.connect(show_hint)
	get_node("cbtn").pressed.connect(onclose)
	Root.level_closed.connect(_l_c)
	Root.level_opened.connect(_l_o)
	Root.level_changed.connect(setup)

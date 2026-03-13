extends TextureButton

var links:Dictionary = {
	"telegram" = "https://t.me/BlackCatStudio_Games",
	"vk"="https://vk.com/club235074375",
	"rustore"="https://www.rustore.ru/catalog/app/com.blackcat.again",
	"dalerts"="https://dalink.to/black_cat_studio",
	"boosty"="https://boosty.to/maximandchair",
}

func _pressed() -> void:
	OS.shell_open(links[name])

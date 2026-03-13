extends Node
var language = "automatic"
func _ready() -> void:
	# Load here language from the user settings file
	if language == "automatic":
		var preferred_language = OS.get_locale_language()
		language=preferred_language
		print(preferred_language)

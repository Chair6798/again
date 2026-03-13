extends Node
#
#var preloaded=false:
	#set(value):
		#if value==false:
			#pass
		#else:
			#preloaded=true
	#get():
		#return preloaded
#
#var preloads:Array[PackedScene] = []
#
#func _preload():
	#if preloaded:
		#return
	#
#
#func build_level(map:Array):
	#pass
		#

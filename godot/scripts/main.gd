extends Node2D

var main_scene
var main_instance

# Called when the node enters the scene tree for the first time.
func _ready():
	print("starting load")#loads the main scene so it can be used
	main_scene = load("res://scenes/chemistry-room.tscn")
	
	print("loaded successfully")#instantiates the scene, so it is visible
	main_instance = main_scene.instantiate()
	add_child(main_instance)
	
	print("instantiated successfully")
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
	
func switch_room(new_room): #switches the current main_room with another new new_room
	remove_child(main_instance) #removes the original instance, so the new one can be instantiated
	main_scene = load(new_room) #loads new scene and instantiates it
	main_instance = main_scene.instantiate()
	add_child(main_instance)

extends Node2D

var main_scene
var main_instance
var player_scene
var player_instance
# Called when the node enters the scene tree for the first time.
func _ready():
	main_scene = preload("res://scenes/chemistry-room.tscn")
	main_instance = main_scene.instantiate()
	add_child(main_instance)
	
	player_scene = preload("res://scenes/player.tscn")
	player_instance = player_scene.instantiate()
	add_child(player_instance)
	
	var door_node = get_node("/root/main/player/player")
	door_node.connect("switch_room", Callable(self, "go_to_room2"), 0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	pass
	
func switch_room(new_room): #switches the current main_room with another new new_room
	main_instance.queue_free() 
	main_scene = load(new_room) 
	main_instance = main_scene.instantiate()  
	add_child(main_instance)

func go_to_room2():
	switch_room("res://scenes/room2.tscn")

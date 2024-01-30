extends Node2D

var main_scene
var main_instance
var player_scene
var player_instance
var ui_scene
var ui_instance

# Called when the node enters the scene tree for the first time.
func _ready():
	main_scene = preload("res://scenes/chemistry-room.tscn")
	main_instance = main_scene.instantiate()
	add_child(main_instance)
	
	player_scene = preload("res://scenes/player.tscn")
	player_instance = player_scene.instantiate()
	add_child(player_instance)
	
	
	ui_scene = preload("res://scenes/ui.tscn")
	ui_instance = ui_scene.instantiate()
	var door_node = get_node("/root/main/player/player")
	door_node.connect("switch_room", switch_room, 0)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var has_UI = has_node("UI")
	if (Input.is_action_just_pressed("ui_cancel") && has_UI):
		remove_child(ui_instance)
		add_child(main_instance)
		add_child(player_instance)
		
	if (Input.is_action_just_pressed("open ui") && !has_UI && get_node("player/player").get_player_collider().get_meta("pathmm") == "res://scenes/ui.tscn"):
			add_child(ui_instance)
			remove_child(main_instance)
			remove_child(player_instance)
		
	if (Input.is_action_just_pressed("ui_accept") && has_UI):
		get_node("UI").isInputCorrect()

	
func switch_room(new_room): #switches the current main_room with another new new_room
	main_instance.queue_free() 
	main_scene = load(new_room) 
	main_instance = main_scene.instantiate()  
	add_child(main_instance)

func open_ui():
	pass

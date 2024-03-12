extends Node2D

var main_scene
var main_instance
var player_scene
var player_instance
var status


# Called when the node enters the scene tree for the first time.
func _ready():
	status = "main menu"
	var main_menu_button_container = get_node("CanvasLayer/Control/VBoxContainer/HBoxContainer2/PanelContainer/MarginContainer/VBoxContainer")
	var settings_button_container = get_node("CanvasLayer/Control2/PanelContainer/MarginContainer/HBoxContainer")
	var pause_button_container = get_node("CanvasLayer/Control3/PanelContainer/MarginContainer/VBoxContainer")
	
	main_menu_button_container.get_node("Button").connect("pressed", start_game)
	main_menu_button_container.get_node("Button2").connect("pressed", get_node("CanvasLayer/Control2").show)
	main_menu_button_container.get_node("Button2").connect("pressed", get_node("CanvasLayer/Control").hide)
	main_menu_button_container.get_node("Button3").connect("pressed", get_tree().quit)
	
	settings_button_container.get_node("Button").connect("pressed", get_node("CanvasLayer/Control2").hide)
	settings_button_container.get_node("Button").connect("pressed", get_node("CanvasLayer/Control").show)
	
	pause_button_container.get_node("Button").connect("pressed", get_node("CanvasLayer/Control3").hide)
	pause_button_container.get_node("Button2").connect("pressed", close_game)
	pause_button_container.get_node("Button3").connect("pressed", get_tree().quit)


func start_game():
	get_node("CanvasLayer/Control").hide()
	status = "game"
	
	main_scene = preload("res://scenes/room_chemistry.tscn")
	main_instance = main_scene.instantiate()
	add_child(main_instance)
	
	player_scene = preload("res://scenes/player.tscn")
	player_instance = player_scene.instantiate()
	add_child(player_instance)
	
	var chemistry_door_node = get_node("/root/main/player/player")
	chemistry_door_node.connect("switch_room", switch_room, 0)

func close_game():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("pause") && (status == "game"):
		if get_node("CanvasLayer/Control3").visible:
			get_node("CanvasLayer/Control3").hide()
		else:
			get_node("CanvasLayer/Control3").show()
		
	

func switch_room(new_room): #switches the current main_room with another new new_room
	main_instance.queue_free() 
	main_scene = load(new_room) 
	main_instance = main_scene.instantiate()  
	add_child(main_instance)

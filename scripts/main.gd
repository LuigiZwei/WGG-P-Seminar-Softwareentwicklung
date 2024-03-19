extends Node2D

var main_scene
var main_instance
var player_scene
var player_instance
var status


# Called when the node enters the scene tree for the first time.
func _ready():
	status = "main menu"
	var main_menu_button_container = get_node("CanvasLayer/main_menu/VBoxContainer/HBoxContainer2/PanelContainer/MarginContainer/VBoxContainer")
	var settings_button_container = get_node("CanvasLayer/settings_menu/PanelContainer/MarginContainer/HBoxContainer")
	var pause_button_container = get_node("CanvasLayer/pause_menu/PanelContainer/MarginContainer/VBoxContainer")
	
	main_menu_button_container.get_node("Button").connect("pressed", start_game)
	main_menu_button_container.get_node("Button2").connect("pressed", get_node("CanvasLayer/settings_menu").show)
	main_menu_button_container.get_node("Button2").connect("pressed", get_node("CanvasLayer/main_menu").hide)
	main_menu_button_container.get_node("Button3").connect("pressed", get_tree().quit)
	
	settings_button_container.get_node("Button").connect("pressed", get_node("CanvasLayer/settings_menu").hide)
	settings_button_container.get_node("Button").connect("pressed", get_node("CanvasLayer/main_menu").show)
	
	pause_button_container.get_node("Button").connect("pressed", get_node("CanvasLayer/pause_menu").hide)
	pause_button_container.get_node("Button2").connect("pressed", close_game)
	pause_button_container.get_node("Button3").connect("pressed", get_tree().quit)

func start_game():
	get_node("CanvasLayer/main_menu").hide()
	status = "game"
	
	get_node("current_room").show()
	get_node("player").show()
	get_node("player/CanvasLayer").show()
	
	var chemistry_door_node = get_node("/root/main/player")
	chemistry_door_node.connect("switch_room", switch_room, 0)

func close_game():
	get_node("player").hide()
	get_node("current_room").hide()
	get_node("CanvasLayer/pause_menu").hide()
	get_node("CanvasLayer/main_menu").show()

func _process(_delta):
	if Input.is_action_just_pressed("pause") && (status == "game"):
		if get_node("CanvasLayer/pause_menu").visible:
			get_node("CanvasLayer/pause_menu").hide()
		else:
			get_node("CanvasLayer/pause_menu").show()

func switch_room(new_room):
	get_node("current_room").set_name("old_room")
	get_node("old_room").queue_free()
	var new_instance = load(new_room).instantiate()
	add_child(new_instance)
	get_node(String(new_instance.get_name())).set_name("current_room")
	print(get_node("current_room").get_name())

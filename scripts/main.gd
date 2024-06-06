extends Node2D

var main_scene
var main_instance
var player_scene
var player_instance
var status
var sound_player := AudioStreamPlayer.new()

# Called when the node enters the scene tree for the first time.
func _ready():

	
	# Erstellung der InputMap (weil .godot nicht exportiert werden kann, dankeschön)
	var key_input_function = func (action, key):
		var inputkey = InputEventKey.new()
		inputkey.set_keycode(key)
		InputMap.action_add_event(action, inputkey)
	
	InputMap.add_action("left")
	key_input_function.call("left",KEY_A)
	key_input_function.call("left",KEY_LEFT)
	InputMap.add_action("right")
	key_input_function.call("right",KEY_D)
	key_input_function.call("right",KEY_RIGHT)
	InputMap.add_action("up")
	key_input_function.call("up",KEY_W)
	key_input_function.call("up",KEY_UP)
	InputMap.add_action("down")
	key_input_function.call("down",KEY_S)
	key_input_function.call("down",KEY_DOWN)
	InputMap.add_action("sprint")
	key_input_function.call("sprint",KEY_SHIFT)
	InputMap.add_action("pause")
	key_input_function.call("pause",KEY_ESCAPE)
	InputMap.add_action("task")
	key_input_function.call("task",KEY_E)
  
	add_child(sound_player)
  
   	# status dient als variable, die aussagen soll, was gerade passiert
	# kann man wahrscheinlich irgendwie besser machen, aber es kann nützlich sein um
	# gleichzeitig vieles zu deaktivieren, was an einem bestimmten moment nicht passieren soll
	status = "main_menu"
	# UI-elemente mit knöpfen
	var main_menu_button_container = $CanvasLayer/main_menu/VBoxContainer/HBoxContainer2/PanelContainer/MarginContainer/VBoxContainer
	var settings_button_container = $CanvasLayer/settings_menu/PanelContainer/MarginContainer/HBoxContainer
	var pause_button_container = $CanvasLayer/pause_menu/PanelContainer/MarginContainer/VBoxContainer
	
	# verbindet die "pressed"-signale der knöpfe mit deren jeweiligen funktionen
	#                              vv  kann hier kein $Button verwenden :(
	main_menu_button_container.get_node("Button").connect("pressed", start_game)
	main_menu_button_container.get_node("Button2").connect("pressed", get_node("CanvasLayer/settings_menu").show)
	main_menu_button_container.get_node("Button2").connect("pressed", get_node("CanvasLayer/main_menu").hide)
	main_menu_button_container.get_node("Button3").connect("pressed", get_tree().quit)
	
	settings_button_container.get_node("Button").connect("pressed", get_node("CanvasLayer/settings_menu").hide)
	settings_button_container.get_node("Button").connect("pressed", get_node("CanvasLayer/main_menu").show)
	
	pause_button_container.get_node("Button").connect("pressed", start_game)
	pause_button_container.get_node("Button2").connect("pressed", close_game)
	pause_button_container.get_node("Button3").connect("pressed", get_tree().quit)

func start_game():
	# versteckt das main menu und zeigt stattdessen den spieler und das momentane zimmer
	# noch hinzufügen: spielfortschritt laden
	if(get_node_or_null("CanvasLayer/task") == null):
		# erstellung neuer task UI-szene
		var task_scene = load("res://scenes/task_1.tscn").instantiate()
		$CanvasLayer.add_child(task_scene)
		$CanvasLayer.get_node(String(task_scene.get_name())).set_name("task")
		$CanvasLayer/task/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/LineEdit.connect("focus_entered",func(): status = "game_typing")
		$CanvasLayer/task/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/LineEdit.connect("focus_exited",func(): status = "game")
		$CanvasLayer/task.hide()
	
	#erstellung des einführungsszene
	var intro_scene = load("res://scenes/intro.tscn").instantiate()
	$CanvasLayer.add_child(intro_scene)
	$CanvasLayer.get_node(String(intro_scene.get_name())).set_name("intro")
		
	
	$player.show()
	$player/CanvasLayer.show()
	$current_room.show()
	$CanvasLayer/pause_menu.hide()
	$CanvasLayer/main_menu.hide()
	$player.player_speed = 300
	$player.player_sprint_speed = 600
	$player.animated_sprite.speed_scale = 1
	status = "game"
	
	var chemistry_door_node = $/root/main/player
	chemistry_door_node.connect("switch_room", switch_room)

func close_game():
	# versteckt das spiel und den spieler und öffnet das main menu
	# der spieler kann sich nicht bewegen während er unsichtbar ist
	$player.hide()
	$player/CanvasLayer.hide()
	$current_room.hide()
	$CanvasLayer/pause_menu.hide()
	$CanvasLayer/main_menu.show()
	status = "main_menu"

func _process(_delta):
	# öffnet oder schließt die pause-UI
	if Input.is_action_just_pressed("pause") && (status == "game") && (get_node_or_null("CanvasLayer/task") != null):
		if !$CanvasLayer/task.visible:
			if $CanvasLayer/pause_menu.visible:
				$CanvasLayer/pause_menu.hide()
				$player.player_speed = 300
				$player.player_sprint_speed = 600
				$player.animated_sprite.speed_scale = 1
			else:
				$CanvasLayer/pause_menu.show()
				$player.player_speed = 0
				$player.player_sprint_speed = 0
				$player.animated_sprite.speed_scale = 0
	
	# beendet das schreiben im aufgaben-menü wenn ESC gedrückt wird
	if Input.is_action_just_pressed("pause") && (status == "game_typing"):
		$CanvasLayer/task/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/LineEdit.release_focus()
	
	# erstellt/öffnet/schließt die task UI wenn E gedrückt wird
	# (solange der spieler nicht bereits in der task ui schreibt)
	if Input.is_action_just_pressed("task") && (status == "game") && !$CanvasLayer/pause_menu.visible:
		if(get_node_or_null("CanvasLayer/task") == null):
			# erstellung neuer task UI-szene
			var task_scene1 = load("res://scenes/task_1.tscn").instantiate()
			$CanvasLayer.add_child(task_scene1)
			$CanvasLayer.get_node(String(task_scene1.get_name())).set_name("task")
			$CanvasLayer/task/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/LineEdit.connect("focus_entered",func(): status = "game_typing")
			$CanvasLayer/task/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/LineEdit.connect("focus_exited",func(): status = "game")
			$CanvasLayer/task.show()
			# spieler darf sich während die task UI offen ist nicht bewegen
			$player.player_speed = 0
			$player.player_sprint_speed = 0
		if $CanvasLayer/task.visible:     # falls task ui bereits existiert wird sie versteckt
			# task ui verstecken, spieler bewegung wieder aktivieren
			$CanvasLayer/task.hide()
			$player.player_speed = 300
			$player.player_sprint_speed = 600
		else:
			# task ui zeigen und spieler bewegung deaktivieren
			$CanvasLayer/task.show()
			$player.player_speed = 0
			$player.player_sprint_speed = 0

func switch_room(new_room):
	var sound_effect = load("res://assets/sound effecs/scream.mp3")
	sound_player.stream = sound_effect
	sound_player.play()
	$current_room.set_name("old_room")
	# löschung des alten zimmers 
	# umbenennung auf "old_room" sodass das neue zimmer sofort auf "current_room" umbenannt werden kann
	$old_room.queue_free()
	# die task UI-szene soll zwischen räumen gelöscht und später mit anderen aufgaben neu geladen werden
	if(get_node_or_null("CanvasLayer/task") != null):
		get_node("CanvasLayer/task").queue_free()
	# erstellung und umbenennung der neuen szene
	var new_instance = load(new_room).instantiate()
	add_child(new_instance)
	get_node(String(new_instance.get_name())).set_name("current_room")


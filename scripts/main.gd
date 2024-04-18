extends Node2D

var main_scene
var main_instance
var player_scene
var player_instance
var status

# Called when the node enters the scene tree for the first time.
func _ready():
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
	
	pause_button_container.get_node("Button").connect("pressed", get_node("CanvasLayer/pause_menu").hide)
	pause_button_container.get_node("Button2").connect("pressed", close_game)
	pause_button_container.get_node("Button3").connect("pressed", get_tree().quit)

func start_game():
	# versteckt das main menu und zeigt stattdessen den spieler und das momentane zimmer
	# noch hinzufügen: spielfortschritt speichern
	$CanvasLayer/main_menu.hide()
	status = "game"
	
	$current_room.show()
	$player.show()
	$player/CanvasLayer.show()
	
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
	if Input.is_action_just_pressed("pause") && (status == "game") && !get_node_or_null("CanvasLayer/task").visible:
		if $CanvasLayer/pause_menu.visible:
			$CanvasLayer/pause_menu.hide()
			$player.player_speed = 300
			$player.player_sprint_speed = 600
		else:
			$CanvasLayer/pause_menu.show()
			$player.player_speed = 0
			$player.player_sprint_speed = 0
	
	# beendet das schreiben im aufgaben-menü wenn ESC gedrückt wird
	if Input.is_action_just_pressed("pause") && (status == "game_typing"):
		$CanvasLayer/task/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/LineEdit.release_focus()
	
	# erstellt/öffnet/schließt die task UI wenn E gedrückt wird
	# (solange der spieler nicht bereits in der task ui schreibt)
	if Input.is_action_just_pressed("task") && (status == "game") && !$CanvasLayer/pause_menu.visible:
		if(get_node_or_null("CanvasLayer/task") == null):
			# erstellung neuer task UI-szene
			var task_scene = load("res://scenes/task_scene_template.tscn").instantiate()
			$CanvasLayer.add_child(task_scene)
			$CanvasLayer.get_node(String(task_scene.get_name())).set_name("task")
			$CanvasLayer/task/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/LineEdit.connect("focus_entered",set_status_to_game_typing)
			$CanvasLayer/task/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/LineEdit.connect("focus_exited",set_status_to_game)
			$CanvasLayer/task.show()
			# spieler darf sich während die task UI offen ist nicht bewegen
			$player.player_speed = 0
			$player.player_sprint_speed = 0
		elif $CanvasLayer/task.visible:     # falls task ui bereits existiert wird sie versteckt
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

# diese funktionen werden in der task UI verwendet, 
# weil man variablen mit signalen nicht direkt verändern kann und 
# keine eingabeparameter im connect-befehl angeben kann
# [...].connect("pressed", status = "game_typing") ist nicht erlaubt
# (status = "game_typing" ist kein Callable) 
func set_status_to_game_typing():
	status = "game_typing"
func set_status_to_game():
	status = "game"


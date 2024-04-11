extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func switch_task_and_input():
	var text_vboxcontainer = $PanelContainer/MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer
	if !text_vboxcontainer.get_node("Label").visible:
		text_vboxcontainer.get_node("Label").show()
		text_vboxcontainer.get_node("TextEdit").hide()
		$PanelContainer/MarginContainer/VBoxContainer/Button.text = "Input zeigen"
	else:
		text_vboxcontainer.get_node("Label").hide()
		text_vboxcontainer.get_node("TextEdit").show()
		$PanelContainer/MarginContainer/VBoxContainer/Button.text = "Aufgabenstellung zeigen"

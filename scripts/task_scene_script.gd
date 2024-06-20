extends Control


var solution
var task_text
var task_input
var task_output
# task_output ist die LineEdit node, die den input des spielers beinhält
# ich habe sie "output" genannt weil der name "input" für den input, den der spieler kriegt, besser passt
signal task_correct
signal task_ready_finished

func _ready():
	#$AnimationPlayer.play("new_animation")
	var vboxcontainer = $PanelContainer/MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer
	task_text = vboxcontainer.get_node("Label")
	task_input = vboxcontainer.get_node("TextEdit")
	task_output = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/LineEdit
	
	$PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/Button.connect("pressed",func():check_for_solution(task_output.text))
	

func _process(_delta):
	pass

func switch_task_and_input():
	# wechselt sichtbarkeit zwischen dem Aufgabentext und dem Input-text
	# die größe des jeweiligen textfeldes wird automatisch durch control-nodes bestimmt
	if !task_text.visible:
		task_text.show()
		task_input.hide()
		$PanelContainer/MarginContainer/VBoxContainer/Button.text = "Input zeigen"
	else:
		task_text.hide()
		task_input.show()
		$PanelContainer/MarginContainer/VBoxContainer/Button.text = "Aufgabenstellung zeigen"

func check_for_solution(new_text):
	if solution == null: pass
	
	if(new_text == solution):
		task_correct.emit()
		if(task_output.has_focus()):
			task_output.release_focus()
	else:
		pass

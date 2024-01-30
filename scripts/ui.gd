extends Control

var lineEdit
var label

# Called when the node enters the scene tree for the first time.
func _ready():
	var colorRect = ColorRect.new()
	colorRect.color = Color(180,180,180, 0.5)
	colorRect.size = Vector2(1152,648)
	add_child(colorRect)
	
	var button = Button.new()
	button.text = "Confirm"
	button.set_position(Vector2(128,576))
	button.pressed.connect(self._button_pressed)
	add_child(button)
	
	lineEdit = LineEdit.new()
	lineEdit.size = Vector2(900, 30)
	lineEdit.position = Vector2(130, 500)
	lineEdit.select_all()
	add_child(lineEdit)
	
	label = Label.new()
	label.autowrap_mode = true
	label.text = ("Berechne die Summe der Zahlen 29 und 42") 
	label.position = Vector2(150, 50)
	label.size = Vector2(800,40)
	add_child(label)	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _button_pressed():
	isInputCorrect()
	
func isInputCorrect():
	lineEdit.select_all()
	if(lineEdit.get_selected_text() == "71"):
		label.text = "CORRECT"
		return 1
	else:
		label.text = "FALSE"
		return 0

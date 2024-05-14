extends Node

# array mit booleans für jede aufgabe im spiel
var task_arr

func _ready():
	# lade task_dict mit FileAccess
	var file = FileAccess.open("user://progress.dat",FileAccess.READ)
	if(file != null):
		# hier task_arr von progress.dat laden
		pass
	else:
		# task_arr erstellen
		task_arr = Array()
		
	
	pass

func finish_task():
	# funktion zum verändern des task_arr
	pass

func save_progress():
	var file = FileAccess.open("user://progress.dat",FileAccess.READ_WRITE)
	# speichere task_arr zu progress.dat
	# (irgendwie)

func _process(_delta):
	pass


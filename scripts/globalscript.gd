extends Node

# array mit booleans für jede aufgabe im spiel
var task_arr
# array zur verknüpfung zwischen räumen und aufgaben in task_arr
# WICHTIG: index eines raumes im room_arr ist der index dessen aufgabe im task_arr!
var room_arr

func _ready():
	room_arr = []
	# lade task_arr mit FileAccess
	var file = FileAccess.open("user://progress.dat",FileAccess.READ)
	if(file != null):
		# hier task_arr von progress.dat laden
		pass
	else:
		# task_arr erstellen
		task_arr = Array()
		task_arr.resize(room_arr.size())
	

func finish_task(room_path):
	print(room_path)
	pass

func save_progress():
	var file = FileAccess.open("user://progress.dat",FileAccess.READ_WRITE)
	# speichere task_arr zu progress.dat
	# (irgendwie)

func _process(_delta):
	pass


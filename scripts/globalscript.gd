extends Node

# array mit booleans für jede aufgabe im spiel
var task_arr
# array zur verknüpfung zwischen räumen und aufgaben in task_arr
# WICHTIG: index eines raumes im room_arr ist der index dessen aufgabe im task_arr!
var room_arr

func _ready():
	room_arr = []
	# lade task_arr mit FileAccess
	if(FileAccess.file_exists("user://progress.dat")):
		var file = FileAccess.open("user://progress.dat",FileAccess.READ)
		var content = file.get_as_text()
	else:
		# task_arr erstellen
		task_arr = Array()
		task_arr.resize(room_arr.size())
	

func finish_task(room_path):
	print(room_path)
	print("^^ Aufgabe richtig !!")
	pass

func save_progress():

	if(!FileAccess.file_exists("user://progress.dat")):
		FileAccess.open("user://progress.dat",FileAccess.WRITE)
	var file = FileAccess.open("user://progress.dat",FileAccess.READ_WRITE)
	file.store_string("hello world!")
	file.close()
	# speichere task_arr zu progress.dat
	# (irgendwie)

func _process(_delta):
	pass


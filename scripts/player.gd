extends CharacterBody2D

const player_speed = 300
const player_sprint_speed = 600
var speed
signal switch_room(path)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_pressed("sprint"):
		speed = player_sprint_speed
	else:
		speed = player_speed
	if Input.is_action_pressed("ui_left"):
		velocity += Vector2.LEFT
	if Input.is_action_pressed("ui_right"):
		velocity += Vector2.RIGHT
	if Input.is_action_pressed("ui_up"):
		velocity += Vector2.UP
	if Input.is_action_pressed("ui_down"):
		velocity += Vector2.DOWN
	
	velocity = velocity.normalized() * speed
	move_and_slide()
	velocity=Vector2(0,0)
	
	if(get_last_slide_collision()!=null):
		var collider = get_last_slide_collision().get_collider()
		if(collider.has_meta("path")):
			print("Hat Path")
			switch_room.emit(collider.get_meta("path"))
		pass
	

#called every frame, used for physics stuff
func _physics_process(_delta):
	pass

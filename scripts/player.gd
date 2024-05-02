extends CharacterBody2D

var player_speed = 300
var player_sprint_speed = 600
signal switch_room(path)

func _ready():
	pass 

func _process(_delta):
	var speed
	if(is_visible()):
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
				switch_room.emit(collider.get_meta("path"))

func _physics_process(_delta):
	pass

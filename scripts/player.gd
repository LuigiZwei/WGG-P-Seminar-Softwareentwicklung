extends CharacterBody2D

var player_speed
signal switch_room

# Called when the node enters the scene tree for the first time.
func _ready():
	player_speed = 300
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_pressed("ui_left"):
		velocity += player_speed * Vector2.LEFT
	if Input.is_action_pressed("ui_right"):
		velocity += player_speed * Vector2.RIGHT
	if Input.is_action_pressed("ui_up"):
		velocity += player_speed * Vector2.UP
	if Input.is_action_pressed("ui_down"):
		velocity += player_speed * Vector2.DOWN
	if !Input.is_anything_pressed():
		velocity = Vector2.ZERO
	move_and_slide()
	velocity=Vector2(0,0)
	
	if(get_last_slide_collision()!=null):
		print(get_last_slide_collision().get_collider_rid().get_id() )
		if(get_last_slide_collision().get_collider_rid().get_id() == 4170413244417):
			emit_signal("switch_room")
		pass
	

#called every frame, used for physics stuff
func _physics_process(_delta):
	pass

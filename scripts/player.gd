extends CharacterBody2D

var player_speed
signal switch_room(path)

# Called when the node enters the scene tree for the first time.
func _ready():
	player_speed = 50000

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_left"):
		velocity += Vector2.LEFT
	if Input.is_action_pressed("ui_right"):
		velocity += Vector2.RIGHT
	if Input.is_action_pressed("ui_up"):
		velocity += Vector2.UP
	if Input.is_action_pressed("ui_down"):
		velocity += Vector2.DOWN
	if !Input.is_anything_pressed():
		velocity = Vector2.ZERO
	velocity = velocity.normalized() * player_speed * delta
	move_and_slide()
	velocity = Vector2(0,0)
	
	if(get_last_slide_collision() != null ):
		var collider = get_last_slide_collision().get_collider()
		if(collider.has_meta("path")):
			switch_room.emit(collider.get_meta("path"))

#called every frame, used for physics stuff
func _physics_process(_delta):
	pass
	
func get_player_collider():
	if(get_last_slide_collision() != null ):
		return get_last_slide_collision().get_collider()

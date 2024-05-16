extends CharacterBody2D

var player_speed = 300
var player_sprint_speed = 600
signal switch_room(path)
@onready var animated_sprite = $AnimatedSprite2D

func _ready():
	pass 

func _process(_delta):
	var speed
	if(is_visible()):
		if Input.is_action_pressed("sprint"):
			speed = player_sprint_speed
			animated_sprite.speed_scale = 2
		else:
			speed = player_speed
			animated_sprite.speed_scale = 1
			
		if Input.is_action_pressed("left"):
			velocity += Vector2.LEFT
			animated_sprite.play("left")
		if Input.is_action_pressed("right"):
			velocity += Vector2.RIGHT
			animated_sprite.play("right")
		if Input.is_action_pressed("up"):
			velocity += Vector2.UP
			animated_sprite.play("up")
		if Input.is_action_pressed("down"):
			velocity += Vector2.DOWN
			animated_sprite.play("down")
			
		if velocity.is_zero_approx():
			animated_sprite.stop()
		
		velocity = velocity.normalized() * speed
		move_and_slide()
		velocity=Vector2(0,0)
	
		if(get_last_slide_collision()!=null):
			var collider = get_last_slide_collision().get_collider()
			if(collider.has_meta("path")):
				switch_room.emit(collider.get_meta("path"))

func _physics_process(_delta):
	pass

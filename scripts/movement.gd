extends CharacterBody2D

var player_speed = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_left"):
		move_and_collide(Vector2.LEFT * player_speed * delta)
	if Input.is_action_pressed("ui_right"):
		move_and_collide(Vector2.RIGHT * player_speed * delta)
	if Input.is_action_pressed("ui_up"):
		move_and_collide(Vector2.UP * player_speed * delta)
	if Input.is_action_pressed("ui_down"):
		move_and_collide(Vector2.DOWN * player_speed * delta)

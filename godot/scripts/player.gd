extends CharacterBody2D

var speed 
var has_collided

# Called when the node enters the scene tree for the first time.
func _ready():
	has_collided = false
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func get_input(): #movement
	var input_direction = Input.get_vector("left", "right", "up", "down") # WASD and arrow keys
	var is_Sprinting = Input.is_action_pressed("sprint") #shift for faster movement
	if(is_Sprinting):
		speed = 1000
	else:
		speed = 400
	velocity = input_direction * speed

#called every frame, used for physics stuff
func _physics_process(_delta):
	
	get_input()
	move_and_slide()
	
	var collision_count = get_slide_collision_count() # counts the amount of collisions
	
	if(collision_count > 0 && has_collided == false ):# doing something once as soon as a collision happens 
		#!WILL BREAK! after adding more nodes HAVE TO FIX
		var collision = get_last_slide_collision()
		var collider_id = collision.get_collider_id() #can and will BREAK very easily ( will be fixed soon), as soon as there are more nodes
		if(collider_id == 27967620325): # collider_id of the door collision
			var path = get_parent() 
			path.switch_room("res://scenes/room2.tscn")      
			has_collided = true

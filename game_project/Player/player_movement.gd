extends CharacterBody2D

const FRICTION = 500
const ACCELERATION = 500
const MAX_SPEED = 80

var animator = null
var player_transform = null
var direction = 'null'

func _ready():
	animator = $AnimationPlayer
	player_transform = $Sprite2D

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		
		_animation_handeler(input_vector.x, input_vector.y)
			
		velocity += input_vector * ACCELERATION * delta
		velocity = velocity.limit_length(MAX_SPEED)  
		
	else:
		
		_animation_handeler(input_vector.x, input_vector.y)	
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
	move_and_slide()
	
func _animation_handeler(x, y):
	
	
	if y < 0: #if going upward 
		animator.play("move_up")
		direction = 'upwards'
	
	if y > 0: #if going downward
		animator.play("move_down")
		direction = 'downwards'
	
	if x > 0 && y == 0: #if going rightward
			player_transform.set_flip_h(false)
			animator.play("move_right")
			direction = 'rightwards'
			
	if x < 0 && y == 0: #if going leftward
			
		player_transform.set_flip_h(true)
		animator.play("move_right")	
		direction = 'leftwards'
		
		#idle(s)
	
	if x == 0 && y == 0 && direction == 'rightwards':
		player_transform.set_flip_h(false)
		animator.play("idle_right")
		
	if x == 0 && y == 0 && direction == 'leftwards':
		player_transform.set_flip_h(true)
		animator.play("idle_right")
		
	if x == 0 && y == 0 && direction == 'upwards':
		player_transform.set_flip_h(true)
		animator.play("idle_up")
		
	if x == 0 && y == 0 && direction == 'downwards':
		player_transform.set_flip_h(true)
		animator.play("idle_down")
		
	
		


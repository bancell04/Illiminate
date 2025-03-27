extends CharacterBody2D

const MOTION_SPEED = 160 # Pixels/second.


func _physics_process(delta):
	var motion = Vector2()
	motion.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	motion.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	motion.y /= 2
	velocity = motion.normalized() * MOTION_SPEED
	
	print(velocity.x)
	print(velocity.y)
	
	#warning-ignore:return_value_discarded
	position += velocity * delta

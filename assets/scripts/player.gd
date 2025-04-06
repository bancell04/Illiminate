extends CharacterBody2D

const MOTION_SPEED = 160 # Pixels/second.


func _physics_process(delta):
	var motion = Vector2()
	motion.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	motion.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	motion.y /= 2
	
	
	# update animation
	if (motion.x > 0):
		if (motion.y > 0):
			$AnimatedSprite2D.play("walking_southeast")
		elif (motion.y < 0):
			$AnimatedSprite2D.play("walking_northeast")
		elif (motion.y == 0):
			$AnimatedSprite2D.play("walking_east")
	elif (motion.x < 0):
		if (motion.y > 0):
			$AnimatedSprite2D.play("walking_southwest")
		elif (motion.y < 0):
			$AnimatedSprite2D.play("walking_northwest")
		elif (motion.y == 0):
			$AnimatedSprite2D.play("walking_west")
	elif (motion.x == 0):
		if (motion.y > 0):
			$AnimatedSprite2D.play("walking_south")
		elif (motion.y < 0):
			$AnimatedSprite2D.play("walking_north")
		elif (motion.y == 0):
			$AnimatedSprite2D.play("idle_south")
			 
			
	velocity = motion.normalized() * MOTION_SPEED
	
	move_and_slide()

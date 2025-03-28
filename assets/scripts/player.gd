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
			$AnimatedSprite2D.play("walking_down_right")
		elif (motion.y < 0):
			$AnimatedSprite2D.play("walking_up_right")
		elif (motion.y == 0):
			$AnimatedSprite2D.play("walking_right")
	elif (motion.x < 0):
		if (motion.y > 0):
			$AnimatedSprite2D.play("walking_down_left")
		elif (motion.y < 0):
			$AnimatedSprite2D.play("walking_up_left")
		elif (motion.y == 0):
			$AnimatedSprite2D.play("walking_left")
	elif (motion.x == 0):
		if (motion.y > 0):
			$AnimatedSprite2D.play("walking_down")
		elif (motion.y < 0):
			$AnimatedSprite2D.play("walking_up")
		elif (motion.y == 0):
			$AnimatedSprite2D.play("idle")
			 
			
	velocity = motion.normalized() * MOTION_SPEED
	
	#print(velocity.x)
	#print(velocity.y)
	
	move_and_slide()

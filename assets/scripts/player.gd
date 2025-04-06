extends CharacterBody2D

const MOTION_SPEED = 160 # Pixels/second.

enum Direction {
	NORTH,
	NORTHEAST,
	EAST,
	SOUTHEAST,
	SOUTH,
	SOUTHWEST,
	WEST,
	NORTHWEST
}

func _physics_process(delta):
	var motion = Vector2()
	motion.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	motion.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	motion.y /= 2
	
	# GET DIRECTION PLAYER IS FACING
	var angle
	var angleDeg = rad_to_deg((get_global_mouse_position() - global_position).angle())
	if angleDeg < 0:
		angleDeg += 360
	
	if (angleDeg > 337.5 || angleDeg <= 22.5):
		angle = Direction.EAST
	elif (angleDeg > 22.5 && angleDeg <= 67.5):
		angle = Direction.SOUTHEAST
	elif (angleDeg > 67.5 && angleDeg <= 112.5):
		angle = Direction.SOUTH
	elif (angleDeg > 112.5 && angleDeg <= 157.5):
		angle = Direction.SOUTHWEST
	elif (angleDeg > 157.5 && angleDeg <= 202.5):
		angle = Direction.WEST
	elif (angleDeg > 202.5 && angleDeg <= 247.5):
		angle = Direction.NORTHWEST
	elif (angleDeg > 247.5 && angleDeg <= 292.5):
		angle = Direction.NORTH
	elif (angleDeg > 292.5 && angleDeg <= 337.5):
		angle = Direction.NORTHEAST
		
		
	var moving = motion.x != 0 || motion.y != 0
	if moving:
		match angle:
			Direction.EAST:
				$CharacterSprite.play("walking_east")
			Direction.SOUTHEAST:
				$CharacterSprite.play("walking_southeast")
			Direction.SOUTH:
				$CharacterSprite.play("walking_south")
			Direction.SOUTHWEST:
				$CharacterSprite.play("walking_southwest")
			Direction.WEST:
				$CharacterSprite.play("walking_west")
			Direction.NORTHWEST:
				$CharacterSprite.play("walking_northwest")
			Direction.NORTH:
				$CharacterSprite.play("walking_north")
			Direction.NORTHEAST:
				$CharacterSprite.play("walking_northeast")
	else:
		match angle:
			Direction.EAST:
				$CharacterSprite.play("idle_east")
			Direction.SOUTHEAST:
				$CharacterSprite.play("idle_southeast")
			Direction.SOUTH:
				$CharacterSprite.play("idle_south")
			Direction.SOUTHWEST:
				$CharacterSprite.play("idle_southwest")
			Direction.WEST:
				$CharacterSprite.play("idle_west")
			Direction.NORTHWEST:
				$CharacterSprite.play("idle_northwest")
			Direction.NORTH:
				$CharacterSprite.play("idle_north")
			Direction.NORTHEAST:
				$CharacterSprite.play("idle_northeast")
			
	velocity = motion.normalized() * MOTION_SPEED
	
	move_and_slide()

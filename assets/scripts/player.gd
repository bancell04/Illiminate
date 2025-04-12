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
	
	
	# DIRECTION PLAYER IS MOVING
	var motionAngle
	var motionAngleDeg = rad_to_deg(motion.angle())
	if motionAngleDeg < 0:
		motionAngleDeg += 360
	print(motionAngleDeg)
	if (motionAngleDeg > 337.5 || motionAngleDeg <= 22.5):
		motionAngle = Direction.EAST
	elif (motionAngleDeg > 22.5 && motionAngleDeg <= 67.5):
		motionAngle = Direction.SOUTHEAST
	elif (motionAngleDeg > 67.5 && motionAngleDeg <= 112.5):
		motionAngle = Direction.SOUTH
	elif (motionAngleDeg > 112.5 && motionAngleDeg <= 157.5):
		motionAngle = Direction.SOUTHWEST
	elif (motionAngleDeg > 157.5 && motionAngleDeg <= 202.5):
		motionAngle = Direction.WEST
	elif (motionAngleDeg > 202.5 && motionAngleDeg <= 247.5):
		motionAngle = Direction.NORTHWEST
	elif (motionAngleDeg > 247.5 && motionAngleDeg <= 292.5):
		motionAngle = Direction.NORTH
	elif (motionAngleDeg > 292.5 && motionAngleDeg <= 337.5):
		motionAngle = Direction.NORTHEAST
		
		
	# GET DIRECTION PLAYER IS FACING
	var lookAngle
	var angleDeg = rad_to_deg((get_global_mouse_position() - global_position).angle())
	if angleDeg < 0:
		angleDeg += 360
	if (angleDeg > 337.5 || angleDeg <= 22.5):
		lookAngle = Direction.EAST
	elif (angleDeg > 22.5 && angleDeg <= 67.5):
		lookAngle = Direction.SOUTHEAST
	elif (angleDeg > 67.5 && angleDeg <= 112.5):
		lookAngle = Direction.SOUTH
	elif (angleDeg > 112.5 && angleDeg <= 157.5):
		lookAngle = Direction.SOUTHWEST
	elif (angleDeg > 157.5 && angleDeg <= 202.5):
		lookAngle = Direction.WEST
	elif (angleDeg > 202.5 && angleDeg <= 247.5):
		lookAngle = Direction.NORTHWEST
	elif (angleDeg > 247.5 && angleDeg <= 292.5):
		lookAngle = Direction.NORTH
	elif (angleDeg > 292.5 && angleDeg <= 337.5):
		lookAngle = Direction.NORTHEAST
		
	
	var motionMultiplier = 1
	var moving = motion.x != 0 || motion.y != 0
	if moving:
		match lookAngle:
			Direction.EAST:
				$CharacterSprite.play("walking_east")
				if motionAngle == Direction.WEST:
					motionMultiplier = .7
					print("WORKING")
			Direction.SOUTHEAST:
				$CharacterSprite.play("walking_southeast")
				if motionAngle == Direction.NORTHWEST:
					motionMultiplier = .7
			Direction.SOUTH:
				$CharacterSprite.play("walking_south")
				if motionAngle == Direction.NORTH:
					motionMultiplier = .7
			Direction.SOUTHWEST:
				$CharacterSprite.play("walking_southwest")
				if motionAngle == Direction.NORTHEAST:
					motionMultiplier = .7
			Direction.WEST:
				$CharacterSprite.play("walking_west")
				if motionAngle == Direction.EAST:
					motionMultiplier = .7
			Direction.NORTHWEST:
				$CharacterSprite.play("walking_northwest")
				if motionAngle == Direction.SOUTHEAST:
					motionMultiplier = .7
			Direction.NORTH:
				$CharacterSprite.play("walking_north")
				if motionAngle == Direction.SOUTH:
					motionMultiplier = .7
				
			Direction.NORTHEAST:
				$CharacterSprite.play("walking_northeast")
				if motionAngle == Direction.SOUTHWEST:
					motionMultiplier = .7
	else:
		match lookAngle:
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
			
	velocity = motion.normalized() * MOTION_SPEED * motionMultiplier
	
	move_and_slide()

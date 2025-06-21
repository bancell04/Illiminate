extends CharacterBody2D
const Direction = Globals.Direction

const MOTION_SPEED = 160 # Pixels/second.

var lookDirection;
var walkDirection;
var armed = false;
var spritePrefix = "";
var weapon_instance;

func _ready():		
	weapon_instance = preload("res://assets/scenes/weapon.tscn").instantiate()
	weapon_instance.get_child(0).player = self
	weapon_instance.visible = false;
	add_child(weapon_instance)
	

func _physics_process(_delta):
	var motion = Vector2()
	motion.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	motion.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	motion.y /= 2
	
	# Armed logic
	if Input.is_action_just_pressed("interact"):
		self.armed = !self.armed
		if self.armed:
			weapon_instance.visible = true
			self.spritePrefix = "armed_" 
		else:
			self.spritePrefix = "" 
			weapon_instance.visible = false
	
	
	# DIRECTION PLAYER IS MOVING
	var motionAngleDeg = rad_to_deg(motion.angle())
	if motionAngleDeg < 0:
		motionAngleDeg += 360
	if (motionAngleDeg > 337.5 || motionAngleDeg <= 22.5):
		walkDirection = Globals.Direction.EAST
	elif (motionAngleDeg > 22.5 && motionAngleDeg <= 67.5):
		walkDirection = Direction.SOUTHEAST
	elif (motionAngleDeg > 67.5 && motionAngleDeg <= 112.5):
		walkDirection = Direction.SOUTH
	elif (motionAngleDeg > 112.5 && motionAngleDeg <= 157.5):
		walkDirection = Direction.SOUTHWEST
	elif (motionAngleDeg > 157.5 && motionAngleDeg <= 202.5):
		walkDirection = Direction.WEST
	elif (motionAngleDeg > 202.5 && motionAngleDeg <= 247.5):
		walkDirection = Direction.NORTHWEST
	elif (motionAngleDeg > 247.5 && motionAngleDeg <= 292.5):
		walkDirection = Direction.NORTH
	elif (motionAngleDeg > 292.5 && motionAngleDeg <= 337.5):
		walkDirection = Direction.NORTHEAST
		
		
	# GET DIRECTION PLAYER IS FACING
	var angleDeg = rad_to_deg((get_global_mouse_position() - global_position).angle())
	if angleDeg < 0:
		angleDeg += 360
	if (angleDeg > 337.5 || angleDeg <= 22.5):
		lookDirection = Direction.EAST
	elif (angleDeg > 22.5 && angleDeg <= 67.5):
		lookDirection = Direction.SOUTHEAST
	elif (angleDeg > 67.5 && angleDeg <= 112.5):
		lookDirection = Direction.SOUTH
	elif (angleDeg > 112.5 && angleDeg <= 157.5):
		lookDirection = Direction.SOUTHWEST
	elif (angleDeg > 157.5 && angleDeg <= 202.5):
		lookDirection = Direction.WEST
	elif (angleDeg > 202.5 && angleDeg <= 247.5):
		lookDirection = Direction.NORTHWEST
	elif (angleDeg > 247.5 && angleDeg <= 292.5):
		lookDirection = Direction.NORTH
	elif (angleDeg > 292.5 && angleDeg <= 337.5):
		lookDirection = Direction.NORTHEAST
		
	
	var motionMultiplier = 1
	var moving = motion.x != 0 || motion.y != 0
	if moving:
		match lookDirection:
			Direction.EAST:
				$CharacterSprite.play(self.spritePrefix + "walking_east")
				if walkDirection == Direction.WEST:
					motionMultiplier = .7
			Direction.SOUTHEAST:
				$CharacterSprite.play(self.spritePrefix + "walking_southeast")
				if walkDirection == Direction.NORTHWEST:
					motionMultiplier = .7
			Direction.SOUTH:
				$CharacterSprite.play(self.spritePrefix + "walking_south")
				if walkDirection == Direction.NORTH:
					motionMultiplier = .7
			Direction.SOUTHWEST:
				$CharacterSprite.play(self.spritePrefix + "walking_southwest")
				if walkDirection == Direction.NORTHEAST:
					motionMultiplier = .7
			Direction.WEST:
				$CharacterSprite.play(self.spritePrefix + "walking_west")
				if walkDirection == Direction.EAST:
					motionMultiplier = .7
			Direction.NORTHWEST:
				$CharacterSprite.play(self.spritePrefix + "walking_northwest")
				if walkDirection == Direction.SOUTHEAST:
					motionMultiplier = .7
			Direction.NORTH:
				$CharacterSprite.play(self.spritePrefix + "walking_north")
				if walkDirection == Direction.SOUTH:
					motionMultiplier = .7
			Direction.NORTHEAST:
				$CharacterSprite.play(self.spritePrefix + "walking_northeast")
				if walkDirection == Direction.SOUTHWEST:
					motionMultiplier = .7
	else:
		match lookDirection:
			Direction.EAST:
				$CharacterSprite.play(self.spritePrefix + "idle_east")
			Direction.SOUTHEAST:
				$CharacterSprite.play(self.spritePrefix + "idle_southeast")
			Direction.SOUTH:
				$CharacterSprite.play(self.spritePrefix + "idle_south")
			Direction.SOUTHWEST:
				$CharacterSprite.play(self.spritePrefix + "idle_southwest")
			Direction.WEST:
				$CharacterSprite.play(self.spritePrefix + "idle_west")
			Direction.NORTHWEST:
				$CharacterSprite.play(self.spritePrefix + "idle_northwest")
			Direction.NORTH:
				$CharacterSprite.play(self.spritePrefix + "idle_north")
			Direction.NORTHEAST:
				$CharacterSprite.play(self.spritePrefix + "idle_northeast")
			
	velocity = motion.normalized() * MOTION_SPEED * motionMultiplier
	
	move_and_slide()

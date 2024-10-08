extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -400.0
var batDown = false
@export var currentBall = RigidBody2D
var balls = [RigidBody2D]
var maxBallCheckCooldown = 10
var currentBallCheckCooldown = 0;
@onready var win_screen = get_tree().get_first_node_in_group("winS")
signal caught()
signal treasureFound()
var step_amount = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _process(delta):
	$Bat.look_at(get_global_mouse_position())
	balls = get_tree().get_nodes_in_group("ball")
	win_screen = get_tree().get_first_node_in_group("winS")
	

func _physics_process(delta):
	if $treasure_detect.has_overlapping_bodies():
		win_screen.visible = true
		treasureFound.emit()
	# Add the gravity.
	if $Area2D.has_overlapping_bodies():
		for body in $Area2D.get_overlapping_bodies():
			for ball in balls:
				if body == ball and currentBallCheckCooldown == 0 and currentBall == null:
					currentBall = ball
					currentBall.linear_damp = 10
					caught.emit()
	
	if currentBall != null:
		currentBall.linear_damp = 0
		currentBall.linear_velocity = velocity
		currentBall.get_child(1).visible = false
	
	if currentBallCheckCooldown != 0:
		currentBallCheckCooldown -= 1
		
	if Input.is_action_just_pressed("shoot"):
		HandleBat()
	if !batDown:
		$AnimationPlayer_Bat.play("idle_1")
	if batDown:
		$AnimationPlayer_Bat.play("Idle_2")
	
	var Xaxis = Input.get_axis("move_left", "move_right")
	var Yaxis = Input.get_axis("move_down", "move_up")
	if Xaxis:
		velocity.x = Xaxis * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if Yaxis:
		velocity.y = -Yaxis * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
		
	if position.x - get_global_mouse_position().x < 0:
		$Sprite2D.flip_h = false
	else:
		$Sprite2D.flip_h = true

	if Xaxis != 0 or Yaxis != 0:
		var rng = RandomNumberGenerator.new()
		step_amount+=1
		if step_amount == 1:
			var randomStep = rng.randi_range(0,2)
			if randomStep == 0:
				$step_1.play()
			elif randomStep == 1:
				$step_2.play()
			else:
				$step_3.play()
		if step_amount%36 == 0:
			var randomStep = rng.randi_range(0,2)
			if randomStep == 0:
				$step_1.play()
			elif randomStep == 1:
				$step_2.play()
			else:
				$step_3.play()
	else:
		step_amount = 0

	move_and_slide()
		
	
	
func HandleBat():
	if !batDown:
		$AnimationPlayer_Bat.play("Swing_down")
	else:
		$AnimationPlayer_Bat.play("Swing_up")	
	if currentBall != null:
		currentBall.apply_central_impulse((get_global_mouse_position() - position).normalized() *100)
		currentBall.linear_damp = 0.5
		currentBallCheckCooldown = maxBallCheckCooldown
		currentBall.get_child(1).visible = true
		
		#currentBall.linear_velocity = (get_viewport().get_mouse_position() - position).normalized() * 10
	currentBall = null
	batDown = !batDown
	
	

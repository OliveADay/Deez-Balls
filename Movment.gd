extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -400.0
var batDown = false
@export var currentBall = RigidBody2D
var balls = [RigidBody2D]
var maxBallCheckCooldown = 10
var currentBallCheckCooldown = 0;
@onready var world = get_tree().get_first_node_in_group('World')
@onready var win_screen = get_tree().get_first_node_in_group("winS")
@onready var lvl = get_tree().get_first_node_in_group("lvl")
signal caught()
signal treasureFound()
var step_amount = 0
var startEnemyAmount = 0
var scoreFilePath = "user://score.cfg"
var bestStory = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	startEnemyAmount = get_tree().get_nodes_in_group('enemy').size()
	get_parent().get_child(3).position = lvl.centerRect+Vector2(0,-20)
	LoadBStory()
	

func _process(delta):
	$Bat.look_at(get_global_mouse_position())
	world = get_tree().get_first_node_in_group('World')
	balls = get_tree().get_nodes_in_group("ball")
	win_screen = get_tree().get_first_node_in_group("winS")
	

func _physics_process(delta):
	lvl = get_tree().get_first_node_in_group("lvl")
	if get_tree().get_nodes_in_group('enemy').size() > 0:
		$treasure_detect.monitoring = false
		get_parent().get_child(2).visible = false
		get_parent().get_child(3).get_child(0).text = ''
	else:
		var prefix = ''
		if (world.lvlCurrent+1)%10 == 1:
			prefix = 'st'
		elif (world.lvlCurrent+1)%10 == 2:
			prefix = 'nd'
		elif (world.lvlCurrent+1)%10 == 3:
			prefix = 'rd'
		else:
			prefix = 'th'
		get_parent().get_child(3).get_child(0).text =  "Go to "+str(world.lvlCurrent+1)+prefix +" story"
		$treasure_detect.monitoring = true
		get_parent().get_child(2).visible = true
		get_parent().get_child(3).visible = true
		get_parent().get_child(2).position = lvl.centerRect#invalid access to property or key 'centerRect' on a base object of type 'previously freed'
		get_parent().get_child(3).position = lvl.centerRect+Vector2(0,-20)
		
	if $death_detect.has_overlapping_bodies():
		get_tree().reload_current_scene()
	
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
		currentBall.get_child(2).visible = false
		currentBall.get_child(3).visible = false
		currentBall.get_child(4).visible = false
		currentBall.get_child(2).texture_scale=2
		currentBall.get_child(3).texture_scale=1
	
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
	saveBStory()
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
		currentBall.get_child(4).visible = true
		#currentBall.linear_velocity = (get_viewport().get_mouse_position() - position).normalized() * 10
	currentBall = null
	batDown = !batDown
	
func saveBStory():
	var config = ConfigFile.new()
	if bestStory < world.lvlCurrent:
		bestStory = world.lvlCurrent
		config.set_value('main','bestStory',bestStory)
		config.save(scoreFilePath)
		
func LoadBStory():
	var config = ConfigFile.new()
	var error = config.load(scoreFilePath)
	if error != OK:
		bestStory = 0
		return
	bestStory=config.get_value('main','bestStory')
	

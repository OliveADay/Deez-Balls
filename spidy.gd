extends RigidBody2D

var rng = RandomNumberGenerator.new()
var player_seen = false
var player_seen_prev = false
var attack_mode = false
var attack_prev_mode = false
var animationTime=2
var startPos = Vector2(0,0)
var startRect = Rect2i()
var timeframe_max = 1
var timeframe = 0
var attackSpeed = 1.7
var spreadSpeed = 8
var inRect = true
var intervalM = 1.5
var interval = 0.3
var timeBefreturn=0
var ball_seen
var ball:Node2D
@onready var player= get_tree().get_first_node_in_group("player")
@onready var world = get_tree().get_first_node_in_group("World")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player= get_tree().get_first_node_in_group("player")
	world = get_tree().get_first_node_in_group("World")
	ball = get_tree().get_first_node_in_group("ball(global)")
	var rotation_start = rng.randi_range(0,360)
	rotation = rotation_start
	position = startPos # Replace with function body
	timeframe_max -= world.enemy_subtract_notice_time
	attackSpeed+=world.enemy_add_speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var posi = Vector2i(int(position.x/16),int(position.y/16))
	if player != null:
		var playerPos = Vector2i(int(player.position.x/16),int(player.position.y/16))
		if startRect.has_point(playerPos) and startRect.has_point(posi):
			player_seen = true
		else:
			player_seen=false
			if ball != null:
				var ballPos = Vector2i(int(ball.position.x/16),int(ball.position.y/16))
				if startRect.has_point(ballPos) and startRect.has_point(posi):
					ball_seen=true
				else:
					ball_seen=false
			else:
				ball=get_tree().get_first_node_in_group("ball(global)")
			
	else:
		player= get_tree().get_first_node_in_group("player")
	
	if player_seen and not player_seen_prev:
		timeframe = timeframe_max
		$AudioStreamPlayer2D2.play()
	
	if timeframe > 0:
		$PointLight2D3.visible=false
		attack_mode =false
		timeframe-=delta
		$PointLight2D.visible=true
		$PointLight2D3.visible=true
		$PointLight2D.texture_scale+=delta*spreadSpeed
	elif player_seen:
		attack_mode = true
	else:
		if attack_prev_mode:
			timeBefreturn=3
			attack_prev_mode = false
		if timeBefreturn > 0:
			timeBefreturn-=delta
		if timeBefreturn <=0:
			attack_mode=false
		if abs(position.x - startPos.x) <= 2:
			$PointLight2D.visible=true
			$PointLight2D3.visible=true
	if attack_mode:
		look_at(player.position)
		$AnimationPlayer.play("walk")
		if interval > 0:
			interval-=delta
			$PointLight2D3.visible=false
		else:
			interval = intervalM
			$PointLight2D3.visible=true
	elif abs(position.x - startPos.x) > 2:
		$AnimationPlayer.play("walk")
		look_at(startPos)
	elif timeframe <=0:
		if $PointLight2D.texture_scale >2:
			$PointLight2D.texture_scale-=delta*spreadSpeed
		
	#if attack_mode and not attack_prev_mode:
		#$AudioStreamPlayer2D.play()
	
	
	if not player_seen:
		var i = rng.randi_range(0,2)
		var idles = ['idle','idle_2','idle_3']
		if animationTime > 0:
			animationTime-=delta
		else:
			$AnimationPlayer.play(idles[i])
			animationTime=2
	if timeBefreturn <= 0:
		attack_prev_mode = attack_mode
	else:
		attack_prev_mode = false
	player_seen_prev = player_seen
	
	if $Area2D.has_overlapping_bodies():
		get_parent().get_child(1).play()
		queue_free()
		
	
func _physics_process(delta: float) -> void:
	var direction = Vector2(0,0)
	if attack_mode:
		direction = Vector2(player.position.x - position.x,player.position.y-position.y).normalized()*attackSpeed
		if timeBefreturn > 0:
			direction= Vector2(0,0)
	if ball_seen:
		direction = Vector2(-(ball.position.x-position.x),-(ball.position.y-position.y)).normalized()
		
	elif abs(position.x - startPos.x) > 2:
		direction = Vector2(startPos.x - position.x,startPos.y-position.y).normalized()
	move_and_collide(direction)

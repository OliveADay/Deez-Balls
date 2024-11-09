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
@onready var player= get_tree().get_first_node_in_group("player")
@onready var world = get_tree().get_first_node_in_group("World")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player= get_tree().get_first_node_in_group("player")
	world = get_tree().get_first_node_in_group("World")
	var rotation_start = rng.randi_range(0,360)
	rotation = rotation_start
	position = startPos # Replace with function body
	if world.enemy_subtract_notice_time <= timeframe_max:
		timeframe_max = world.enemy_subtract_notice_time
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
	else:
		player= get_tree().get_first_node_in_group("player")
	
	if player_seen and not player_seen_prev:
		timeframe = timeframe_max
		$AudioStreamPlayer2D2.play()
	
	if timeframe > 0:
		attack_mode =false
		timeframe-=delta
		$PointLight2D.visible=true
		$PointLight2D2.visible=true
		$PointLight2D3.visible=true
		$PointLight2D.texture_scale+=delta*spreadSpeed
		$PointLight2D2.texture_scale+=delta*spreadSpeed
	elif player_seen:
		attack_mode = true
		$PointLight2D.texture_scale=2
		$PointLight2D2.texture_scale=1
		$PointLight2D.visible=false
		$PointLight2D2.visible=false
		$PointLight2D3.visible=false
	else:
		attack_mode = false
		$PointLight2D.texture_scale=2
		$PointLight2D2.texture_scale=0.3
		if abs(position.x - startPos.x) <= 2:
			$PointLight2D.visible=true
			$PointLight2D2.visible=true
			$PointLight2D3.visible=true
	if attack_mode:
		look_at(player.position)
		$AnimationPlayer.play("walk")
	elif abs(position.x - startPos.x) > 2:
		$AnimationPlayer.play("walk")
		look_at(startPos)
		
	if attack_mode and not attack_prev_mode:
		$AudioStreamPlayer2D.play()
	
	
	if not player_seen:
		var i = rng.randi_range(0,2)
		var idles = ['idle','idle_2','idle_3']
		if animationTime > 0:
			animationTime-=delta
		else:
			$AnimationPlayer.play(idles[i])
			animationTime=2
	attack_prev_mode = attack_mode
	player_seen_prev = player_seen
	
	if $Area2D.has_overlapping_bodies():
		get_parent().get_child(1).play()
		queue_free()
		
	
func _physics_process(delta: float) -> void:
	var direction = Vector2(0,0)
	if attack_mode:
		direction = Vector2(player.position.x - position.x,player.position.y-position.y).normalized()*attackSpeed
	elif abs(position.x - startPos.x) > 2:
		direction = Vector2(startPos.x - position.x,startPos.y-position.y).normalized()
	move_and_collide(direction)

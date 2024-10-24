extends RigidBody2D

var rng = RandomNumberGenerator.new()
var player_seen = false
var player_seen_prev = false
var attack_mode = false
var attack_prev_mode = false
var animationTime=2
var startPos = Vector2(0,0)
var startRect = Rect2i()
var timeframe = 0
var spreadSpeed = 4
var inRect = true
@onready var player= get_tree().get_first_node_in_group("player")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var rotation_start = rng.randi_range(0,360)
	rotation = rotation_start
	position = startPos # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var playerPos = Vector2i(int(player.position.x/16),int(player.position.y/16))
	var posi = Vector2i(int(position.x/16),int(position.y/16))
	if startRect.has_point(playerPos) and startRect.has_point(posi):
		player_seen = true
	else:
		player_seen=false
	
	if player_seen and not player_seen_prev:
		timeframe = 2
	
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
	var direction = Vector2(player.position.x - position.x,player.position.y-position.y)
	if attack_mode:
		if not attack_prev_mode and inRect:
			add_constant_central_force(direction.normalized()*3)
		look_at(player.position)
		$AnimationPlayer.play("walk")
	
	
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

extends RigidBody2D

var rng = RandomNumberGenerator.new()
var player_seen = false
var player_seen_prev = false
var animationTime=2
var startPos = Vector2(0,0)
var startRect = Rect2i()
var timeframe = 0
var spreadSpeed = 4
@onready var player= get_tree().get_first_node_in_group("player")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var rotation_start = rng.randi_range(0,360)
	rotation = rotation_start
	position = startPos # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var playerPos = Vector2i(int(player.position.x/16),int(player.position.y/16))
	if startRect.has_point(playerPos):
		player_seen = true
	else:
		player_seen=false
	
	if timeframe > 0:
		timeframe-=delta
		$PointLight2D.texture_scale+=delta*spreadSpeed
		$PointLight2D2.texture_scale+=delta*spreadSpeed
	elif player_seen:
		$PointLight2D.texture_scale=2
		$PointLight2D2.texture_scale=0.3
		$PointLight2D.visible=false
		$PointLight2D2.visible=false
	else:
		$PointLight2D.texture_scale=2
		$PointLight2D2.texture_scale=0.3
	
	if player_seen and not player_seen_prev:
		timeframe = 2
	if not player_seen:
		var i = rng.randi_range(0,2)
		var idles = ['idle','idle_2','idle_3']
		if animationTime > 0:
			animationTime-=delta
		else:
			$AnimationPlayer.play(idles[i])
			animationTime=2
			
	player_seen_prev = player_seen

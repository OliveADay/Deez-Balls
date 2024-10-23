extends RigidBody2D

var rng = RandomNumberGenerator.new()
var player_seen = false
var animationTime=2
var startPos = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var rotation_start = rng.randi_range(0,360)
	rotation = rotation_start
	position = startPos # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not player_seen:
		var i = rng.randi_range(0,2)
		var idles = ['idle','idle_2','idle_3']
		if animationTime > 0:
			animationTime-=delta
		else:
			$AnimationPlayer.play(idles[i])
			animationTime=2

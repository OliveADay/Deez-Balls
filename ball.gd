extends RigidBody2D
var timeFrame = 0
var speed=8
var scoreFilePath = "user://score.cfg"
var saveBounceBonus = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	var config = ConfigFile.new()
	var error = config.load(scoreFilePath)
	if error != OK:
		saveBounceBonus = 0
	elif config.get_value('main','bounceBonus') != OK:
		saveBounceBonus = 0
		config.set_value('main','bounceBonus', 0)
	else:
		saveBounceBonus = config.get_value('main','bounceBonus') # Replace with function body.
		
	physics_material_override.bounce+=saveBounceBonus


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if timeFrame > 0:
		timeFrame -= delta
		$PointLight2D.texture_scale+=delta*speed
		$PointLight2D2.texture_scale+=delta*speed
	else:
		$PointLight2D.texture_scale=2
		$PointLight2D2.texture_scale=1
		$PointLight2D.visible=false
		$PointLight2D2.visible=false


func _on_body_entered(body: Node) -> void:
	if body.is_in_group('tilemap'):
		$PointLight2D.texture_scale=2
		$PointLight2D2.texture_scale=1
		$PointLight2D.visible=true
		$PointLight2D2.visible=true
		$AudioStreamPlayer2D.play()
		timeFrame=1

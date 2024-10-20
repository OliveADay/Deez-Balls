extends RigidBody2D
var timeFrame = 0
var speed=8
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


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
		$PointLight2D.visible=true
		$PointLight2D2.visible=true
		timeFrame=1

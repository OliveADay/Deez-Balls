extends PointLight2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if energy< 1.2:
		energy = lerp(0.8,1.2, 0.1)
	elif energy >= 1.2:
		energy=lerp(1.2,0.8, 0.1)

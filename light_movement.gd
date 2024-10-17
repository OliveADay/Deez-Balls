extends PointLight2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if texture_scale< 1.2:
		texture_scale = lerp(0.8,2.0, 0.1)
	elif energy >= 1.2:
		texture_scale=lerp(2.0,0.8, 0.1)

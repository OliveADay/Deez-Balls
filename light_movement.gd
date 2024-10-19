extends PointLight2D

@export var scale_min=0.4
@export var scale_max=1.2

var prevIncreasing = false
var increasing=false
var decreasing = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if texture_scale< 1.2 and not decreasing:
		texture_scale+=delta
		increasing = true
	if texture_scale<0.4:
		decreasing=false
	if texture_scale >= 1.2:
		increasing = false
		decreasing = true
	if decreasing:
		texture_scale-=delta
		
	prevIncreasing = true

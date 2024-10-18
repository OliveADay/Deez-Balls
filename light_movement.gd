extends PointLight2D

var prevIncreasing = false
var increasing=false
var decreasing = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if texture_scale< 2 and not decreasing:
		texture_scale+=delta
		increasing = true
		print('increasing')
	if texture_scale<0.8:
		decreasing=false
	if texture_scale >= 2:
		texture_scale-=delta
		increasing = false
		print('decreasing')
		
	if not increasing and prevIncreasing:
		decreasing = true
		
	prevIncreasing = true

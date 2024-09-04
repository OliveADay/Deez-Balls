extends Node2D
var rectTest = Rect2i(0,0,10,10)
var rectTest_inter = Rect2i(1,1, 8, 8)
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for y in 257:
		for x in 257:
			if rectTest.has_point(Vector2i(x-128,y-128)) and !rectTest_inter.has_point(Vector2i(x-128,y-128)):
				var opening = rng.randf_range(1, 8 * 2) #replace 8 with rect width once that is figured out, currently just testing
				if opening == 1:
					opening = -1
				else:
					opening = 0
				$TileMap/Layer1.set_cell(Vector2i(x-128,y-128), opening, Vector2i(0,0)) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

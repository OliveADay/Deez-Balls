extends Node2D
var rectTest = Rect2i(0,0,10,10)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for y in 255:
		for x in 255:
			if rectTest.has_point(Vector2i(x,y)):
				$TileMap/Layer1.set_cell(Vector2i(x,y), 0, Vector2i(0,0)) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

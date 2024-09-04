extends Node2D
var rectTest = Rect2i(0,0,10,10)
var rectTest_inter = Rect2i(1,1, 8, 8)
var rng = RandomNumberGenerator.new()
var GridAttempts
var rectTests: Array[Rect2i] = []
var rectTests_inter: Array[Rect2i] = []
var rectAttempts = 5
var rectMinsandMaxes = [-64,64, 5, 10]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in rectAttempts:
		var rectpos = rng.randi_range(rectMinsandMaxes[0],rectMinsandMaxes[1])
		var rectsize = rng.randi_range(rectMinsandMaxes[2],rectMinsandMaxes[3])
		var recti = Rect2i(rectpos, rectpos, rectsize,rectsize)
		var colliding_other_rects = false
		for b in range(rectTests_inter.size()):
			if rectTests_inter[b].intersects(recti):
				colliding_other_rects = true
		if !colliding_other_rects:
			rectTests_inter.append(recti)
	
	for y in 257:
		for x in 257:
			if rectTest.has_point(Vector2i(x-128,y-128)) and !rectTest_inter.has_point(Vector2i(x-128,y-128)):
				var opening = rng.randi_range(1, 8*2) #replace 8 with rect width once that is figured out, currently just testing
				var cellId = 0
				if opening == 2:
					cellId = 2
				else:
					cellId = 0
				$TileMap/Layer1.set_cell(Vector2i(x-128,y-128), cellId, Vector2i(0,0)) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

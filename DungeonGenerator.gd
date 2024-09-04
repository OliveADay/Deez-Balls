extends Node2D
var rectTest = Rect2i(0,0,10,10)
var rectTest_inter = Rect2i(1,1, 8, 8)
var rng = RandomNumberGenerator.new()
var GridAttempts
var rectTests: Array[Rect2i] = []
var rectTests_inter: Array[Rect2i] = []
var rectAttempts = 1000
var rectMinsandMaxes = [-64,64, 5, 10]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in rectAttempts:
		var rectpos = Vector2i(rng.randi_range(rectMinsandMaxes[0],rectMinsandMaxes[1]), rng.randi_range(rectMinsandMaxes[0],rectMinsandMaxes[1]))
		var rectsize = [rng.randi_range(rectMinsandMaxes[2],rectMinsandMaxes[3]), rng.randi_range(rectMinsandMaxes[2],rectMinsandMaxes[3])]
		var recti = Rect2i(rectpos.x, rectpos.y, rectsize[0],rectsize[1])
		var colliding_other_rects = false
		for b in range(rectTests.size()):
			if rectTests[b].intersects(recti):
				colliding_other_rects = true
		if !colliding_other_rects:
			rectTests.append(recti)
			var rectinner = Rect2i(recti.position.x+1, recti.position.y+1, recti.size.x-2, recti.size.y-2)
			rectTests_inter.append(rectinner)
	
	for y in 257:
		for x in 257:
			var inRect = false
			for i in range(rectTests.size()):				
				if rectTests[i].has_point(Vector2i(x-128,y-128)):
					var opening = rng.randi_range(1, rectTests[i].size.x * 2) #replace 8 with rect width once that is figured out, currently just testing
					var cellId = 0
					if opening == 2:
						cellId = -1
					else:
						cellId = -1
						
					$TileMap/Layer1.set_cell(Vector2i(x-128,y-128), cellId, Vector2i(0,0)) # Replace with function body.
					inRect = true
			if !inRect:
				$TileMap/Layer1.set_cell(Vector2i(x-128,y-128), 0, Vector2i(0,0))
					


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

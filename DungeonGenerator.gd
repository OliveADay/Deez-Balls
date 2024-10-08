extends Node2D
var rectTest = Rect2i(0,0,10,10)
var rectTest_inter = Rect2i(1,1, 8, 8)
var rng = RandomNumberGenerator.new()
var GridAttempts
var rectTests: Array[Rect2i] = []
var rectTests_inter: Array[Rect2i] = []
@export var rectAttempts = 5000
var rectMinsandMaxes = [-64,64, 7, 20]
signal nextLevel()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var rectpos_1 = Vector2i(-2,-2)
	var rectsize_1 = [rng.randi_range(rectMinsandMaxes[2],rectMinsandMaxes[3]), rng.randi_range(rectMinsandMaxes[2],rectMinsandMaxes[3])]
	
	var rect_1 = Rect2i(rectpos_1.x, rectpos_1.y, rectsize_1[0], rectsize_1[1])
	var rect_1_outer = Rect2i(rectpos_1.x -1, rectpos_1.y -1, rectsize_1[0] + 2, rectsize_1[1] + 2)
	rectTests.append(rect_1)
	rectTests_inter.append(rect_1)
	
	
	for i in rectAttempts:
		var rectpos = Vector2i(rng.randi_range(rectMinsandMaxes[0],rectMinsandMaxes[1]), rng.randi_range(rectMinsandMaxes[0],rectMinsandMaxes[1]))
		var rectsize = [rng.randi_range(rectMinsandMaxes[2],rectMinsandMaxes[3]), rng.randi_range(rectMinsandMaxes[2],rectMinsandMaxes[3])]
		var recti = Rect2i(rectpos.x, rectpos.y, rectsize[0],rectsize[1])
		var colliding_other_rects = false
		var nextTo_Otherrects = false
		for b in range(rectTests.size()):
			var outerRect = Rect2i(rectTests[b].position.x -1, rectTests[b].position.y -1, rectTests[b].size.x  +2, rectTests[b].size.y  +2)
			if rectTests[b].intersects(recti):
				colliding_other_rects = true
			if outerRect.intersection(recti).size.x > 1:
				nextTo_Otherrects = true
			
		if !colliding_other_rects and nextTo_Otherrects:
			rectTests.append(recti)
		
	var randomer = RandomNumberGenerator.new()
	var index = randomer.randi_range(0,rectTests.size() -1)
	var rectFin = rectTests[index]
		
			#var rectinner = Rect2i(recti.position.x+1, recti.position.y+1, recti.size.x-2, recti.size.y-2)
			#rectTests_inter.append(rectinner)
	
	#for rect in rectTests.size()-1:
		#var rectIntersects = 0;
		#var outerRect = Rect2i(rectTests[rect+1].position.x-1, rectTests[rect+1].position.y-1, rectTests[rect+1].size.x+2, rectTests[rect+1].size.y+2)
		#for rectChecked in rectTests.size()-1:
		#	if outerRect.intersects(rectTests[rectChecked+1]):
		#		rectIntersects +=1
		#if rectIntersects > 2:
		#	rectTests_inter.append(rectTests[rect +1])
	#print(rectTests_inter.size())
	
	for y in 257:
		for x in 257:
			var inRect = false
			for i in range(rectTests.size()):				
				if rectTests[i].has_point(Vector2i(x-128,y-128)):					
					if rectTests[i] == rectFin:
						if Vector2i(x-128,y-128) == rectFin.get_center():
							$TileMap/Layer1.set_cell(Vector2i(x-128,y-128), 0, Vector2i(0,1))
						elif abs((x-128)-rectFin.get_center().x) < 2 and abs((y-128)-rectFin.get_center().y) < 2:
							$TileMap/Layer1.set_cell(Vector2i(x-128,y-128), 0, Vector2i(1,0))						
					else:
						$TileMap/Layer1.set_cell(Vector2i(x-128,y-128), -1, Vector2i(0,0))
					inRect = true
			if !inRect:
				pass
				$TileMap/Layer1.set_cell(Vector2i(x-128,y-128), 0, Vector2i(0,0))
				
	#for y in 257: so this seems to have made tiles that were surrounded by 2 empty tiles either directly above and below or right and left of a tile, that tile would then erase itself
		#for x in 257:
			#if $TileMap/Layer1.get_cell_source_id(Vector2i(x-128,y-128)) == 0:
				#if $TileMap/Layer1.get_cell_source_id(Vector2i(x-127,y-128)) != 0 and $TileMap/Layer1.get_cell_source_id(Vector2i(x-129,y-128)) != 0:
					#$TileMap/Layer1.set_cell(Vector2i(x-128,y-128), -1, Vector2i(0,0))
				#if $TileMap/Layer1.get_cell_source_id(Vector2i(x-128,y-127)) != 0 and $TileMap/Layer1.get_cell_source_id(Vector2i(x-128,y-129)) != 0:
					#$TileMap/Layer1.set_cell(Vector2i(x-128,y-128), -1, Vector2i(0,0))
					


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _n_lvl() -> void:
	nextLevel.emit()

extends Node2D

const lvl_paths = ["L_1.tscn","L_2.tscn","L_3.tscn","L_4.tscn","L_5.tscn","L_6.tscn","L_7.tscn","L_8.tscn","L_9.tscn","L_10.tscn"]
var lvls = []
var lvlCurrent = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in lvl_paths.size():
		ResourceLoader.load_threaded_request(lvl_paths[i]) # Replace with function body.
		lvls.append(ResourceLoader.load_threaded_get(lvl_paths[i]).instantiate())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _nLvl() -> void:
	if lvlCurrent < lvls.size():
		if(lvlCurrent > 0):
			lvls[lvlCurrent - 1].queue_free()
		add_child(lvls[lvlCurrent])
		if lvlCurrent+1 == lvls.size():
			$AudioStreamPlayer2D2.play()
		else:
			$AudioStreamPlayer2D.play()
		lvlCurrent +=1
	
	

extends Node2D

const lvl_path = "L_1.tscn"
var lvls = []
var lvlCurrent = 0
var current_rect_attempts = 1000
var current_spidy_chance = 4
var rng = RandomNumberGenerator.new()
var money = 0
var ball_add_bounce = 0
var ball_add_speed = 0
var ball_add_brightness = 0
var ball_add_torque = 0
var enemy_add_spawn = 0
var enemy_subtract_notice_time = 0
var enemy_add_speed = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
		ResourceLoader.load_threaded_request(lvl_path) # Replace with function body.
		lvls.append(ResourceLoader.load_threaded_get(lvl_path).instantiate())
		ResourceLoader.load_threaded_request(lvl_path)
		lvls.append(ResourceLoader.load_threaded_get(lvl_path).instantiate())


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
		_newLvl()
	print(lvlCurrent)
		
func _newLvl() -> void:
	ResourceLoader.load_threaded_request(lvl_path)
	var lvl = ResourceLoader.load_threaded_get(lvl_path).instantiate()
	var i = rng.randi_range(1,2)
	if i ==1:
		if current_spidy_chance > 0:
			current_spidy_chance-=1
	else:
		current_rect_attempts+=100
		
	lvl.spidyChance = current_spidy_chance
	lvl.rectAttempts = current_rect_attempts
	
	lvls.append(lvl)
		
		
	
	
	

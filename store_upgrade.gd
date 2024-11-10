extends Button
var rng = RandomNumberGenerator.new() 
var upgradeIndex = 0
var txt = 'upgrade'
var cost = 0
var world:Node2D
var warning_time = 0
@export var modificationMode=0
var isUpgrade = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if modificationMode != 0 and modificationMode!=1:
		modificationMode = rng.randi_range(0,1)
	if modificationMode ==0:
		isUpgrade = true
	elif modificationMode==1:
		isUpgrade=false
	world = get_tree().get_first_node_in_group("World")
	upgradeIndex = rng.randi_range(1,3)
	if isUpgrade:
		if upgradeIndex == 1:
			txt = 'increase bounce   '
		elif upgradeIndex == 2:
			txt = 'increase speed    '
		else:
			txt = 'increase spin     '
	else:
		if upgradeIndex==1:
			txt= "increase tastiness "
		elif upgradeIndex==2:
			txt="increase infestation"
		else:
			txt='increase scent      '
	cost = rng.randi_range(1,2)
	
	if isUpgrade:
		text = txt + " -" + str(cost)
	else:
		text = txt + " +" + str(cost)
	
func _process(delta: float) -> void:
	if warning_time > 0:
		warning_time-=delta
		get_parent().get_child(1).visible=true
	else:
		get_parent().get_child(1).visible=false


func _on_pressed() -> void:
	if isUpgrade:
		if world.money >= cost:
			world.money-=cost
			if upgradeIndex == 1:
				world.ball_add_bounce+=0.2*cost
			elif upgradeIndex == 2:
				world.ball_add_speed++0.2*cost
			else:
				world.ball_add_torque +=30*cost
		else:
			warning_time=2
	else:
		world.money+=cost
		if upgradeIndex==1:
			world.enemy_add_speed +=10*cost
		elif upgradeIndex==2:
			world.enemy_add_spawn+=1*cost
		else:
			world.enemy_subtract_notice_time+=0.1*cost
	visible = false

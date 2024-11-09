extends Button
var rng = RandomNumberGenerator.new() 
var upgradeIndex = 0
var txt = 'upgrade'
var cost = 0
var world:Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	world = get_tree().get_first_node_in_group("World")
	upgradeIndex = rng.randi_range(1,3)
	if upgradeIndex == 1:
		txt = 'increase bounce'
	elif upgradeIndex == 2:
		txt = 'increase speed '
	else:
		txt = 'increase spin  '
	cost = rng.randi_range(1,2)
	
	text = txt + " " + str(cost)


func _on_pressed() -> void:
	if world.money < cost:
		return # Replace with function body.

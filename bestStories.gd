extends Node2D
var scoreFilePath = "user://score.cfg"
@onready var world = get_tree().get_first_node_in_group('World')
var bestStory = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	world = get_tree().get_first_node_in_group("World")
	var config = ConfigFile.new()
	var error = config.load(scoreFilePath)
	if error != OK:
		bestStory = 0
	else:
		bestStory = config.get_value('main','bestStory')
	get_parent().text = 'Highest Story Travelled To: ' + str(bestStory)  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

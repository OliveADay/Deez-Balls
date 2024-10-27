extends Node2D
var scoreFilePath = "user://score.save"
@onready var world = get_tree().get_first_node_in_group('World')
var bestStory = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	world = get_tree().get_first_node_in_group("World")
	if FileAccess.file_exists(scoreFilePath):
		var file = FileAccess.open(scoreFilePath, FileAccess.READ)
		bestStory = file.get_var(true)
		print(FileAccess.get_file_as_string(scoreFilePath))
		print(FileAccess.get_open_error())
	if bestStory == null:
		bestStory = 0
		print(FileAccess.get_file_as_string(scoreFilePath))
		print(FileAccess.get_open_error())
	get_parent().text = 'Highest Story Travelled To: ' + str(bestStory)  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

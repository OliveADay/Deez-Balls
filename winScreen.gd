extends CanvasLayer
@onready var world = get_tree().get_first_node_in_group("World")
var startOnce = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_player_body_treasure_found() -> void:
	if !startOnce:
		$Timer.start()
		startOnce = true


func _on_timer_timeout() -> void:
	world._nLvl()
	
func _reload() -> void:
	var _reload = get_tree().reload_current_scene()

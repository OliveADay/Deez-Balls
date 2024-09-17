extends Button

var keypressedOnce = false
@onready var world = get_tree().get_first_node_in_group("World")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tween = create_tween().set_loops() # Replace with function body.
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property(get_parent(), "rotation_degrees", 3, 1.5)
	#tween.tween_interval(2)
	tween.tween_property(get_parent(), "rotation_degrees", -3, 3) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	if !keypressedOnce:
		$AudioStreamPlayer2D3.play()
		var tween = create_tween()
		tween.set_ease(Tween.EASE_IN)
		tween.set_trans(Tween.TRANS_EXPO)
		tween.tween_property(get_parent(), "position", Vector2(317, -40), 1)
		$Timer.start()
		keypressedOnce = true # Replace with function body.


func _on_timer_timeout() -> void:
	visible = false
	world._nLvl() # Replace with function body.

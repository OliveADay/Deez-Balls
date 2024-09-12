extends Label

var keypressedOnce = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tween = create_tween().set_loops() # Replace with function body.
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property(get_parent(), "rotation_degrees", 2, 1.5)
	#tween.tween_interval(2)
	tween.tween_property(get_parent(), "rotation_degrees", -2, 3) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	if !keypressedOnce:
		var tween = create_tween()
		tween.set_ease(Tween.EASE_IN)
		tween.set_trans(Tween.TRANS_EXPO)
		tween.tween_property(get_parent(), "position", Vector2(317, -20), 1)
		keypressedOnce = true

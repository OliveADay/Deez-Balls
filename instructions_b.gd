extends Button

var button_pd = false
var keypressedOnce = false
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
	if not button_pd:
		get_parent().get_parent().get_child(4).visible = true
	else:
		get_parent().get_parent().get_child(4).visible = false
		
	$AudioStreamPlayer2D3.play()
		
	button_pd = !button_pd


func _on_button_pressed() -> void:
	if not keypressedOnce:
		var tween = create_tween()
		tween.set_ease(Tween.EASE_IN)
		tween.set_trans(Tween.TRANS_EXPO)
		tween.tween_property(get_parent(), "position", Vector2(317, -40), 1) # Replace with function body.
		keypressedOnce = true

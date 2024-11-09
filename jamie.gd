extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if $Area2D.has_overlapping_bodies():
		$Control.visible = true
	else:
		$Control.visible = false


func _on_button_pressed() -> void:
	$Control/Button.visible = false
	$Control/VBoxContainer.visible = true

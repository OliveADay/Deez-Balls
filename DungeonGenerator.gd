extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$TileMap/Layer1.set_cell(Vector2i(0,5), 0, Vector2i(0,0)) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

extends RigidBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if linear_velocity.x < 0.1 and linear_velocity.x != 0:
		linear_damp = 0

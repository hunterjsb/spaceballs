extends Sprite2D

@export var mass  = 100_000
@export var rotation_speed = 1.0  # Degrees per second

func _process(delta):
	# Rotate Earth
	rotation_degrees += rotation_speed * delta

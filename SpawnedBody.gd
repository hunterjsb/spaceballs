# SpawnedBody.gd
extends GravitationalBody

func _ready():
	super._ready()
	mass = randf_range(10, 2500)
	radius = mass / 50
	add_sprite()  # Call this to add the sprite
	
	# Customize the sprite (optional)
	if sprite:
		sprite.modulate = Color(randf(), randf(), randf())  # Random color

extends GravitationalBody

var visual: ColorRect

func _ready():
	mass = randf_range(10, 2500)  # Random mass
	radius = 10  # Fixed radius for simplicity
	
	# Create a visual representation
	visual = ColorRect.new()
	visual.set_size(Vector2(radius * 2, radius * 2))
	visual.set_position(Vector2(-radius, -radius))  # Center the rect on the body's position
	visual.color = Color(randf(), randf(), randf())  # Random color
	add_child(visual)

func _process(delta):
	# Update the visual to match the body's rotation
	visual.rotation = -rotation  # Negative to counter the body's rotation

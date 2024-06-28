extends ParallaxLayer

@export var star_density = 0.0001  # Stars per pixel squared
@export var star_color = Color(1, 1, 1, 0.8)  # White with slight transparency

var max_zoom = 6.0  # Match this with your camera's max_zoom
var viewport_size: Vector2

func _ready():
	viewport_size = get_viewport().size
	generate_stars()

func generate_stars():
	# Calculate the area to fill with stars
	var area = viewport_size * max_zoom
	var star_count = int(area.x * area.y * star_density)

	randomize()
	for i in range(star_count):
		var star = ColorRect.new()
		star.color = star_color
		
		# Randomize star size between 1 and 3 pixels
		var star_size = randf_range(1, 3)
		star.size = Vector2(star_size, star_size)
		
		star.position = Vector2(
			randf_range(-viewport_size.x * (max_zoom - 1), viewport_size.x * max_zoom),
			randf_range(-viewport_size.y * (max_zoom - 1), viewport_size.y * max_zoom)
		)
		add_child(star)

	# Set the motion scale to create a parallax effect
	motion_scale = Vector2(0.95, 0.95)

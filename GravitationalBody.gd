# GravitationalBody.gd
extends Area2D

class_name GravitationalBody

@export var mass: float = 1.0
@export var radius: float = 10.0  # We'll keep this for easy reference and scaling
var velocity: Vector2 = Vector2.ZERO

var sprite: Sprite2D
var collision_shape: CollisionShape2D

func _ready():
	setup_body()

func setup_body():
	# Create and add CollisionShape2D
	collision_shape = CollisionShape2D.new()
	var circle_shape = CircleShape2D.new()
	circle_shape.radius = radius
	collision_shape.shape = circle_shape
	add_child(collision_shape)
	
func add_sprite(texture_path: String = "res://assets/moon_4.png"):
	# Create and add Sprite2D
	sprite = Sprite2D.new()
	sprite.texture = load(texture_path)
	sprite.scale = Vector2(radius / sprite.texture.get_width(), radius / sprite.texture.get_height()) * 2
	add_child(sprite)

func apply_force(force: Vector2):
	velocity += force / mass

func move(delta: float):
	position += velocity * delta

func gravitational_force(other: GravitationalBody) -> Vector2:
	var direction = other.position - position
	var distance = direction.length()
	var force_magnitude = (mass * other.mass) / (distance * distance)
	return direction.normalized() * force_magnitude

func _physics_process(delta):
	move(delta)

func area_entered(area: Area2D):
	print("AREA ENTERED")
	if area is GravitationalBody:
		handle_collision(area)

func handle_collision(area: GravitationalBody):
	# Implement collision logic here
	print("Collision between %s and %s" % [name, area.name])
	# might want to merge bodies, destroy smaller ones, or apply damage

extends Area2D
class_name GravBody

@export var mass: float = 1.0
@export var radius: float = 10.0
@export var texture: Texture2D
var velocity: Vector2 = Vector2.ZERO

var sprite: Sprite2D
var collision_shape: CollisionShape2D

func _ready():
	sprite = get_node_or_null("Sprite2D")
	collision_shape = get_node_or_null("CollisionShape2D")
	
	if not sprite:
		create_sprite()
	if not collision_shape:
		create_collision_shape()

func create_sprite():
	sprite = Sprite2D.new()
	add_child(sprite)

func create_collision_shape():
	collision_shape = CollisionShape2D.new()
	var circle_shape = CircleShape2D.new()
	circle_shape.radius = radius
	collision_shape.shape = circle_shape
	add_child(collision_shape)

func apply_force(force: Vector2):
	velocity += force / mass

func move(delta: float):
	position += velocity * delta

func gravitational_force(other: GravBody) -> Vector2:
	var direction = other.position - position
	var distance = direction.length()
	var force_magnitude = (mass * other.mass) / (distance * distance)
	return direction.normalized() * force_magnitude

func _physics_process(delta):
	move(delta)

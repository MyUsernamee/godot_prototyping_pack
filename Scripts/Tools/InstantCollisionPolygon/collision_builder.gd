extends Polygon2D

## This script is used to create a collision polygon for a Polygon2D node.
## It simply is a helper script that behaves exactly like a Polygon2D, but has collisions at runtime.

class_name CollisionBuilder


var collision_polygon: CollisionPolygon2D

func _ready():
	
	build_collision_polygon()


func build_collision_polygon():

	collision_polygon = CollisionPolygon2D.new()
	add_child(StaticBody2D.new())
	get_child(0).add_child(collision_polygon)
	
	collision_polygon.polygon = polygon
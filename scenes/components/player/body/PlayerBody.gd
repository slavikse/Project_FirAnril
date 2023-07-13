extends Area3D
class_name PlayerBody

var _gravitation_script := preload('./scripts/gravitation.gd').new()
var _movement_script := preload('./scripts/movement.gd').new()

#@onready var _collision_node := $Collision as CollisionShape3D

# todo звук скольжения по стене (царапает?)

func movement(is_floor: bool, is_wall: bool, velocity: Vector3, move_direction: Vector3, delta: float) -> Vector3:
    velocity = _gravitation_script.gravitation(is_floor, is_wall, velocity, delta)
    return _movement_script.apply_to_movement(move_direction, velocity, delta)

func _on_body_entered(barrier_node: StaticBody3D) -> void:
    if barrier_node is FloorsBricks:
        print('barrier_node', barrier_node)

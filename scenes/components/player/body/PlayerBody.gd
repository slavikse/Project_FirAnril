extends Area3D
class_name PlayerBody

var _gravitation_script := preload('./scripts/gravitation.gd').new()
var _movement_script := preload('./scripts/movement.gd').new()
var _is_bounce_buffer := false

# todo звук скольжения по стене (царапает?)

func movement(is_floor: bool, is_wall: bool, velocity: Vector3, move_direction: Vector3, delta: float) -> Vector3:
    velocity = _gravitation_script.gravitation(is_floor, is_wall, velocity, delta)
    return _movement_script.apply_to_movement(move_direction, velocity, delta)

func _on_body_entered(body_node: StaticBody3D) -> void:
    if body_node.is_in_group(GConst.GROUPS.WALL):
        _is_bounce_buffer = true

func _on_body_exited(body_node: StaticBody3D) -> void:
    if body_node.is_in_group(GConst.GROUPS.WALL):
        _is_bounce_buffer = false

func _on_area_entered(body_node: Area3D) -> void:
    if body_node.is_in_group(GConst.GROUPS.INTERACTIVE):
        body_node.start_interact()

func _on_area_exited(body_node: Area3D) -> void:
    if body_node.is_in_group(GConst.GROUPS.INTERACTIVE):
        body_node.end_interact()

func has_bounce_buffer(is_floor: bool) -> bool:
    if is_floor:
        _is_bounce_buffer = false
    return _is_bounce_buffer

extends Node3D
class_name PlayerLegs

const _JUMP_VELOCITY := 7.5

var _quantity_bounces := 0

func jumping(is_floor: float, is_on_wall: float, velocity: Vector3) -> Vector3:
    if Input.is_action_just_pressed('jump'):
        velocity = _touched_wall(is_on_wall, velocity)
        velocity = _touched_floor(is_floor, velocity)
    return velocity

func _touched_wall(is_on_wall: float, velocity: Vector3) -> Vector3:
    if is_on_wall and _quantity_bounces > 0:
        velocity.y = _JUMP_VELOCITY
        _quantity_bounces -= 1
    return velocity

func _touched_floor(is_floor: float, velocity: Vector3) -> Vector3:
    if is_floor:
        velocity.y = _JUMP_VELOCITY
        _quantity_bounces = 1
    return velocity

extends Node3D
class_name PlayerBody

const _GRAVITY := 16.0
const _SLOWING_DOWN_FALL := 0.1
const _MOVE_SPEED := 220.0

# todo звук скольжения по стене (царапает?)

func movement(is_floor: bool, is_wall: bool, velocity: Vector3, move_direction: Vector3, delta: float) -> Vector3:
    velocity = _gravitation(is_floor, is_wall, velocity, delta)
    return _apply_to_movement(move_direction, velocity, delta)

func _gravitation(is_floor: bool, is_wall: bool, velocity: Vector3, delta: float) -> Vector3:
    if not is_floor:
        var is_sliding_along_wall := is_wall and velocity.y < 0
        velocity = _sliding_along_wall(is_sliding_along_wall, velocity, delta)
        velocity = _free_fall(is_sliding_along_wall, velocity, delta)
    return velocity

func _sliding_along_wall(is_sliding_along_wall: bool, velocity: Vector3, delta: float) -> Vector3:
    if is_sliding_along_wall:
        velocity.y -= _GRAVITY * _SLOWING_DOWN_FALL * delta
    return velocity

func _free_fall(is_sliding_along_wall: bool, velocity: Vector3, delta: float) -> Vector3:
    if not is_sliding_along_wall:
        velocity.y -= _GRAVITY * delta
    return velocity

func _apply_to_movement(move_direction: Vector3, velocity: Vector3, delta: float) -> Vector3:
    var move_speed := _MOVE_SPEED * delta
    if move_direction == Vector3.ZERO:
        velocity = _stopping(velocity, move_speed)
    else:
        velocity = _movement(velocity, move_direction, move_speed)
    return velocity

func _stopping(velocity: Vector3, move_speed: float) -> Vector3:
    velocity.x = move_toward(velocity.x, 0, move_speed)
    velocity.z = move_toward(velocity.z, 0, move_speed)
    return velocity

func _movement(velocity: Vector3, move_direction: Vector3, move_speed: float) -> Vector3:
    velocity.x = move_direction.x * move_speed
    velocity.z = move_direction.z * move_speed
    return velocity

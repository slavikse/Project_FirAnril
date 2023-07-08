extends Node3D
class_name PlayerBody

const _GRAVITY := 14.0
const _MOVE_SPEED := 4.0
const _SLOWING_DOWN_FALL := 0.1

# todo рывок в сторону движения на шифт. сброс при падении на землю. рывок можно делать только в воздухе?
# todo звук скольжения по стене (царапает?)

func movement(is_floor: bool, is_wall: bool, velocity: Vector3, t_basis: Basis, delta: float) -> Vector3:
    velocity = _gravitation(is_floor, is_wall, velocity, delta)
    var move_direction := _get_move_direction(t_basis)
    return _apply_to_movement(move_direction, velocity)

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

func _get_move_direction(t_basis: Basis) -> Vector3:
    var input_dir := Input.get_vector('move_left', 'move_right', 'move_forward', 'move_back')
    return (t_basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

func _apply_to_movement(move_direction: Vector3, velocity: Vector3) -> Vector3:
    if move_direction == Vector3.ZERO:
        velocity = _stopping(velocity)
    else:
        velocity = _movement(velocity, move_direction)
    return velocity

func _stopping(velocity: Vector3) -> Vector3:
    velocity.x = move_toward(velocity.x, 0, _MOVE_SPEED)
    velocity.z = move_toward(velocity.z, 0, _MOVE_SPEED)
    return velocity

func _movement(velocity: Vector3, move_direction: Vector3) -> Vector3:
    velocity.x = move_direction.x * _MOVE_SPEED
    velocity.z = move_direction.z * _MOVE_SPEED
    return velocity

const _GRAVITY := 16.0
const _SLOWING_DOWN_FALL := 0.1

func gravitation(is_floor: bool, is_wall: bool, velocity: Vector3, delta: float) -> Vector3:
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

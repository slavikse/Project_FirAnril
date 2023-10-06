func gravitation(is_floor: bool, is_wall: bool, velocity: Vector3, delta: float) -> Vector3:
    if not is_floor:
        var is_sliding_along_wall := is_wall and velocity.y < 0
        velocity = _sliding_along_wall(is_sliding_along_wall, velocity, delta)
        velocity = _free_fall(is_sliding_along_wall, velocity, delta)
    return velocity

func _sliding_along_wall(is_sliding_along_wall: bool, velocity: Vector3, delta: float) -> Vector3:
    if is_sliding_along_wall:
        velocity.y -= (GState.SKILLS.gravity as float) * (GState.SKILLS.slowing_down_fall as float) * delta
    return velocity

func _free_fall(is_sliding_along_wall: bool, velocity: Vector3, delta: float) -> Vector3:
    if not is_sliding_along_wall:
        velocity.y -= (GState.SKILLS.gravity as float) * delta
    return velocity

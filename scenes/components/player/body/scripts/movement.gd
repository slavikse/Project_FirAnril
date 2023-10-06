func apply_to_movement(move_direction: Vector3, velocity: Vector3, delta: float) -> Vector3:
    var move_speed := (GState.SKILLS.MOVE_SPEED as float) * delta
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

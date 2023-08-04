const _JUMP_ACCELERATION := 500.0
const _QUANTITY_BOUNCES_FROM_WALL := 1

var _quantity_bounces_from_wall := 0

func jump(is_floor: bool, is_wall: bool, velocity: Vector3, delta: float) -> Vector3:
    var jump_acceleration := _JUMP_ACCELERATION * delta
    velocity = _floor_touched(is_floor, velocity, jump_acceleration)
    return _wall_touched(is_wall, velocity, jump_acceleration)

func _floor_touched(is_floor: bool, velocity: Vector3, jump_acceleration: float) -> Vector3:
    if is_floor:
        velocity.y = jump_acceleration
        _quantity_bounces_from_wall = _QUANTITY_BOUNCES_FROM_WALL
    return velocity

func _wall_touched(is_wall: bool, velocity: Vector3, jump_acceleration: float) -> Vector3:
    if is_wall and _quantity_bounces_from_wall != 0:
        velocity.y = jump_acceleration
        _quantity_bounces_from_wall -= 1
    return velocity

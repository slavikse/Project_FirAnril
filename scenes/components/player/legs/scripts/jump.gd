var _quantity_jumps := 0
var _quantity_bounces := 0

func jump(is_floor: bool, is_wall: bool, velocity: Vector3, delta: float) -> Vector3:
    var jump_acceleration := (GState.SKILLS.jump_acceleration as float) * delta
    _floor_touched(is_floor)
    return _can_jump(is_wall, velocity, jump_acceleration)

func _floor_touched(is_floor: bool) -> void:
    if is_floor:
        _quantity_jumps = GState.SKILLS.quantity_jumps as int
        _quantity_bounces = GState.SKILLS.quantity_bounces as int

func _can_jump(is_wall: bool, velocity: Vector3, jump_acceleration: float) -> Vector3:
    if is_wall:
        if _quantity_bounces == 0:
            velocity = _jump_again(velocity, jump_acceleration)
        else:
            velocity = _jump_from_wall(velocity, jump_acceleration)
    else:
        velocity = _jump_again(velocity, jump_acceleration)
    return velocity

func _jump_from_wall(velocity: Vector3, jump_acceleration: float) -> Vector3:
    if _quantity_bounces != 0:
        _quantity_bounces -= 1
        velocity.y = jump_acceleration
    return velocity

func _jump_again(velocity: Vector3, jump_acceleration: float) -> Vector3:
    if _quantity_jumps != 0:
        _quantity_jumps -= 1
        velocity.y = jump_acceleration
    return velocity
extends Node3D
class_name PlayerLegs

const _JUMP_ACCELERATION := 500.0
const _DASH_SPEED := 40.0
const _DASH_ACCELERATION := 60.0

var _quantity_bounces := 0
var _dash_acceleration := Vector3.ZERO

# todo рывок в сторону движения на шифт. сброс при падении на землю. рывок можно делать только в воздухе?

func jumping(is_floor: bool, is_wall: bool, velocity: Vector3, move_direction: Vector3, delta: float) -> Vector3:
    if Input.is_action_just_pressed('jump'):
        var jump_acceleration := _JUMP_ACCELERATION * delta
        velocity = _touched_floor(is_floor, velocity, jump_acceleration)
        velocity = _touched_wall(is_wall, velocity, jump_acceleration)
    if Input.is_action_just_pressed('dash'):
        # todo
        velocity = _dash_on_fly(is_floor, velocity, move_direction)
    return velocity

func _touched_floor(is_floor: bool, velocity: Vector3, jump_acceleration: float) -> Vector3:
    if is_floor:
        velocity.y = jump_acceleration
        _quantity_bounces = 1
    return velocity

func _touched_wall(is_wall: bool, velocity: Vector3, jump_acceleration: float) -> Vector3:
    if is_wall and _quantity_bounces != 0:
        velocity.y = jump_acceleration
        _quantity_bounces -= 1
    return velocity

# todo 1 раз в воздухе. сброс счетчика на земле

    #warning-ignore:RETURN_VALUE_DISCARDED
#    interpolate_property(
#        player_node, 'rotation_degrees',
#        degrees, degrees + GNumber.RIGHT_ANGLE,
#        _DELAY_ROTATE_DURATION,
#        Tween.TRANS_BACK, Tween.EASE_OUT)
#    #warning-ignore:RETURN_VALUE_DISCARDED
#    start()
func _dash_on_fly(is_floor: bool, velocity: Vector3, move_direction: Vector3) -> Vector3:
    if not is_floor:
#        if _dash_acceleration == Vector3.ZERO:
#            # todo x & z
#            _dash_acceleration = lerp(velocity, velocity * _DASH_SPEED, _DASH_ACCELERATION)
##            velocity = _dash_acceleration
#        # todo выполнять в каждом кадре, пока не ускорение не станет равным 0
##        velocity = lerp(velocity, velocity * _DASH_SPEED, _dash_acceleration)
#
#            velocity.x = move_direction.x * _dash_acceleration.x
#            velocity.z = move_direction.z * _dash_acceleration.z
#
#            _dash_acceleration = Vector3.ZERO

        velocity.x = move_direction.x * _DASH_ACCELERATION
        velocity.z = move_direction.z * _DASH_ACCELERATION
        print('velocity', velocity)
    return velocity

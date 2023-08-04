extends Node3D
class_name PlayerLegsDash

signal dashed(is_dash: bool)

const _ACCELERATION := 40.0
const _SPEED := 15.0
const _QUANTITY_DASHES := 1

var _quantity_dashes := _QUANTITY_DASHES
var _acceleration := Vector3.ZERO

@onready var _dash_timeout_node := $DashTimeout as Timer

func dash_init(move_direction: Vector3, is_floor: bool, delta: float) -> void:
    if not is_floor and _quantity_dashes > 0:
        _quantity_dashes -= 1
        _dash_start(move_direction, delta)

func _dash_start(move_direction: Vector3, delta: float) -> void:
    _dash_timeout_node.start()
    _acceleration = move_direction * _ACCELERATION * delta
    dashed.emit(true)

func _on_dash_timeout_timeout() -> void:
    dashed.emit(false)

func reset_quantity_dashes() -> void:
    _quantity_dashes = _QUANTITY_DASHES

# todo add easing function
func dash(player_position: Vector3, delta: float) -> Vector3:
    return player_position.lerp(player_position + _acceleration, _SPEED * delta)

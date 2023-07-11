extends Node3D
class_name PlayerLegs

signal dashed(is_dash: bool)

var _jump_script := preload('./scripts/jump.gd').new()

@onready var _player_legs_dash_node := $PlayerLegsDash as PlayerLegsDash

func jumping(is_floor: bool, is_wall: bool, velocity: Vector3, move_direction: Vector3, delta: float) -> Vector3:
    if Input.is_action_just_pressed('jump'):
        velocity = _jump_script.jump(is_floor, is_wall, velocity, delta)
    if Input.is_action_just_pressed('dash'):
        _player_legs_dash_node.dash_init(move_direction, is_floor, delta)
    if is_floor:
        _player_legs_dash_node.reset_quantity_dashes()
    return velocity

func _on_player_legs_dash_dashed(is_dash: bool) -> void:
    dashed.emit(is_dash)

func dash(player_position: Vector3, delta: float) -> Vector3:
    return _player_legs_dash_node.dash(player_position, delta)

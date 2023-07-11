extends CharacterBody3D

var _is_dash := false
var _direction_script := preload('./scripts/direction.gd').new()

@onready var _player_head_node := $PlayerHead as PlayerHead
@onready var _player_body_node := $PlayerBody as PlayerBody
@onready var _player_legs_node := $PlayerLegs as PlayerLegs

func _physics_process(delta: float) -> void:
    var is_floor := is_on_floor()
    var is_wall := is_on_wall()
    var move_direction := _direction_script.get_move_direction(transform.basis)
    velocity = _player_body_node.movement(is_floor, is_wall, velocity, move_direction, delta)
    velocity = _player_legs_node.jumping(is_floor, is_wall, velocity, move_direction, delta)

    if _is_dash:
        position = _player_legs_node.dash(position, delta)

    move_and_slide()

func _input(event: InputEvent) -> void:
    if event is InputEventMouseMotion:
        _rotate_y(event as InputEventMouseMotion)

func _rotate_y(mouse_motion: InputEventMouseMotion) -> void:
    var mouse_sensitivity := _player_head_node.vertical_rotation(mouse_motion.relative.y)
    rotate_y(deg_to_rad(-mouse_motion.relative.x * mouse_sensitivity))

func _on_player_legs_dashed(is_dash: bool) -> void:
    _is_dash = is_dash

extends CharacterBody3D
class_name Player

var _is_dash := false

@onready var _player_head_node := $PlayerHead as PlayerHead
@onready var _player_body_node := $PlayerBody as PlayerBody
@onready var _player_legs_node := $PlayerLegs as PlayerLegs

func _physics_process(delta: float) -> void:
    var is_floor := is_on_floor()
    var is_wall := is_on_wall() or _player_body_node.has_bounce_buffer(is_floor)
    var move_direction := _get_move_direction()

    velocity = _player_body_node.movement(is_floor, is_wall, velocity, move_direction, delta)
    velocity = _player_legs_node.jumping(is_floor, is_wall, velocity, move_direction, delta)

    if _is_dash:
        position = _player_legs_node.dash(position, delta)

    move_and_slide()

func _get_move_direction() -> Vector3:
    var input_dir := Input.get_vector('move_left', 'move_right', 'move_forward', 'move_back')
    return (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

func _input(event: InputEvent) -> void:
    if event is InputEventMouseMotion:
        _rotate_y(event as InputEventMouseMotion)

func _rotate_y(mouse_motion: InputEventMouseMotion) -> void:
    var mouse_sensitivity := _player_head_node.vertical_rotation(mouse_motion.relative.y)
    rotate_y(deg_to_rad(-mouse_motion.relative.x * mouse_sensitivity))

func _on_player_legs_dashed(is_dash: bool) -> void:
    _is_dash = is_dash

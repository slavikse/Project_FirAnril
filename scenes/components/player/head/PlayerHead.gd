extends Camera3D
class_name PlayerHead

const _DOWN_LIMIT := -75.0
const _TOP_LIMIT := 90.0
const _MOUSE_SENSITIVITY := 0.15

var _is_mouse_captured := true

func _ready() -> void:
    Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(_delta: float) -> void:
    if Input.is_action_just_pressed('ui_cancel'):
        _pause_menu()

func _pause_menu() -> void:
    if _is_mouse_captured:
        _pause_switch(Input.MOUSE_MODE_VISIBLE)
    else:
        _pause_switch(Input.MOUSE_MODE_CAPTURED)
    _is_mouse_captured = not _is_mouse_captured

func _pause_switch(input_mode: Input.MouseMode) -> void:
    Input.set_mouse_mode(input_mode)
    G.scene_paused(_is_mouse_captured)

func vertical_rotation(relative_y: float) -> float:
    rotate_x(deg_to_rad(-relative_y * _MOUSE_SENSITIVITY))
    rotation_degrees.x = clamp(rotation_degrees.x, _DOWN_LIMIT, _TOP_LIMIT)
    return _MOUSE_SENSITIVITY

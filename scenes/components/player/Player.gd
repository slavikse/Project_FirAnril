extends CharacterBody3D

const _MOUSE_SENSITIVITY := 0.15

@onready var _player_head_node := $PlayerHead as PlayerHead
@onready var _player_body_node := $PlayerBody as PlayerBody
@onready var _player_legs_node := $PlayerLegs as PlayerLegs

# todo ГГ находит фонарик, свет охранники не видят, но улавливают включённый прибор
# (это объясняется при подборе фонарика и записки рядом с трупом биолога).

func _physics_process(delta: float) -> void:
    var is_floor := is_on_floor()
    var is_wall := is_on_wall()
    velocity = _player_body_node.movement(is_floor, is_wall, velocity, transform.basis, delta)
    velocity = _player_legs_node.jumping(is_floor, is_wall, velocity)
    move_and_slide()

func _input(event: InputEvent) -> void:
    if event is InputEventMouseMotion:
        var mouse_motion := event as InputEventMouseMotion
        _player_head_node.vertical_rotation(mouse_motion.relative.y, _MOUSE_SENSITIVITY)
        rotate_y(deg_to_rad(-mouse_motion.relative.x * _MOUSE_SENSITIVITY))

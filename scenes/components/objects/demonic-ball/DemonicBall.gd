extends Node3D

# Минимальное значение должно быть больше времени анимации shot:init
# todo 4-6
const _DELAY_SHOT := [2, 4]

var _start_position := Vector3.ZERO

@onready var _shot_node := $Shot as AnimationPlayer
@onready var _shot_delay_node := $Shot/Delay as Timer
@onready var _glow_node := $Ball/Glow as OmniLight3D
@onready var _destruction_node := $Ball/Destruction as GPUParticles3D

# todo размещать пушки так, чтобы потенциально они могли сбить игрока со столбика.

func _ready() -> void:
    _start_position = global_position
    _start_delay()

func _start_delay() -> void:
    _shot_node.play('ready_position')
    var wait_time := GNumber.get_random_range_int(_DELAY_SHOT[0], _DELAY_SHOT[1])
    _shot_delay_node.start(wait_time)

func _on_shot_delay_timeout() -> void:
    _shot_node.play('shooting')

func _anim_shot_destruction():
    _destruction_node.show()

# todo звук выстрела + эффект выстрела
func _on_ball_body_entered(body_node: Node3D) -> void:
    if body_node.is_in_group(GConst.GROUPS.Wall):
        _destruction()

# todo у снаряда звук удара о стену.
func _destruction() -> void:
    _shot_node.stop(true)
    _glow_node.hide()
    _destruction_node.emitting = true

    # todo убрать шар. впитает стена?
    GFunc.delay_call(2, _restart)

func _restart() -> void:
    global_position = _start_position
    _glow_node.show()
    _destruction_node.emitting = false
    _destruction_node.hide()
    _start_delay()

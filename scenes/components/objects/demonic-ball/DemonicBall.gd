extends Node3D

# Минимальное значение должно быть больше времени анимации shot:init
const _DELAY_SHOT: Array[int] = [4, 6]

var _start_position := Vector3.ZERO
var _is_destruction_effect := false

@onready var _shot_node := $Shot as AnimationPlayer
@onready var _shot_delay_node := $Shot/Delay as Timer
@onready var _ball_glow_node := $Ball/Glow as OmniLight3D
@onready var _ball_model_node := $Ball/Model as Node3D
@onready var _ball_destruction_node := $Ball/Destruction as GPUParticles3D
@onready var _delay_call_node := $DelayCall as Timer
@onready var _delay_restart_node := $DelayRestart as Timer

# todo эффект выстрела
func _ready() -> void:
    _start_position = global_position
    _start_delay()

func _start_delay() -> void:
    _shot_node.play('ready-position')
    var wait_time := GNumber.get_random_range_int(_DELAY_SHOT[0], _DELAY_SHOT[1])
    _shot_delay_node.start(wait_time)

# todo звук выстрела + эффект выстрела
func _on_shot_delay_timeout() -> void:
    _is_destruction_effect = true
    _shot_node.play('shooting')

func _on_ball_body_entered(body_node: Node3D) -> void:
    if (body_node.is_in_group(GConst.GROUPS.WALL)
    or body_node.is_in_group(GConst.GROUPS.BARRIER))\
    and _is_destruction_effect:
        _start_collision()

# todo звук: снаряд удар о стену.
func _start_collision() -> void:
    _shot_node.stop(true)
    _effect()
    _delay_call_node.start()

func _effect() -> void:
    _is_destruction_effect = false
    _ball_destruction_node.emitting = true
    _ball_model_node.hide()
    _ball_glow_node.hide()

func _on_delay_call_timeout() -> void:
    _restart()

func _restart() -> void:
    global_position = _start_position
    _ball_destruction_node.emitting = false
    _delay_restart_node.start()
    _start_delay()

func _on_delay_restart_timeout() -> void:
    _ball_model_node.show()
    _ball_glow_node.show()

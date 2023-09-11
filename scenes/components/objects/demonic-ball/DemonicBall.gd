extends Node3D

# Минимальное значение должно быть больше времени анимации shot:init
# todo 4-6
const _DELAY_SHOT := [2, 4]

var _start_position := Vector3.ZERO
var _is_destruction_effect := true

@onready var _shot_node := $Shot as AnimationPlayer
@onready var _shot_delay_node := $Shot/Delay as Timer
@onready var _ball_node := $Ball as RigidBody3D
@onready var _ball_destruction_node := $Ball/Destruction as GPUParticles3D

# todo размещать пушки так, чтобы потенциально они могли сбить игрока со столбика.

func _ready() -> void:
    _start_position = global_position
    _start_delay()

func _start_delay() -> void:
    _shot_node.play('ready_position')
    var wait_time := GNumber.get_random_range_int(_DELAY_SHOT[0], _DELAY_SHOT[1])
    _shot_delay_node.start(wait_time)

func _on_shot_delay_timeout() -> void:
    _is_destruction_effect = true
    _shot_node.play('shooting')

# todo звук выстрела + эффект выстрела
func _on_ball_body_entered(body_node: Node3D) -> void:
    if body_node.is_in_group(GConst.GROUPS.Wall)\
    and _is_destruction_effect:
        _start_collision()

# todo у снаряда звук удара о стену.
func _start_collision() -> void:
    _shot_node.stop(true)
    _ball_node.freeze = false
    _effect()

func _effect() -> void:
    _is_destruction_effect = false
    _ball_destruction_node.emitting = true
    GFunc.delay_call(2, _restart)

# todo запускать, когда ядро свалится в черную дыру
func _restart() -> void:
    global_position = _start_position
    _ball_destruction_node.emitting = false
    _ball_node.freeze = true
    _start_delay()

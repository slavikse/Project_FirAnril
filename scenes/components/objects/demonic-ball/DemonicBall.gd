extends Node3D

const _DELAY_SHOT := [2, 3]

var _init_position := Vector3.ZERO

@onready var _shot_node := $Shot as AnimationPlayer
@onready var _ball_delay_node := $Ball/Delay as Timer

func _ready() -> void:
    _init_state()
    _start_delay()

func _init_state() -> void:
    _init_position = global_position

# todo снаряд выдвигается из пушки (перезарядка)
#   анимация появления за _DELAY_SHOT
func _start_delay() -> void:
    _ball_delay_node.wait_time = GNumber.get_random_range_int(_DELAY_SHOT[0], _DELAY_SHOT[1])
    _ball_delay_node.start()

func _on_shot_delay_timeout() -> void:
    _gunshot()

func _gunshot() -> void:
    # todo звук выстрела + эффект выстрела
    _shot_node.play('shot')

# todo разрушать при столкновении со стеной или с барьером
func _on_ball_body_entered(wall_node: Node3D) -> void:
    # todo у снаряда звук удара об стены и разрушение.
    if wall_node.is_in_group(GConst.GROUPS.Wall):
        _restart()

func _restart() -> void:
    _shot_node.stop()
    global_position = _init_position
    _start_delay()

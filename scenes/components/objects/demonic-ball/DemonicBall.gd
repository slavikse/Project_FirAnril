extends RigidBody3D

const _DELAY_SHOT := [1, 2]
const _POWER := Vector3(10000, 10000, 10000)

var _init_position := Vector3.ZERO
var _init_rotation := Vector3.ZERO

@onready var _shot_node := $Shot as Timer
@onready var _shot2_node := $Shot_2 as Timer

func _ready() -> void:
    _init_position = global_position
    _init_rotation = global_rotation
    _delay_shot()

func _delay_shot() -> void:
    _shot_node.wait_time = GNumber.get_random_range_int(_DELAY_SHOT[0], _DELAY_SHOT[1])
    _shot_node.start()

func _on_shot_timeout() -> void:
    _gunshot()

# todo изменить угол вылета снаряда
# todo звук выстрела
# todo у снаряда звук удара об стены и разрушение.
func _gunshot() -> void:
    freeze = false
    apply_impulse(transform.basis * _POWER)

    # todo разрушать снаряд при столкновении со стеной или игроком
    # todo снаряд должен толкнуть игрока и разрушиться
    _shot2_node.wait_time = GNumber.get_random_range_int(3, 4)
    _shot2_node.start()

# todo шар будет разрушен, создается новый и начинается таймер
func _reinit() -> void:
    # todo анимация появления и после анимации продолжается код
    global_position = _init_position
    global_rotation = _init_rotation
    freeze = true
    _delay_shot()

func _on_shot_2_timeout() -> void:
    _reinit()

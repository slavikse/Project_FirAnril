extends OmniLight3D
class_name MetalWallLampGlow

const _DELAY_BLINK := [1, 3]

@onready var _start_node := $Start as Timer
@onready var _blink_node := $Blink as AnimationPlayer

func blink() -> void:
    _blink()

func _delay_blink() -> void:
    _start_node.wait_time = GNumber.get_random_range_int(_DELAY_BLINK[0], _DELAY_BLINK[1])
    _start_node.start()

func _on_start_timeout() -> void:
    _blink()

func _blink() -> void:
    _blink_node.play('blink')

func _on_blink_animation_finished(_anim_name: StringName) -> void:
    _delay_blink()

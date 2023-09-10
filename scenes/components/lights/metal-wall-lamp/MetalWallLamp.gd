extends StaticBody3D

@export var is_glow := true
@export var is_blink := false

const _DELAY_BLINK := [1, 3]

@onready var _lamp_glow_node := $LampGlow as OmniLight3D
@onready var _lamp_glow_start_node := $LampGlow/Start as Timer
@onready var _lamp_glow_blink_node := $LampGlow/Blink as AnimationPlayer

func _ready() -> void:
    _can_glow()
    _can_blink()

func _can_glow() -> void:
    if not is_glow:
        is_blink = false
        _lamp_glow_node.hide()

func _can_blink() -> void:
    if is_blink:
        _blink()

func _blink() -> void:
    _lamp_glow_blink_node.play('blink')

func _on_blink_animation_finished(_anim_name: StringName) -> void:
    _delay_blink()

# todo звук накаленной лампы, которая мерцает
func _delay_blink() -> void:
    var wait_time := GNumber.get_random_range_int(_DELAY_BLINK[0], _DELAY_BLINK[1])
    _lamp_glow_start_node.start(wait_time)

func _on_start_timeout() -> void:
    _blink()

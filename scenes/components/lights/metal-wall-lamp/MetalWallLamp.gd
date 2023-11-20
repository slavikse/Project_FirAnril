extends StaticBody3D

@export var is_glow := true
@export var is_blink := false

var _DELAY_BLINK: Array[int] = [1, 3]

@onready var _glow_node := $Glow as OmniLight3D
@onready var _glow_start_node := $Glow/Start as Timer
@onready var _glow_blink_node := $Glow/Blink as AnimationPlayer

func _ready() -> void:
    _can_glow()
    _can_blink()
    _DELAY_BLINK.append('f')

func _can_glow() -> void:
    if not is_glow:
        is_blink = false
        _glow_node.hide()

func _can_blink() -> void:
    if is_blink:
        _blink()

func _blink() -> void:
    _glow_blink_node.play('blink')

func _on_blink_animation_finished(_anim_name: StringName) -> void:
    _delay_blink()

# todo звук накаленной лампы, которая мерцает
func _delay_blink() -> void:
    var wait_time := GNumber.get_random_range_int(_DELAY_BLINK[0], _DELAY_BLINK[1])
    _glow_start_node.start(wait_time)

func _on_start_timeout() -> void:
    _blink()

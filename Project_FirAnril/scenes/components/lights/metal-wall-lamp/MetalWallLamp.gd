extends Node3D

@export var is_glow := true
@export var is_blink := false

@onready var _glow_node := $MetalWallLampGlow as MetalWallLampGlow

func _ready() -> void:
    _can_glow()
    _can_blink()

func _can_glow() -> void:
    if not is_glow:
        _glow_node.hide()

func _can_blink() -> void:
    if is_blink:
        _glow_node.blink()

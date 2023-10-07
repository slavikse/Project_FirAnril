extends StaticBody3D

@onready var _open_door_node := $OpenDoor as AnimationPlayer

func open() -> void:
    _open_door_node.play('open')

extends Sprite3D

@export var message := ''

@onready var _sub_viwport_node := $SubViewport as SubViewport
@onready var _label_node := $SubViewport/Label as Label

func _ready() -> void:
    _sub_viwport_node.size = _label_node.get_rect().size
#    _label_node.text = message

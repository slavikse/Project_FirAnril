extends Area3D

const _COLUMN_PEEK_HEIGHT := -17.8
const _COLUMN_PEEK_SPEED_UP := 2.0
const _COLUMN_HEIGHT := -18.4
const _COLUMN_HEIGHT_MAX := 2.0
const _COLUMN_SPEED_UP := 3.0 # TODO замедлить рост до 1.0
const _COLUMN_SPEED_DOWN := 4.0

var _is_peek := false
var _is_lifting := false
var _is_lowering := false

@onready var _columns_node := $Columns as Area3D

# todo звук для изменения высоты колонны

func _ready() -> void:
    _columns_node.position.y = _COLUMN_HEIGHT

func _physics_process(delta: float) -> void:
    _peeking(delta)
    _lifting(delta)
    _lowering(delta)

func _peeking(delta: float) -> void:
    if _is_peek and _columns_node.position.y < _COLUMN_PEEK_HEIGHT:
        _columns_node.position.y += _COLUMN_PEEK_SPEED_UP * delta

func _lifting(delta: float) -> void:
    if _is_lifting and _columns_node.position.y < _COLUMN_HEIGHT_MAX:
        _columns_node.position.y += _COLUMN_SPEED_UP * delta

func _lowering(delta: float) -> void:
    if _is_lowering and _columns_node.position.y > _COLUMN_HEIGHT:
        _columns_node.position.y -= _COLUMN_SPEED_DOWN * delta

# спуск столбиков (стоит на полу)
func _on_body_entered(body_node: CharacterBody3D) -> void:
    if body_node.is_in_group(GConst.GROUPS.PLAYER):
        _is_peek = false
        _is_lifting = false
        _is_lowering = true

# выглядывает или остановка движения столбиков (не стоит на полу)
func _on_body_exited(body_node: CharacterBody3D) -> void:
    if body_node.is_in_group(GConst.GROUPS.PLAYER):
        _is_peek = true
        _is_lifting = false
        _is_lowering = false

# подъём столбиков (не стоит на полу)
func _on_columns_body_entered(body_node: CharacterBody3D) -> void:
    if body_node.is_in_group(GConst.GROUPS.PLAYER):
        _is_lifting = true
        _is_lowering = false

# остановка роста столбика
func _on_columns_body_exited(body_node: CharacterBody3D) -> void:
    if body_node.is_in_group(GConst.GROUPS.PLAYER):
        _is_lifting = false

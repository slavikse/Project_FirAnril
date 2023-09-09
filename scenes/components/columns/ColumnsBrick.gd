extends Area3D

const _COLUMN_HEIGHT := -19.9
const _COLUMN_HEIGHT_MAX := 2.0
const _COLUMN_SPEED_UP := 3.0 # 1.0
const _COLUMN_SPEED_DOWN := _COLUMN_SPEED_UP * 3.0

var _is_lifting := false
var _is_lowering := false

@onready var _columns_node := $Columns as Area3D

# todo звук для изменения высоты колонны

func _ready() -> void:
    _columns_node.position.y = _COLUMN_HEIGHT

func _physics_process(delta: float) -> void:
    _lifting(delta)
    _lowering(delta)

func _lifting(delta: float) -> void:
    if _is_lifting and _columns_node.position.y < _COLUMN_HEIGHT_MAX:
        _columns_node.position.y += _COLUMN_SPEED_UP * delta
        if _columns_node.position.y > _COLUMN_HEIGHT_MAX:
            _columns_node.position.y = _COLUMN_HEIGHT_MAX

func _lowering(delta: float) -> void:
    if _is_lowering and _columns_node.position.y > _COLUMN_HEIGHT:
        _columns_node.position.y -= _COLUMN_SPEED_DOWN * delta
        if _columns_node.position.y < _COLUMN_HEIGHT:
            _columns_node.position.y = _COLUMN_HEIGHT

func _on_body_entered(_player: Player) -> void: # спуск столбиков
    _is_lifting = false
    _is_lowering = true

func _on_columns_body_entered(_player: Player) -> void: # подъём столбиков
    _is_lifting = true
    _is_lowering = false

func _on_columns_body_exited(_player: Player) -> void: # остановка роста столбика
    _is_lifting = false

extends Node3D

const _COLUMNS_HEIGHT_DEFAULT := -19.95
const _COLUMNS_HEIGHT_MAX := 2 # todo
const _COLUMNS_HEIGHT_SPEED_UP := 4.3 # todo 0.3
const _COLUMNS_HEIGHT_SPEED_DOWN := _COLUMNS_HEIGHT_SPEED_UP * 3.0

var _is_columns_lifting := false
var _is_columns_lowering := false

@onready var _columns_node := $Columns as Area3D

# todo стены будут сжиматься. в зазоре будет дверь для перехода на следующий уровень.

# todo когда растут столбики, сдвигаются так же и стены. когда запрыгнуть со столбика уже не получится,
#   стены должны быть уже на таком расстоянии, что с них можно будет допрыгнуть до вырасшего столбика.
#   раздвигать нужно быстро.

# todo на столбике есть кнопка. когда столбик поднялся, то через фиксированное время она начнёт мигать и звуковой сигнал.
#   когда время мигания закончится, столбик начнёт опускаться. кнопка перестанет мигать только после нажатия на неё ГГ.

# todo какой то враг будет мешать просто так перепрыгивать с колонны на колонну
#   враг - так как это конец игры, то игрок узнает, что велись разработки различных невидимых существ
#   и тут будет враг, который будет мешать перепрыгивать: плоскость, которая периодически будет появляться
#   чтобы преградить путь игроку. игрок врезавшись в неё, должен отскочить обратно на колонну.

# todo звук для изменения высоты колонны

func _ready() -> void:
    _columns_node.position.y = _COLUMNS_HEIGHT_DEFAULT

func _physics_process(delta: float) -> void:
    _columns_lifting(delta)
    _columns_lowering(delta)

func _columns_lifting(delta: float) -> void:
    if _is_columns_lifting and _columns_node.position.y < _COLUMNS_HEIGHT_MAX:
        _columns_node.position.y += _COLUMNS_HEIGHT_SPEED_UP * delta
        if _columns_node.position.y > _COLUMNS_HEIGHT_MAX:
            _columns_node.position.y = _COLUMNS_HEIGHT_MAX

func _columns_lowering(delta: float) -> void:
    if _is_columns_lowering and _columns_node.position.y > _COLUMNS_HEIGHT_DEFAULT:
        _columns_node.position.y -= _COLUMNS_HEIGHT_SPEED_DOWN * delta
        if _columns_node.position.y < _COLUMNS_HEIGHT_DEFAULT:
            _columns_node.position.y = _COLUMNS_HEIGHT_DEFAULT

func _on_stepped_on_floor(_player: CharacterBody3D) -> void:
    _is_columns_lifting = false
    _is_columns_lowering = true

func _on_stepped_on_lifting(_player: CharacterBody3D) -> void:
    _is_columns_lifting = true
    _is_columns_lowering = false

func _on_stepped_on_lowering(_player: CharacterBody3D) -> void:
    _is_columns_lifting = false

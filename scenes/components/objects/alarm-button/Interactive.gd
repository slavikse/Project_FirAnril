extends Area3D

# todo интернациализация. сюда должно быть передано, какую реакцию вызовет и на какую кнопку
@export var message := ''
@export var button := ''

# TODO добавить обработку нажатия клавиши. если в момент, когда приблизился к кнопке нажал Е,
# то сработает нажатие красной кнопки.
# еще уведомление на экране, что элемент интерактивный и можно нажать клавишу Е

# interface
func start_interact() -> void:
    print('start_interact', message)

# interface
func end_interact() -> void:
    print('end_interact')

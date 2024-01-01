extends GridContainer
class_name GSScalarControl

var client: GSClient
var device: GSDevice
var feature: GSFeature

var min_strength:int = 0
var max_strength:int = 100

@onready var _actuator_type: Label = %ActuatorType
@onready var _index: Label = %Index
@onready var _scalar: HSlider = $Scalar

@onready var min_slider = $MinSlider
@onready var max_slider = $MaxSlider

@onready var vibration_manager = $/root/World/%VibrationManager
@onready var button = $Button

var in_use:bool = false

func _ready() -> void:
	_actuator_type.text = feature.actuator_type
	_index.text = str(feature.feature_index)


func _on_scalar_value_changed(value: float) -> void:
	set_device_strength(value)


func _on_max_slider_value_changed(value):
	max_strength = value
	if max_strength < min_strength:
		min_slider.set_value(max_strength - 1)


func _on_min_slider_value_changed(value):
	min_strength = value
	if min_strength > max_strength:
		max_slider.set_value(min_strength + 1)

func map_range(value, from_min, from_max, to_min, to_max):
	return (value - from_min) / (from_max - from_min) * (to_max - to_min) + to_min


func _on_button_pressed():
	if in_use:
		vibration_manager.change_device_strength.disconnect(set_device_strength)
		button.text = "Use this device"
		in_use = false
	else:
		vibration_manager.change_device_strength.connect(set_device_strength)
		button.text = "Do not use this device"
		in_use = true
	_scalar.set_value(0)

func set_device_strength(value:float):
	if value == 0:
		client.send_scalar(device.device_index, feature.feature_index, feature.actuator_type, value)
		return
	value = map_range(value,1,100,min_strength,max_strength)
	value = clampf(value/100, 0.0, 1.0)
	client.send_scalar(device.device_index, feature.feature_index, feature.actuator_type, value)

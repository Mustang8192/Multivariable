class_name Question

enum ConversionType {
	INCHES_TO_FEET, FEET_TO_YARDS, METERS_TO_KILOMETERS, CENTIMETERS_TO_METERS
}

var type: String

var val1_low: float
var val1_high: float
var val2_low: float
var val2_high: float

var mult_low: float
var mult_high: float

var conversion_type: ConversionType
var units_in: String
var units_to: String
var conversion_factor: int

#func _init(_type: String, _val1_low: float, _val1_high: float, _val2_low: float, _val2_high: float):
#	val1_low = _val1_low
#	val1_high = _val1_high
#	val2_low = _val2_low
#	val2_high = _val2_high

func _init(info: Dictionary):
	val1_low = info.get("range_one_low")
	val1_high = info.get("range_one_high")
	val2_low = info.get("range_two_low")
	val2_high = info.get("range_two_high")
	type = info.get("question_type")
	mult_low = (info.get("mult_factor_range_low") if info.get("mult_factor_range_low") else 0)
	mult_high = (info.get("mult_factor_range_high") if info.get("mult_factor_range_high") else 0)
	if info.get("conversion_type"):
		set_conversion_type(info.get("conversion_type"))

func set_mult_factors(_mult_low: float, _mult_high: float) -> Question:
	mult_low = _mult_low
	mult_high = _mult_high
	return self

func set_conversion_type(type: String) -> Question:
	match type:
		"Inches/Feet":
			conversion_type = ConversionType.INCHES_TO_FEET
			units_in = "inches"
			units_to = "feet"
			conversion_factor = 12
		"Feet/Yards":
			conversion_type = ConversionType.FEET_TO_YARDS
			units_in = "feet"
			units_to = "yards"
			conversion_factor = 3
		"Meter/Kilometers":
			conversion_type = ConversionType.METERS_TO_KILOMETERS
			units_in = "meters"
			units_to = "kilometers"
			conversion_factor = 1000
		"Centimeters/Meters":
			conversion_type = ConversionType.CENTIMETERS_TO_METERS
			units_in = "centimeters"
			units_to = "meters"
			conversion_factor = 100
	return self
	
func random_val1() -> int:
	return randi_range(val1_low, val1_high)

func random_val2() -> int:
	return randi_range(val2_low, val2_high)

func randf_val1() -> float:
	return randf_range(val1_low, val1_high)

func randf_val2() -> float:
	return randf_range(val2_low, val2_high)

func random_mult() -> int:
	return randi_range(mult_low, mult_high)

#"question_type_6": {
#	"range_one_low": 1,
#	"range_one_high": 9.9,
#	"range_two_low": 1,
#	"range_two_high": 9.9,
#	"question_type": "Subtraction"
#}
#	"mult_factor_range_low": 2,
#	"mult_factor_range_high": 10,

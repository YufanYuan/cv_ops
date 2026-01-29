package locale

en: {
	language: *"english" | "danish" | "french" | "german" | "hindi" | "indonesian" | "italian" | "japanese" | "korean" | "mandarin_chineese" | "portuguese" | "russian" | "spanish" | "turkish"

	last_updated: *"Last updated in" | string
	month:        *"month" | string
	months:       *"months" | string
	year:         *"year" | string
	years:        *"years" | string
	present:      *"present" | string

	month_abbreviations: *[
		"Jan",
		"Feb",
		"Mar",
		"Apr",
		"May",
		"June",
		"July",
		"Aug",
		"Sept",
		"Oct",
		"Nov",
		"Dec",
	] | [...string]

	month_names: *[
		"January",
		"February",
		"March",
		"April",
		"May",
		"June",
		"July",
		"August",
		"September",
		"October",
		"November",
		"December",
	] | [...string]
}
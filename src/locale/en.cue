package locale

en: {
	language: *"en" | string
	phone_number_format: *"national" | string
	page_numbering_template: *"NAME - Page PAGE_NUMBER of TOTAL_PAGES" | string
	last_updated_date_template: *"Last updated in TODAY" | string
	date_template: *"MONTH_ABBREVIATION YEAR" | string
	month: *"month" | string
	months: *"months" | string
	year: *"year" | string
	years: *"years" | string
	present: *"present" | string
	to: *"–" | string
	abbreviations_for_months: *[
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
	full_names_of_months: *[
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
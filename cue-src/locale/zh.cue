package locale

zh: {
	language: *"zh" | string
	phone_number_format: *"national" | string
	page_numbering_template: *"NAME - Page PAGE_NUMBER of TOTAL_PAGES" | string
	last_updated_date_template: *"" | string
	date_template: *"YEAR年MONTH_ABBREVIATION" | string
	month: *"月" | string
	months: *"月" | string
	year: *"年" | string
	years: *"年" | string
	present: *"至今" | string
	to: *"–" | string
	abbreviations_for_months: *[
		"1月",
		"2月",
		"3月",
		"4月",
		"5月",
		"6月",
		"7月",
		"8月",
		"9月",
		"10月",
		"11月",
		"12月",
	] | [...string]
	full_names_of_months: *[
		"一月",
		"二月",
		"三月",
		"四月",
		"五月",
		"六月",
		"七月",
		"八月",
		"九月",
		"十月",
		"十一月",
		"十二月",
	] | [...string]
}
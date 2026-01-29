package locale

zh: {
	language: *"mandarin_chineese" | "english" | "danish" | "french" | "german" | "hindi" | "indonesian" | "italian" | "japanese" | "korean" | "portuguese" | "russian" | "spanish" | "turkish"

	// Preserving previous Chinese translations where appropriate
	last_updated: *"" | string 
	month:        *"月" | string
	months:       *"月" | string
	year:         *"年" | string
	years:        *"年" | string
	present:      *"至今" | string
	
	// Extra fields found in previous zh.cue but not explicitly strictly in Reference (optional but good to keep optional)


	month_abbreviations: *[
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

	month_names: *[
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
package design

en: {
	theme: "engineeringresumes"
	page: {
		size:          *"us-letter" | string
		top_margin:    *"2cm" | string
		bottom_margin: *"2cm" | string
		left_margin:   *"2cm" | string
		right_margin:  *"2cm" | string
		show_footer:   *false | bool
		show_top_note: *true | bool
	}
	colors: {
		body:           *"rgb(0, 0, 0)" | string
		name:           *"rgb(0, 0, 0)" | string
		connections:    *"rgb(0, 0, 0)" | string
		section_titles: *"rgb(0, 0, 0)" | string
		links:          *"rgb(0, 0, 0)" | string
		footer:         *"rgb(128, 128, 128)" | string
		top_note:       *"rgb(128, 128, 128)" | string
	}
	typography: {
		font_family: {
			body:           *"XCharter" | string
			name:           *"XCharter" | string
			headline:       *"XCharter" | string
			connections:    *"XCharter" | string
			section_titles: *"XCharter" | string
		}
		font_size: {
			body:           *"10pt" | string
			name:           *"25pt" | string
			headline:       *"10pt" | string
			connections:    *"10pt" | string
			section_titles: *"1.2em" | string
		}
		line_spacing:                       *"0.6em" | string
		alignment:                          *"justified" | string
		date_and_location_column_alignment: *"right" | string
		small_caps: {
			name:           *false | bool
			headline:       *false | bool
			connections:    *false | bool
			section_titles: *false | bool
		}
		bold: {
			name:           *false | bool
			headline:       *false | bool
			connections:    *false | bool
			section_titles: *true | bool
		}
	}
	links: {
		underline:               *true | bool
		show_external_link_icon: *false | bool
	}
	header: {
		alignment:        *"center" | string
		photo_width:      *"3.5cm" | string
		space_below_name: *"0.7cm" | string

		connections: {
			separator:                         *"|" | string
			space_between_connections:         *"0.5cm" | string
			show_icons:                        *false | bool
			phone_number_format:               *"national" | string
			hyperlink:                         *true | bool
			display_urls_instead_of_usernames: *true | bool
		}
		space_below_headline:    *"0.7cm" | string
		space_below_connections: *"0.7cm" | string
	}
	section_titles: {
		type:           *"with_full_line" | string
		line_thickness: *"0.5pt" | string
		space_above:    *"0.55cm" | string
		space_below:    *"0.3cm" | string
	}
	sections: {
		allow_page_break:              *true | bool
		space_between_regular_entries: *"0.4cm" | string
	}
	entries: {
		date_and_location_width: *"4.15cm" | string
		space_between_columns:   *"0.1cm" | string
		allow_page_break:        *true | bool
		short_second_row:        *false | bool
		highlights: {
			bullet:                        *"•" | string
			space_above:                   *"0.25cm" | string
			space_left:                    *"0cm" | string
			space_between_items:           *"0.19cm" | string
			space_between_bullet_and_text: *"0.3em" | string
		}
	}
	templates: {
		footer:      *"NAME - Page PAGE_NUMBER of TOTAL_PAGES" | string
		top_note:    *"Last updated in TODAY" | string
		single_date: *"MONTH_ABBREVIATION YEAR" | string
		date_range:  *"START_DATE – END_DATE" | string
		time_span:   *"HOW_MANY_YEARS YEARS HOW_MANY_MONTHS MONTHS" | string

		one_line_entry: {
			main_column: *"**LABEL:** DETAILS" | string
		}
		education_entry: {
			main_column: *"""
				**INSTITUTION**, DEGREE in AREA -- LOCATION
				SUMMARY
				HIGHLIGHTS
				""" | string
			date_and_location_column: *"DATE" | string
			degree_column:            *"" | string
		}
		normal_entry: {
			main_column: *"""
				**NAME** -- **LOCATION**
				SUMMARY
				HIGHLIGHTS
				""" | string
			date_and_location_column: *"DATE" | string
		}
		experience_entry: {
			main_column: *"""
				**POSITION**, COMPANY -- LOCATION
				SUMMARY
				HIGHLIGHTS
				""" | string
			date_and_location_column: *"DATE" | string
		}
		publication_entry: {
			main_column: *"""
				**TITLE**
				SUMMARY
				AUTHORS
				URL (JOURNAL)
				""" | string
			date_and_location_column: *"DATE" | string
		}
	}
}

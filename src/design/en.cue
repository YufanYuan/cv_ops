package design

en: {
	theme: "engineeringresumes"
	page: {
		size:                   *"us-letter" | string
		top_margin:             *"2cm" | string
		bottom_margin:          *"2cm" | string
		left_margin:            *"2cm" | string
		right_margin:           *"2cm" | string
		show_page_numbering:    *false | bool
		show_last_updated_date: *true | bool
	}
	colors: {
		text:                                 *"rgb(0, 0, 0)" | string
		name:                                 *"rgb(0, 0, 0)" | string
		connections:                          *"rgb(0, 0, 0)" | string
		section_titles:                       *"rgb(0, 0, 0)" | string
		links:                                *"rgb(0, 0, 0)" | string
		last_updated_date_and_page_numbering: *"rgb(128, 128, 128)" | string
	}
	text: {
		font_family:                        *"XCharter" | string
		font_size:                          *"10pt" | string
		leading:                            *"0.6em" | string
		alignment:                          *"justified" | string
		date_and_location_column_alignment: *"right" | string
	}
	links: {
		underline:              *true | bool
		use_external_link_icon: *false | bool
	}
	header: {
		name_font_family:                                     *"XCharter" | string
		name_font_size:                                       *"25pt" | string
		name_bold:                                            *false | bool
		photo_width:                                          *"3.5cm" | string
		vertical_space_between_name_and_connections:          *"0.7cm" | string
		vertical_space_between_connections_and_first_section: *"0.7cm" | string
		horizontal_space_between_connections:                 *"0.5cm" | string
		connections_font_family:                              *"XCharter" | string
		separator_between_connections:                        *"|" | string
		use_icons_for_connections:                            *false | bool
		alignment:                                            *"center" | string
	}
	section_titles: {
		type:                 *"with-parial-line" | string
		font_family:          *"XCharter" | string
		font_size:            *"1.2em" | string
		bold:                 *true | bool
		small_caps:           *false | bool
		line_thickness:       *"0.5pt" | string
		vertical_space_above: *"0.55cm" | string
		vertical_space_below: *"0.3cm" | string
		line_type:            *"with-full-line" | string
	}
	entries: {
		date_and_location_width:          *"4.15cm" | string
		left_and_right_margin:            *"0cm" | string
		horizontal_space_between_columns: *"0.1cm" | string
		vertical_space_between_entries:   *"0.4cm" | string
		allow_page_break_in_sections:     *true | bool
		allow_page_break_in_entries:      *true | bool
		short_second_row:                 *false | bool
		show_time_spans_in: []
	}
	highlights: {
		bullet:                                        *"•" | string
		top_margin:                                    *"0.25cm" | string
		left_margin:                                   *"0cm" | string
		vertical_space_between_highlights:             *"0.19cm" | string
		horizontal_space_between_bullet_and_highlight: *"0.3em" | string
		summary_left_margin:                           *"0cm" | string
	}
	entry_types: {
		one_line_entry: {
			template: *"**LABEL:** DETAILS" | string
		}
		education_entry: {
			main_column_first_row_template: *"**INSTITUTION**, DEGREE in AREA -- LOCATION" | string
			degree_column_template:         *"" | string
			degree_column_width:            *"1cm" | string
			main_column_second_row_template: *"""
				SUMMARY
				HIGHLIGHTS
				""" | string
			date_and_location_column_template: *"DATE" | string
		}
		normal_entry: {
			main_column_first_row_template: *"**NAME** -- **LOCATION**" | string
			main_column_second_row_template: *"""
				SUMMARY
				HIGHLIGHTS
				""" | string
			date_and_location_column_template: *"DATE" | string
		}
		experience_entry: {
			main_column_first_row_template: *"**POSITION**, COMPANY -- LOCATION" | string
			main_column_second_row_template: *"""
				SUMMARY
				HIGHLIGHTS
				""" | string
			date_and_location_column_template: *"DATE" | string
		}
		publication_entry: {
			main_column_first_row_template: *"**TITLE**" | string
			main_column_second_row_template: *"""
				AUTHORS
				URL (JOURNAL)
				""" | string
			main_column_second_row_without_journal_template: *"""
				AUTHORS
				URL
				""" | string
			main_column_second_row_without_url_template: *"""
				AUTHORS
				JOURNAL
				""" | string
			date_and_location_column_template: *"DATE" | string
		}
	}
}

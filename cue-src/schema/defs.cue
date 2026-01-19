package schema

#Demographics: {
	name:   string
	gender: string
	age:    int
	contact: {
		phone: string
		email: string
	}
	social_networks: [...{
		network:  "LinkedIn" | "GitHub" | "Portfolio" | "Website" | string
		username: string
		url:      string
	}]
	location: string
}

#Education: {
	institution: string
	area:        string
	degree:      string
	start_date:  string
	end_date:    string | *"Present"
	location:    string
	highlights:  [...string]
}

#STARHighlight: {
	// 1. Context / Background
	context: string

	// 2. Business Objective
	objective: string

	// 3. Challenge encountered
	challenge: string

	// 4. Solution / Action taken
	action: string

	// 5. Result / Outcome
	result: string
}

#Experience: {
	title:      string
	company:    string
	start_date: string
	end_date:   string | *"Present"
	location:   string
	brief:      string // Overall brief for the role
	highlights: [...#STARHighlight]
}

#Publication: {
	title:       string
	type:        "Journal" | "Conference" | "Patent" | "Book" | string
	date:        string
	description: string
}

#Skill: {
	label:   string
	details: string | [...string]
}

// Master container for a person's details
#Profile: {
	demographics: #Demographics
	education:    [...#Education]
	experience:   [...#Experience]
	publications: [...#Publication]
	skills:       [...#Skill]
}

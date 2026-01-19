package content

example_en: #DocBase & {
	_locale: "en"

	cv: {
		name:     "Wei Wang"
		location: "Shanghai, China"
		email:    "wang.wei@example.com"
		phone:    "+86-139-1234-5678"
		social_networks: [
			{
				network:  "LinkedIn"
				username: "wangwei_example"
			}
		]

		sections: {
			education: [
				{
					institution: "Tsinghua University"
					area:        "Architecture"
					degree:      "Master of Architecture"
					start_date:  "2008-09"
					end_date:    "2011-06"
					location:    "Beijing, China"
				},
				{
					institution: "Tongji University"
					area:        "Civil Engineering"
					degree:      "Bachelor of Engineering"
					start_date:  "2004-09"
					end_date:    "2008-06"
					location:    "Shanghai, China"
				},
			]

			experience: [
				{
					company:    "Skyline Architects"
					position:   "Senior Partner / Design Director"
					start_date: "2018-03"
					end_date:   "present"
					location:   "Shanghai, China"
					summary: """
						As the core design leader of the firm, responsible for guiding the conceptual design and scheme development of large-scale commercial complexes and cultural landmarks. Leading a design team of 50 people, ensuring that the process from conception to realization meets extremely high aesthetic standards and sustainability requirements.
						"""
					highlights: [
						"""
Led the design of the "Future Light" Science Center, which won the 2022 Asian Architectural Design Gold Award. By adopting an innovative double-skin breathing curtain wall system, building energy consumption was reduced by 25%, becoming a model for green architecture.
""",
						"""
Responsible for the planning and implementation of the "Cloud Garden" super high-rise residential project, successfully solving sunlight and ventilation challenges in a high-density urban environment, creating a unique vertical green living experience for residents.
""",
						"""
Established and optimized the firm's internal BIM collaborative workflow, reducing design change turnaround time by 40% and significantly improving cross-disciplinary collaboration efficiency.
""",
					]
				},
				{
					company:    "Blueprint Design Institute"
					position:   "Lead Architect"
					start_date: "2011-07"
					end_date:   "2018-02"
					location:   "Shenzhen, China"
					summary: """
						Focused on urban renewal and public space renovation projects. Responsible for preliminary project research, conceptual scheme development, and design development, maintaining close communication with government departments and developers.
						"""
					highlights: [
						"""
Presided over the renovation project of an old industrial park in Shenzhen, transforming abandoned factories into a vibrant creative cultural block. The project was rated as the annual urban renewal demonstration case.
""",
						"""
Designed multiple pocket parks located in the city center, significantly improving the surrounding microclimate and social environment for residents through exquisite landscape and street furniture design.
""",
					]
				},
			]

			skills: [
				{
					label:   "Software Proficiency"
					details: "Proficient in AutoCAD, Rhino, Grasshopper, Revit, SketchUp, Lumion; Familiar with V-Ray, Adobe Creative Suite"
				},
				{
					label:   "Professional Expertise"
					details: "Green Building Design, Parametric Design, Urban Renewal, Full-process BIM Management"
				},
				{
					label:   "Languages"
					details: "Chinese (Native), English (Fluent, Professional Working Proficiency)"
				},
			]

			"publications and patents": [
				"Wang, W., et al. Application of Parametric Design in High-rise Building Facades. Architectural Journal, 2020.",
				"A Curtain Wall Structure Based on Natural Ventilation, Utility Model Patent",
				"Research on Vertical Greening Systems in High-density Urban Environments, Architectural Journal, 2019",
			]
		}
	}
}

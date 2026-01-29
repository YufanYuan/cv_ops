package details

import S "yufan.resume/schema"

education: [...S.#Education] & [
	{
		institution: "Stanford University"
		area:        "Computer Science"
		degree:      "Master of Science (M.S.)"
		start_date:  "2018-09"
		end_date:    "2020-06"
		location:    "Stanford, CA"
		highlights: [
			"Specialization: Artificial Intelligence & Machine Learning",
			"Thesis: Optimizing Large Language Model Inference on Edge Devices",
			"Teaching Assistant for CS224n: Natural Language Processing",
		]
	},
	{
		institution: "University of California, Berkeley"
		area:        "Electrical Engineering & Computer Sciences (EECS)"
		degree:      "Bachelor of Science (B.S.)"
		start_date:  "2014-09"
		end_date:    "2018-05"
		location:    "Berkeley, CA"
		highlights: [
			"GPA: 3.9/4.0, Dean's List",
			"Winner of Cal Hacks 2017 for 'VisionAssist' (Accessibility App)",
		]
	},
]

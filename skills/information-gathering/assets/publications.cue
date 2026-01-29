package details

import S "yufan.resume/schema"

publications: [...S.#Publication] & [
	{
		title:       "Efficient Token Sampling Strategies for Real-time Agents"
		type:        "Conference"
		date:        "2023"
		description: "Presented at NeurIPS 2023 Workshop on Generative AI. Proposed a novel sampling method reducing latency by 15%."
	},
	{
		title:       "Building Scalable Event-Driven Architectures with Go"
		type:        "Article"
		date:        "2021"
		description: "Featured contribution on the Go Blog, discussing patterns for high-throughput system design."
	},
	{
		title:       "VisionAssist: Real-time Object Detection for Visually Impaired"
		type:        "Competition"
		date:        "2017"
		description: "Cal Hacks 2017 First Prize Project. Open sourced on GitHub with 2k+ stars."
	},
]

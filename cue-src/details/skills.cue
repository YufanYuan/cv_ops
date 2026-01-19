package details

import S "yufan.resume/schema"

skills: [...S.#Skill] & [
	{
		label:   "Languages"
		details: "Python, Go (Golang), TypeScript, Rust, C++, SQL"
	},
	{
		label:   "AI & ML"
		details: "PyTorch, TensorFlow, LangChain, HuggingFace Transformers, CUDA, RAG, LLM Fine-tuning"
	},
	{
		label:   "Backend & Infra"
		details: "Kubernetes (K8s), Docker, gRPC, Kafka, PostgreSQL, Redis, AWS (Lambda, EC2, S3), Terraform"
	},
	{
		label:   "Frontend"
		details: "React, Next.js, Vue.js, TailwindCSS, WebGL (Three.js), React Native"
	},
	{
		label:   "Tools & Practices"
		details: "Git, CI/CD (GitHub Actions), Agile/Scrum, System Design, Microservices"
	},
]

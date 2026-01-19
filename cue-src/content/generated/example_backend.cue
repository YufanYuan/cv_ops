package content

import (
	D "yufan.resume/design"
	L "yufan.resume/locale"
)

example_backend: #DocBase & {
	_locale: "en"
	cv: {
		name:     "Alex Chen"
		location: "San Francisco, CA (Open to Remote / Seattle)"
		email:    "alex.chen@example.com"
		phone:    ""
		social_networks: [
			{
				network:  "LinkedIn"
				username: "alexchen-dev"
			},
			{
				network:  "GitHub"
				username: "alexcode"
			},
		]

		sections: {
			Summary: [
				{
					label:   "Senior Staff Backend / Infrastructure Engineer"
					details: "Distributed systems engineer specializing in high-throughput services, petabyte-scale persistence patterns (PostgreSQL sharding, replication), Kubernetes at scale (custom autoscaling), reliability engineering (rate limiting, incident tooling), and observability (OpenTelemetry tracing). Strong Go and Rust; extensive gRPC/Protobuf API standardization and zero-downtime migrations."
				},
			]

			Experience: [
				{
					company:    "CloudScale (Big Tech)"
					position:   "Senior Backend Engineer"
					start_date: "2020-07"
					end_date:   "2022-12"
					location:   "Seattle, WA"
					summary:    "Core infrastructure engineer focused on high-concurrency distributed systems, service-to-service APIs, Kubernetes scaling, and reliability/observability for large microservice fleets."
					highlights: [
						"Designed and executed a zero-downtime dual-write migration for a global event bus (~50k events/sec), shipping a Go reconciliation tool to ensure correctness; completed with zero data loss and improved multi-region replication lag by 60%.",
						"Architected application-layer PostgreSQL sharding for a 50TB primary user datastore; performed online migration using logical replication and cutover playbooks, scaling to 16 instances and increasing write throughput capacity by 10x.",
						"Led distributed tracing rollout across 200+ microservices using OpenTelemetry and service-mesh sidecars, enabling end-to-end traceability and reducing incident investigation time from ~4 hours to ~30 minutes.",
						"Built a custom Kubernetes autoscaling mechanism (KEDA scaler) tuned for request-rate acceleration to reduce latency spikes; eliminated scale-up throttling during peak traffic and reduced idle compute costs by $2M/year.",
						"Implemented a distributed sliding-window rate limiter (Redis + Lua atomic ops) to prevent cascading failures during surges; helped avert 3 major outage scenarios during peak-season traffic.",
						"Defined engineering standards for inter-service APIs by centralizing Protobuf definitions and migrating 50+ services from REST/JSON to gRPC; reduced payload size ~40% and serialization CPU by ~70%.",
					]
				},
				{
					company:    "NexusAI"
					position:   "Senior AI Engineer / Tech Lead"
					start_date: "2023-01"
					end_date:   "present"
					location:   "San Francisco, CA"
					summary:    "Tech lead for platform infrastructure powering agentic product workloads, with focus on low-latency inference services, reliability, and Kubernetes-based systems."
					highlights: [
						"Refactored the inference engine into a modular gRPC microservice architecture to support multi-modal workloads (e.g., CLIP/Whisper services), improving isolation and performance of latency-critical paths.",
						"Built and operated a self-hosted Qdrant vector DB cluster on Kubernetes (100M+ vectors), improving retrieval latency from ~500ms to ~50ms and reducing infrastructure costs by 40%.",
						"Developed automated evaluation gates (“LLM-as-a-judge”) to prevent production regressions and accelerate release cadence from bi-weekly to daily, strengthening reliability of rapid iteration.",
					]
				},
			]

			Education: [
				{
					institution: "Stanford University"
					area:        "Computer Science"
					degree:      "Master of Science (M.S.)"
					start_date:  "2018-09"
					end_date:    "2020-06"
					location:    "Stanford, CA"
					details: [
						"Thesis: Optimizing Large Language Model Inference on Edge Devices",
						"Teaching Assistant: CS224n (Natural Language Processing)",
					]
				},
				{
					institution: "University of California, Berkeley"
					area:        "Electrical Engineering & Computer Sciences (EECS)"
					degree:      "Bachelor of Science (B.S.)"
					start_date:  "2014-09"
					end_date:    "2018-05"
					location:    "Berkeley, CA"
					details: [
						"GPA: 3.9/4.0; Dean's List",
					]
				},
			]

			Skills: [
				{
					label:   "Languages"
					details: "Go (Golang), Rust, SQL, Python"
				},
				{
					label:   "Distributed Systems & APIs"
					details: "gRPC/Protobuf, Kafka/event-driven architecture, high-concurrency services, multi-region replication patterns"
				},
				{
					label:   "Data & Caching"
					details: "PostgreSQL (sharding, logical replication), Redis (atomic Lua scripts), vector DB operations (Qdrant)"
				},
				{
					label:   "Kubernetes & Platform"
					details: "Kubernetes at scale, custom autoscaling (KEDA), Docker, service mesh sidecars"
				},
				{
					label:   "Observability & Reliability"
					details: "OpenTelemetry distributed tracing, metrics instrumentation, incident tooling (ChatOps), rate limiting"
				},
			]

			Publications: [
				"Building Scalable Event-Driven Architectures with Go (Article, 2021)",
				"Efficient Token Sampling Strategies for Real-time Agents (Conference, 2023)",
			]
		}
	}
}
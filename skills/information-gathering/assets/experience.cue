package details

import S "yufan.resume/schema"

experience: [...S.#Experience] & [
	{
		company:    "NexusAI"
		title:      "Senior AI Engineer / Tech Lead"
		start_date: "2023-01"
		end_date:   "present"
		location:   "San Francisco, CA"
		brief:      "Leading the Agent Framework team at a Series B AI startup. Architecting the core infrastructure for autonomous LLM agents and optimizing inference performance."
		highlights: [
			{
				context:   "Self-Healing Agent Framework Development"
				objective: "Enable autonomous agents to recover from API failures and logic errors without human intervention."
				challenge: "LLM hallucinations and flaky external APIs caused 20% of long-running tasks to fail permanently."
				action:    "Designed a recursive reflection loop using LangChain and a custom specific domain-specific language (DSL) for error classification."
				result:    "Reduced task failure rate to <2%, increasing customer retention by 15% and enabling 24/7 autonomous operations."
			},
			{
				context:   "Vector Database Optimization"
				objective: "Reduce latency and cost for RAG (Retrieval-Augmented Generation) pipelines at scale (100M+ vectors)."
				challenge: "Naive cosine similarity search was becomisng too slow (500ms+) as the dataset grew exponentially."
				action:    "Migrated from Pinecone to a self-hosted Qdrant cluster on Kubernetes, implementing HNSW indexing and quantization."
				result:    "Slash retrieval latency to 50ms (10x improvement) and reduced infrastructure costs by 40%."
			},
			{
				context:   "Multi-Modal Model Integration"
				objective: "Expand product capabilities to support image and audio processing constraints."
				challenge: "Existing pipeline was text-only and tightly coupled to OpenAI's completion API."
				action:    "Refactored the core inference engine into a modular 'Brain' architecture, integrating CLIP and Whisper models via gRPC microservices."
				result:    "Successfully launched 'Nexus Vision', capturing a new market segment of creative professionals."
			},
			{
				context:   "Automated LLM Eval Pipeline"
				objective: "Quantitatively measure model performance improvements to prevent regressions during deployments."
				challenge: "Subjective manual testing was unscalable and delayed release cycles by days."
				action:    "Built an 'LLM-as-a-Judge' pipeline using GPT-4 to grade output relevance and faithfulness against a Golden Dataset."
				result:    "Accelerated release cadence from bi-weekly to daily; caught significant regression in reasoning capabilities before production."
			},
			{
				context:   "Cost Optimization Router"
				objective: "Reduce exorbitant Open AI API bills without degrading user experience or accuracy."
				challenge: "Using GPT-4 for every prompt was overkill for simple queries like greeting or classification."
				action:    "Developed a semantic router that dynamically routes simple queries to Haiku/GPT-3.5 and complex ones to GPT-4 based on perplexity scores."
				result:    "Reduced average per-query cost by 65% with no statistically significant drop in CSAT scores."
			},
			{
				context:   "Enterprise Safety Guardrails"
				objective: "Ensure compliance with strict data privacy laws (GDPR/CCPA) for enterprise banking clients."
				challenge: "Risk of PII leakage or prompt injection attacks in a regulated environment."
				action:    "Implemented a middleware layer using Microsoft Presidio for PII redaction and NeMo Guardrails for topical containment."
				result:    "Passed SOC2 audit and unblocked $2M ARR deal with a Fortune 500 bank."
			},
			{
				context:   "Domain-Specific Fine-Tuning"
				objective: "Improve model accuracy for a legal-tech client requiring specialized contract terminology."
				challenge: "General purpose models consistently misinterpreted specific clause nuances."
				action:    "Curated a dataset of 50k legal documents and fine-tuned a Mistral-7B model using LoRA on 4x A100 GPUs."
				result:    "Achieved 92% accuracy on the legal benchmark (vs 78% for base GPT-4) while reducing inference cost by 10x."
			},
			{
				context:   "Real-time Voice Agent Latency"
				objective: "Build a conversational voice agent with 'human-like' response times."
				challenge: "Standard STT -> LLM -> TTS pipeline introduced 3-4 seconds of latency, breaking immersion."
				action:    "Optimized the pipeline using VAD (Voice Activity Detection), optimistic streaming, and WebRTC."
				result:    "Reduced end-to-end voice latency to sub-800ms, enabling natural, interruptible conversations."
			},
		]
	},
	{
		company:    "CloudScale (Big Tech)"
		title:      "Senior Backend Engineer"
		start_date: "2020-07"
		end_date:   "2022-12"
		location:   "Seattle, WA"
		brief:      "Core infrastructure team. specialized in high-concurrency distributed systems and developer tooling."
		highlights: [
			{
				context:   "Global Event Bus Migration"
				objective: "Replace legacy Kafka setup with a managed, multi-region event mesh to support 99.999% availability."
				challenge: "Zero-downtime requirement for a system handling 50k events/second."
				action:    "Implemented a dual-write migration strategy and developed a custom reconciliation tool in Go."
				result:    "Migration completed with zero data loss or downtime; improved cross-region replication lag by 60%."
			},
			{
				context:   "Kubernetes Autoscaling Engine"
				objective: "Optimize resource usage for thousands of internal microservices."
				challenge: "Default HPA (Horizontal Pod Autoscaler) was reacting too slowly to traffic spikes, causing 5xx errors."
				action:    "Built a custom KEDA scaler based on request rate acceleration rather than just CPU/Memory integration."
				result:    "Eliminated scale-up throttling during peak traffic and reduced idle compute costs by $2M/year."
			},
			{
				context:   "Developer Experience (DevEx) Platform"
				objective: "Standardize internal tooling for 500+ engineers."
				challenge: "Fragmented scripts and varied local environments led to 'it works on my machine' issues."
				action:    "Developed a CLI tool in Rust that unified build, test, and deploy workflows, integrating with a remote build cache."
				result:    "Reduced average build times by 50% and improved engineer onboarding speed."
			},
			{
				context:   "Zero-Downtime Data Sharding"
				objective: "Scale the primary user database beyond the capacity of a single write master."
				challenge: "The 50TB PostgreSQL cluster was hitting IOPS limits, threatening system stability."
				action:    "Architected an application-layer sharding strategy and executed online migration using logical replication."
				result:    "Successfully sharded data across 16 instances, increasing write throughput capacity by 10x."
			},
			{
				context:   "Distributed Tracing Rollout"
				objective: "Reduce MTTR (Mean Time To Resolution) for complex cross-service bugs."
				challenge: "Debugging requests across 200+ microservices was guesswork relying on disjointed logs."
				action:    "Led the adoption of OpenTelemetry, adding auto-instrumentation sidecars to the service mesh."
				result:    "Provided end-to-end request visibility, reducing average incident investigation time from 4 hours to 30 minutes."
			},
			{
				context:   "API Rate Limiting System"
				objective: "Protect downstream services from cascading failures during traffic surges."
				challenge: "Naive token bucket implementation in memory was drifting across instances."
				action:    "Implemented a distributed sliding window rate limiter using Redis and Lua scripts for atomicity."
				result:    "Prevented 3 major cascading outage incidents during Black Friday traffic peaks."
			},
			{
				context:   "ChatOps Incident Bot"
				objective: "Streamline incident response and communication."
				challenge: "Context switching between Slack, Jira, and PagerDuty slowed down response coordination."
				action:    "Built a Slack bot (Golang) that allows engineers to declare incidents, create Zoom bridges, and trigger rollbacks via chat commands."
				result:    "Adopted by 100% of engineering teams; reduced incident coordination overhead by estimated 20%."
			},
			{
				context:   "Legacy API Migration (REST to gRPC)"
				objective: "Improve inter-service communication performance and type safety."
				challenge: "JSON serialization overhead was consuming significant CPU resources on high-throughput services."
				action:    "Defined a centralized Protobuf repo and generated clients for 50+ services, migrating critical paths to gRPC."
				result:    "Reduced average payload size by 40% and CPU usage for serialization by 70%."
			},
		]
	},
	{
		company:    "StartUp Inc (FinTech)"
		title:      "Full Stack Developer -> Frontend Lead"
		start_date: "2018-06"
		end_date:   "2020-06"
		location:   "Boston, MA"
		brief:      "Early employee at a fast-growing Fintech Key contributor to the mobile app and web dashboard."
		highlights: [
			{
				context:   "Mobile App Launch (iOS/Android)"
				objective: "Launch the MVP within 3 months to secure Series A funding."
				challenge: "Limited resources and need for cross-platform consistency."
				action:    "Chose React Native for rapid development, building shared UI components and state management logic."
				result:    "Launched on time, acquiring 10k users in the first month and securing $5M in funding."
			},
			{
				context:   "Real-time Trading Dashboard"
				objective: "Provide users with sub-second updates on stock prices."
				challenge: "Handling high-frequency WebSocket updates without freezing the main UI thread."
				action:    "Optimized the React rendering cycle using Web Workers for data processing and virtualized lists for UI."
				result:    "Achieved smooth 60fps performance even during market volatility, increasing user session time by 20%."
			},
			{
				context:   "Legacy Code Refactoring involved"
				objective: "Migrate specific jQuery legacy pages to Vue.js."
				challenge: "Need to maintain feature parity while modernizing the codebase."
				action:    "Adopted a strangler fig pattern, incrementally replacing components impacting user flow."
				result:    "Modernized 80% of the codebase, significantly reducing technical debt and bug reports."
			},
			{
				context:   "Design System Implementation"
				objective: "Ensure visual consistency across marketing, web app, and internal tools."
				challenge: "Developers were copy-pasting CSS, leading to UI fragmentation and difficult maintenance."
				action:    "Built an 'Atomic Design' component library using Storybook and rolled it out as an npm package."
				result:    "Reduced frontend development time for new features by 30% and unified the brand identity."
			},
			{
				context:   "PWA Conversion"
				objective: "Improve mobile web retention for users reluctant to install native apps."
				challenge: "Unreliable network connectivity for users carrying out transactions on the go."
				action:    "Implemented Service Workers for offline caching of static assets and critical user state."
				result:    "Increased mobile web retention by 25% and reduced time-to-interactive on 3G networks."
			},
			{
				context:   "Core Web Vitals Optimization"
				objective: "Improve search ranking (SEO) and user acquisition funnel."
				challenge: "LCP (Largest Contentful Paint) was > 4s due to heavy unoptimized hero images and JS bundles."
				action:    "Implemented image optimization pipeline (WebP), code splitting, and server-side rendering (SSR)."
				result:    "Improved LCP to < 1.2s; organic traffic increased by 40% over the following quarter."
			},
			{
				context:   "A/B Testing Infrastructure"
				objective: "Enable product team to make data-driven decisions on UI changes."
				challenge: "Releasing new features was an 'all or nothing' risk."
				action:    "Integrated LaunchDarkly feature flags and built a React hook wrapper for easy experiment usage."
				result:    "Enabled the team to run 5+ concurrent experiments per week, leading to a 10% lift in conversion."
			},
			{
				context:   "Accessibility (a11y) Overhaul"
				objective: "Ensure the platform is usable by users with disabilities and meets WCAG 2.1 standards."
				challenge: "Keyboard navigation was broken and screen reader support was non-existent."
				action:    "Audited the app using Axe, implemented semantic HTML, ARIA roles, and proper focus management."
				result:    "Achieved WCAG AA compliance and received positive feedback from accessibility advocacy groups."
			},
		]
	},
]

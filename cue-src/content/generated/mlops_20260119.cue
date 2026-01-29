package content



mlops_20260119: #DocBase & {
	_locale: "zh"
	cv: {
		name:     "Yufan Yuan"
		location: "旧金山, CA (可远程 / 纽约)"
		email:    "yufan.yuan@example.com"
		phone:    "123-456-7890"
		social_networks: [
			{
				network:  "LinkedIn"
				username: "yufanyuan-ai"
			},
			{
				network:  "GitHub"
				username: "yufanyuan"
			},
		]

		sections: {
			Summary: [
				{
					label:   "首席 MLOps 工程师 (LLM 平台)"
					details: "专注于构建大规模推理计算层和 AGI 基础设施的首席工程师。擅长桥接研究模型与生产级 API，确保大语言模型的高效、可靠和安全运行。在构建高性能推理管道（Triton, CUDA）、大规模向量搜索系统（Qdrant）和鲁棒的 LLM 评估框架（LLM-as-a-Judge）方面拥有深厚背景。致力于降低推理延迟、优化 GPU 利用率并实施企业级安全护栏。"
				},
			]

			Experience: [
				{
					company:    "NexusAI"
					position:   "高级 AI 工程师 / 技术负责人"
					start_date: "2023-01"
					end_date:   "至今"
					location:   "旧金山, CA"
					summary:    "作为 B 轮 AI 初创公司 Agent 框架团队的技术负责人，架构自主 LLM Agent 的核心基础设施并优化推理性能。"
					highlights: [
						"**向量数据库优化 (RAG)**: 建立并维护 Kubernetes 上自托管的 Qdrant 向量数据库集群（1亿+ 向量），通过 HNSW 索引和量化技术，将检索延迟从 ~500ms 降低至 ~50ms (10倍提升)，并降低了 40% 的基础设施成本。",
						"**自动化 LLM 评估流水线**: 构建“LLM-as-a-Judge”评估管道，使用 GPT-4 对输出的相关性和忠实度进行评分，防止生产环境模型能力回退，将发布周期从双周加速至每日。",
						"**成本优化路由**: 开发语义路由器，根据查询困惑度动态路由请求至 Haiku/GPT-3.5 或 GPT-4，在不影响用户体验的情况下将平均单次查询成本降低了 65%。",
						"**自愈 Agent 框架**: 设计基于递归反射循环的 Agent 框架，使系统能够自动从 LLM 幻觉和不稳定 API 错误中恢复，将长期运行任务的失败率降低至 <2%。",
						"**企业安全护栏**: 实施基于 Microsoft Presidio 的 PII 数据脱敏中间件和 NeMo Guardrails 话题控制，确保符合 GDPR/CCPA 标准，助力通过 SOC2 审计并解锁 $2M 企业订单。",
					]
				},
				{
					company:    "CloudScale (Big Tech)"
					position:   "高级后端工程师"
					start_date: "2020-07"
					end_date:   "2022-12"
					location:   "西雅图, WA"
					summary:    "核心基础设施团队成员，专注于高并发分布式系统、微服务架构和开发者工具。"
					highlights: [
						"**Kubernetes 自动扩缩容引擎**: 构建了针对请求速率加速进行优化的自定义 KEDA 缩放器，解决了默认 HPA 反应滞后的问题，消除了流量高峰期间的扩容截流，每年节省闲置计算成本 $2M。",
						"**API 限流系统**: 使用 Redis 和 Lua 原子脚本实施分布式滑动窗口限流器，防止了黑五流量激增期间下游服务的级联故障。",
						"**遗留 API 迁移 (gRPC)**: 制定服务间通信标准，建立中心化 Protobuf 仓库并将 50+ 关键服务从 REST/JSON 迁移至 gRPC，减少了 ~40% 的载荷大小和 ~70% 的序列化 CPU 消耗。",
					]
				},
			]

			Education: [
				{
					institution: "斯坦福大学 (Stanford University)"
					area:        "计算机科学"
					degree:      "理学硕士 (M.S.)"
					start_date:  "2018-09"
					end_date:    "2020-06"
					location:    "加利福尼亚州"
					details: [
						"专注于人工智能与系统方向",
						"助教: CS224n (自然语言处理)",
					]
				},
				{
					institution: "加州大学伯克利分校 (UC Berkeley)"
					area:        "电气工程与计算机科学 (EECS)"
					degree:      "理学学士 (B.S.)"
					start_date:  "2014-09"
					end_date:    "2018-05"
					location:    "加利福尼亚州"
					details: [
						"GPA: 3.9/4.0; 院长荣誉名单",
					]
				},
			]

			Skills: [
				{
					label:   "ML & AI 部署"
					details: "vLLM, TGI, TensorRT-LLM, Triton Inference Server, CUDA, PyTorch, LoRA/QLoRA 微调, 量化 (Quantization)"
				},
				{
					label:   "MLOps & 基础设施"
					details: "Kubernetes (K8s), Docker, Kubeflow, Ray, MLflow, Prometheus, Grafana, OpenTelemetry"
				},
				{
					label:   "数据与存储"
					details: "Vector Databases (Qdrant, Milvus, Pinecone), PostgreSQL, Redis, Kafka, Data Lakehouse"
				},
				{
					label:   "编程语言"
					details: "Python (高性能), C++, Go (Golang), SQL"
				},
			]
		}
	}
}

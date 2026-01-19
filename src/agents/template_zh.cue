package content

example_cn: #DocBase & {
	_locale: "zh"
	cv: {
		name:     "王伟"
		location: "上海"
		email:    "wang.wei@example.com"
		phone:    "+86-139-1234-5678"
		social_networks: [
			{
				network:  "LinkedIn"
				username: "wangwei_example"
			}
		]

		sections: {
			教育背景: [
				{
					institution: "清华大学"
					area:        "建筑学"
					degree:      "建筑学硕士"
					start_date:  "2008-09"
					end_date:    "2011-06"
					location:    "中国北京"
				},
				{
					institution: "同济大学"
					area:        "土木工程"
					degree:      "工学学士"
					start_date:  "2004-09"
					end_date:    "2008-06"
					location:    "中国上海"
				},
			]

			工作经验: [
				{
					company:    "天际线建筑事务所"
					position:   "高级合伙人 / 设计总监"
					start_date: "2018-03"
					end_date:   "present"
					location:   "中国上海"
					summary:    "作为事务所的核心设计领导，负责指导大型商业综合体与文化地标项目的概念设计与方案深化。带领50人的设计团队，确保项目从构思到落地的过程符合极高的审美标准与可持续发展要求。"
					highlights: [
						"主导设计了“未来之光”科技中心，该项目荣获2022年度亚洲建筑设计金奖。通过采用创新的双层呼吸式幕墙系统，将建筑能耗降低了25%，成为绿色建筑的典范。",
						"负责“云端花园”超高层住宅项目的规划与实施，成功解决了高密度城市环境下的日照与通风难题，为住户创造了独特的空中垂直绿化居住体验。",
						"建立并优化了事务所内部的BIM协同工作流，将设计变更周转时间缩短了40%，显著提升了跨专业协作效率。",
					]
				},
				{
					company:    "蓝图设计院"
					position:   "主创建筑师"
					start_date: "2011-07"
					end_date:   "2018-02"
					location:   "中国深圳"
					summary:    "专注于城市更新与公共空间改造项目。负责项目的前期调研、概念方案推敲及扩初设计，与政府部门及开发商进行密切沟通。"
					highlights: [
						"主持了深圳某旧工业园区的改造项目，将废弃厂房转化为充满活力的创意文化街区，该项目被评为年度城市更新示范案例。",
						"设计了多座位于市中心的口袋公园，通过精巧的景观与小品设计，极大改善了周边的微气候与居民的社交环境。",
					]
				},
			]

			技能与专长: [
				{
					label:   "专业软件"
					details: "精通 AutoCAD, Rhino, Grasshopper, Revit, SketchUp, Lumion; 熟练使用 V-Ray, Adobe Creative Suite"
				},
				{
					label:   "专业领域"
					details: "绿色建筑设计，参数化设计，城市更新，BIM全流程管理"
				},
				{
					label:   "语言能力"
					details: "中文 (母语), 英语 (流利，可作为工作语言)"
				},
			]

			论文与专利: [
				"Wang, W., et al. Application of Parametric Design in High-rise Building Facades. Architectural Journal, 2020.",
				"一种基于自然通风的建筑幕墙结构，实用新型专利",
				"高密度城市环境下的立体绿化系统研究，建筑学报，2019",
			]
		}
	}
}

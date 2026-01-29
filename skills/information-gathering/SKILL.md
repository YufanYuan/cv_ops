---
name: information-gathering
description: Systematically gather and deep-dive into user's background information including demographics, education, experience, publications, and skills.
---

# Information Gathering (Background Deep-Dive)

## When to use
Use this skill when you need to collect or enrich the user's master data for resume generation. This is especially important when:
- Starting a new resume project with no existing data
- Existing master data in `cue-src/details/` is incomplete or outdated
- The user wants to add new experiences, education, or accomplishments

## Prerequisites
- Run `./configure.sh` once to install `cue`, `just`, and `uv` into `./.bin`.
- Ensure the tools are on PATH for this session: `export PATH="$PWD/.bin:$PATH"`.

## Inputs
- `category` (optional): Focus on a specific category: `demographics`, `education`, `experience`, `publications`, or `skills`. If omitted, conduct a full profile interview.
- `locale` (optional): `zh` or `en`. Determines the language for the interview. Default: infer from user's language.

## References
- Schema definitions: `cue-src/schema/defs.cue`
- Asset templates (example format): `skills/information-gathering/assets/*.cue`
- Output location: `cue-src/details/{category}.cue`

## Output Files
The gathered information should be written to `cue-src/details/` using the following file structure:
- `cue-src/details/demographics.cue` - Basic personal info
- `cue-src/details/education.cue` - Education history
- `cue-src/details/experience.cue` - Work experience with STAR highlights
- `cue-src/details/publications.cue` - Publications, patents, competitions
- `cue-src/details/skills.cue` - Technical and soft skills

---

## Interview Flow

### Phase 1: Demographics (Basic Information)

Gather the following fields:
- **name**: Full name (as it should appear on resume)
- **gender**: Gender
- **age**: Age (optional, can be omitted in output)
- **contact.email**: Professional email address
- **contact.phone**: Phone number with country code
- **social_networks**: LinkedIn, GitHub, personal portfolio/website
- **location**: Current city/region

Example questions:
- "What is your full name as it should appear on your resume?"
- "What's your professional email and phone number?"
- "Do you have a LinkedIn profile, GitHub account, or personal website?"
- "Where are you currently located?"

---

### Phase 2: Education

For each educational experience, gather:
- **institution**: School/university name
- **area**: Major/field of study
- **degree**: Degree type (B.S., M.S., Ph.D., etc.)
- **start_date** / **end_date**: Duration (format: YYYY-MM)
- **location**: City, State/Country
- **highlights**: Notable achievements, GPA (if impressive), thesis topics, awards, relevant coursework

Example questions:
- "Which universities did you attend? Let's start with the most recent."
- "What was your major and degree?"
- "Did you have any notable achievements during your studies? (Awards, publications, high GPA, thesis topics, teaching assistant roles)"

---

### Phase 3: Experience (CRITICAL - Deep Dive Required)

**This is the most important section.** For each role, conduct a thorough interview to extract quantifiable accomplishments using the enhanced STAR framework.

#### Basic Role Information
- **company**: Company name
- **title**: Job title (can include progression, e.g., "SDE I -> SDE II")
- **start_date** / **end_date**: Duration (format: YYYY-MM, or "present")
- **location**: City, State/Country
- **brief**: 1-2 sentence overview of the role and team

#### STAR+ Highlights Deep-Dive

For EACH significant project or accomplishment, extract the following 5 elements:

| Field | Description | Example Question |
|-------|-------------|------------------|
| **context** | Project/initiative name and background | "What was this project called? What was the broader context?" |
| **objective** | Business goal or motivation | "What business problem were you trying to solve? What was the goal?" |
| **challenge** | Technical or organizational difficulty | "What made this difficult? What obstacles did you face?" |
| **action** | Specific technical actions YOU took | "What specific technologies/approaches did YOU use? What was your unique contribution?" |
| **result** | Quantifiable outcome | "What was the measurable impact? (metrics, percentages, revenue, time saved, scale)" |

#### Deep-Dive Techniques for Experience

**1. Quantification Probing**
Always push for specific numbers:
- "You mentioned you improved performance - by how much exactly? 10%? 50%? 10x?"
- "How many users/requests/transactions did this handle?"
- "What was the scale? How many services/engineers/data points?"
- "Can you estimate the business impact in terms of revenue, cost savings, or time?"

**2. Technical Depth Probing**
Get specific about technologies and approaches:
- "What specific technologies did you use? (Languages, frameworks, cloud services)"
- "Why did you choose that approach over alternatives?"
- "What was the architecture? How did the components interact?"

**3. Ownership Clarification**
Distinguish individual vs. team contributions:
- "What was YOUR specific role vs. the team's?"
- "Did you design this, implement it, or both?"
- "Who else was involved? What did you uniquely contribute?"

**4. Before/After Comparison**
Establish clear metrics for change:
- "What was the situation before you started?"
- "What was it like after you finished?"
- "How do those two compare numerically?"

**5. Impact Escalation**
Look for broader implications:
- "Did this project lead to any promotions, patents, or public recognition?"
- "Was this approach adopted elsewhere in the company?"
- "Did it influence team practices or company strategy?"

#### Minimum Requirements per Role

For each role, aim to extract:
- At least **3-5 STAR+ highlights** for significant roles (1+ years)
- At least **2-3 STAR+ highlights** for shorter roles
- Each highlight should have at least ONE quantifiable metric in the result

#### Example Experience Interview Flow

```
Agent: "Tell me about your most recent role. What company and title?"

User: "I was a Senior Engineer at TechCorp."

Agent: "Great! What team were you on and what was the team's mission?"

User: "I was on the platform team, building internal tools."

Agent: "Let's dive into your key accomplishments. What was the most impactful project you worked on?"

User: "I built a CI/CD pipeline."

Agent: "Excellent. Let me understand this better with our STAR+ framework:

1. **Context**: What prompted this initiative? Was there a name for this project?

2. **Objective**: What business goal was this serving? Why did the company need this?

3. **Challenge**: What made this technically difficult? What obstacles did you face?

4. **Action**: What specific technologies did you use? What was YOUR unique contribution?

5. **Result**: What was the measurable impact? How much faster were builds? How many engineers used it? Any cost savings?"

[Continue probing for each element until all 5 are well-defined with specifics]
```

---

### Phase 4: Publications / Patents / Competitions

For each item, gather:
- **title**: Title of the work
- **type**: "Journal", "Conference", "Patent", "Book", "Article", "Competition", etc.
- **date**: Publication year
- **description**: Brief description including venue, awards, impact (e.g., citations, stars)

Example questions:
- "Have you published any papers, articles, or blog posts?"
- "Do you hold any patents?"
- "Have you won any competitions or hackathons?"
- "Any open source projects with significant traction?"

---

### Phase 5: Skills

Organize skills into categories:
- **Languages**: Programming languages
- **AI & ML**: ML frameworks, techniques (if applicable)
- **Backend & Infra**: Databases, cloud, DevOps tools
- **Frontend**: UI frameworks (if applicable)
- **Tools & Practices**: Development tools, methodologies

Example questions:
- "What programming languages are you most proficient in?"
- "What cloud platforms and infrastructure tools do you use?"
- "What frameworks and libraries do you work with regularly?"
- "Any certifications or specialized training?"

---

## Output Format

After gathering information, write valid CUE files to `cue-src/details/`. Each file should:
1. Use `package details`
2. Import the schema: `import S "yufan.resume/schema"`
3. Follow the exact structure shown in `skills/information-gathering/assets/*.cue`

After writing, run `cue vet ./...` from `cue-src/` to validate the output.

---

## Interview Best Practices

1. **Be conversational**: Don't make it feel like a form. Have a natural dialogue.
2. **One topic at a time**: Don't overwhelm with multiple questions.
3. **Summarize and confirm**: After each major section, recap what you understood.
4. **Encourage elaboration**: Use "Tell me more about..." and "What specifically..."
5. **Celebrate accomplishments**: Acknowledge impressive achievements to encourage sharing.
6. **Handle vagueness**: If answers are vague, probe deeper: "Can you give me a specific example?"
7. **Track progress**: Let the user know which sections are complete and what's remaining.

---

## Example Prompts

- "Run /information-gathering to help me build my resume from scratch."
- "Use /information-gathering category=experience to deep-dive into my work history."
- "Run /information-gathering category=education locale=zh to gather my education background in Chinese."

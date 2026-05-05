# Output File Templates

Use these templates as the structure for each output file. Fill in all sections with content tailored to the specific job listing, the user's CV, and their profile.

## 1. analysis.md

```markdown
# Position Analysis: [Job Title] at [Company]

**Date:** [YYYY-MM-DD]
**Location:** [Location from listing]
**Source:** [URL or "PDF"]

## Position Summary

[2-3 paragraph summary of the role: what the team does, what the position entails, and how it fits within the company]

## What They Are Looking For

- [Requirement explicitly stated in the listing]
- [Another explicit requirement]
- [Inferred from the listing: soft skills, culture fit indicators]

## What They Are NOT Looking For

- [Overqualification signals or mismatches inferred from the listing]
- [Traits or backgrounds that would be a poor fit based on the role's focus]

## Your Strengths (Matches)

| Requirement | Your Experience | Match Strength |
|---|---|---|
| [Specific requirement from listing] | [Matching experience from CV with concrete details] | Strong / Moderate / Partial |

## Your Gaps (Areas to Develop)

| Requirement | Your Current Level | Gap Severity | Mitigation Strategy |
|---|---|---|---|
| [Requirement from listing] | [Current level or "No direct experience"] | Critical / Moderate / Minor | [How to address: transferable skill, quick study, etc.] |

## Overall Fit Assessment

[Honest 2-3 paragraph assessment. Include an approximate fit percentage. Be candid about both strengths and gaps. End with a recommendation on whether to apply and what to emphasize.]
```

## 2. motivation_letter.md

```markdown
Dear [Recruiter Name or extracted contact],

[Opening paragraph: a compelling hook that connects the user's background or motivation to the company's mission or the specific role. Avoid generic openings like "I am writing to apply for..."]

[Body paragraph 1: the user's strongest match with the position. Reference a specific project, achievement, or experience from the CV. Quantify impact where possible.]

[Body paragraph 2: the second strongest match. Connect a different aspect of the user's background to another key requirement. Show breadth of relevant experience.]

[Body paragraph 3: address a gap positively. Frame it as eagerness to grow, a transferable skill, or a fresh perspective the user brings. Never be apologetic about gaps.]

[Closing paragraph: express genuine motivation for this specific role (not generic interest). Reference something specific about the company. Include a clear call to action.]

Kind regards,
[User Name]
[Email from CV]
[Phone from CV]
[LinkedIn from CV or profile]
```

**Guidelines:**
- Total length: 350-450 words
- Tone: match the user's personality profile (modest, direct, enthusiastic, analytical, etc.)
- Use specific examples from the CV, never generic statements
- Use `[placeholder]` for any information that cannot be determined from available data
- Do not repeat the CV — the letter should tell a story, not list facts

## 3. preparation_plan.md

```markdown
# Preparation Plan: [Job Title] at [Company]

## Interview Process Overview

[Summary of what is publicly known about how the company interviews for this type of role. This section helps the user understand what to prepare for so the study topics below are contextualized.]

### Expected Format

- **Rounds:** [Number of rounds and overall timeline, e.g. "4 rounds over 2-3 weeks"]
- **Stages:** [Brief list of stages, e.g. "Recruiter screen → Technical deep-dive → System design → Culture/leadership fit"]
- **Question types:** [What types of questions to expect: LeetCode, take-home, pair programming, whiteboard, case study, behavioral, etc.]

### What This Means for Your Preparation

[1-2 sentences connecting the interview format to the study plan below. E.g. "Since the process includes a system design round, Priority 1 topics below emphasize architectural thinking. The behavioral round means the interview script's STAR-format answers are especially important."]

**Sources:** [List URLs where this information was found. If no company-specific data was found, state: "No public interview data found for [Company]. The above is based on typical processes for [role type] roles at similar companies in [region]."]

## Priority 1: Critical Topics (Must Study)

### [Topic Name]
- **Why:** [Direct connection to a key requirement in the listing]
- **Resources:**
  - [Specific URL to official documentation or high-quality tutorial]
  - [O'Reilly book: "Title" by Author]
  - [Course: "Title" on Platform (Coursera/Udemy/Pluralsight/etc.)]
- **Time estimate:** [X hours/days]
- **Goal:** [What the user should be able to do/explain after studying]

### [Another Critical Topic]
[Same structure]

## Priority 2: Important Topics (Should Study)

### [Topic Name]
[Same structure as above]

## Priority 3: Nice-to-Have Topics (If Time Permits)

### [Topic Name]
[Same structure as above]

## Company Research

- **Company website:** [URL]
- **Recent news:** [Key recent developments to be aware of]
- **Engineering blog:** [URL if available]
- **Glassdoor/culture:** [Key themes from reviews, if relevant]
- **Key people:** [Names and roles of likely interviewers or team leads, if discoverable]

## Suggested Timeline

| Week | Focus Area | Goal |
|---|---|---|
| Week 1 | [Critical topics] | [Specific measurable goal] |
| Week 2 | [Important topics + company research] | [Specific measurable goal] |
| Week 3 | [Nice-to-have topics + mock interviews] | [Specific measurable goal] |
```

**Guidelines:**
- The Interview Process Overview must appear before the priority topics, so the user understands what they're preparing for
- If company-specific interview data was found, cite the sources. If not, use a generic fallback based on role type and region, and clearly label it as such
- Prioritize by direct relevance to the listing's requirements
- Resources must be real and specific — include actual book titles, course names, and URLs to official documentation
- Time estimates should be realistic
- If the user already has strong skills in a topic (from CV), note it and suggest advanced resources instead

## 4. interview_script.md

```markdown
# Interview Script: [Job Title] at [Company]

## Recommended Tone

[Based on the user's personality profile and the company's culture: formal vs. conversational, assertive vs. modest, etc. Include specific guidance like "lead with curiosity" or "be direct about your achievements".]

## Expected Interview Process

[Detailed round-by-round breakdown of what the user can expect, based on the research from Step 6.]

### Round 1: [Stage Name, e.g. "Recruiter Screen"]
- **Format:** [Phone/video call, duration]
- **What to expect:** [What topics are typically covered]
- **Tips:** [Advice from real candidates or general best practices]

### Round 2: [Stage Name, e.g. "Technical Deep-Dive"]
- **Format:** [Video call/onsite, duration, who conducts it]
- **What to expect:** [Coding problems, system discussion, tech stack questions, etc.]
- **Tips:** [What candidates reported as helpful]

### Round 3: [Stage Name, e.g. "System Design"]
- **Format:** [Video call/onsite, duration]
- **What to expect:** [Type of design problems, scope, whiteboard vs. discussion]
- **Tips:** [Common themes from candidate reports]

### Round N: [Continue for as many rounds as discovered]
[Same structure]

### Overall Timeline
[Expected time from first contact to offer, if reported]

**Sources:** [URLs where this information was found. If using the generic fallback, state: "No public interview data found for [Company]. The above is a typical process for [role type] roles at similar companies in [region]. Ask the recruiter for specifics about their process."]

---

## Your Elevator Pitch (30 seconds)

[A tailored pitch that connects the user's background to this specific role. Not a generic summary — a story arc that ends with why this role is the logical next step.]

## Key Talking Points

Bring these up naturally during the conversation.

### 1. [Topic that maps to a key requirement]
- **Their need:** [What the listing says they want]
- **Your story:** [Specific project or experience from the CV]
- **Impact:** [Quantifiable result or concrete outcome]
- **Transition phrase:** [How to bring this up naturally, e.g. "That reminds me of when I..."]

### 2. [Another key topic]
[Same structure]

### 3. [Another key topic]
[Same structure]

## Likely Interview Questions

### Technical Questions
1. **Q:** [Question based on required skills]
   **Suggested answer:** [Answer drawing from user's actual experience. Use specifics, not generalities.]

2. **Q:** [Another technical question]
   **Suggested answer:** [Answer]

### Behavioral Questions
1. **Q:** [Question like "Tell me about a time when..."]
   **Suggested answer:** [STAR format: Situation, Task, Action, Result — using real examples from CV]

2. **Q:** [Another behavioral question]
   **Suggested answer:** [STAR format answer]

### Culture Fit Questions
1. **Q:** [Question about work style, collaboration, values]
   **Suggested answer:** [Answer reflecting the user's actual values from their profile]

## Questions to Ask Them

Ask at least 2-3 of these to show genuine interest and domain knowledge.

- [Thoughtful question about the team's current challenges]
- [Question showing knowledge of the company's domain or tech stack]
- [Question about growth opportunities or mentorship]
- [Question about team culture or ways of working]

## Pitfalls to Avoid

- [Specific topic or framing that could go wrong based on the user's gaps]
- [Cultural mismatch to be aware of]
- [Common trap question and how to handle it]
- [Topic to steer away from or reframe if it comes up]
```

**Guidelines:**
- The Expected Interview Process section must appear before the elevator pitch, so the user reads the process overview first
- Round-by-round breakdown should include as many rounds as were discovered from public sources. Use the "Round N" template for each
- If no company-specific data was found, provide a generic process for the role type and region, clearly labeled as a fallback, and recommend asking the recruiter
- All answers must use the user's actual experience from the CV, not hypothetical examples
- Tone guidance must reflect the user's personality profile
- Questions to ask should demonstrate knowledge of the company and role, not be generic
- Pitfalls should be specific to this user + this role combination, not generic interview advice

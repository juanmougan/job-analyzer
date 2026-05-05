# Job Listing Analyzer — Requirements

## Overview

A Claude Code skill that receives a job listing and produces a comprehensive analysis, motivation letter, preparation plan, interview script, and (when no salary is listed) salary research tailored to the user's profile.

## Inputs

### Job Listing (required)

The skill accepts a job listing URL as its argument (`<job-listing-url>`). The URL can point to any job listing page (company career sites, LinkedIn, job boards, etc.).

1. **URL fetch** — the skill fetches and parses the listing from the provided URL. It performs best-effort extraction: it proceeds with whatever information it can find (title, company, responsibilities, requirements, etc.) without requiring all fields to be present.
2. **Login wall detection** — if the fetched page contains no job-specific information (e.g., only login/sign-up prompts), the skill notifies the user that the page appears to require authentication.
3. **PDF fallback** — if fetching fails or a login wall is detected, the skill creates the folder `input/<company_name>/<position_name>/` and asks the user to save the listing as a PDF and place it there as `listing.pdf`. The skill then reads the PDF.

### CV (required)

- Read from `input/cv.md`.
- If the file is missing, the skill asks the user to create it before proceeding.

### User Profile (required on first run)

- Read from `input/user_profile.md`.
- If the file is missing, the skill interactively guides the user through creating it by asking about:
  - Personality traits and communication style (e.g. modest, assertive, etc.)
  - Motivations and career goals
  - Cultural context (country of origin, country of application, language preferences)
  - Any other relevant personal details not captured in the CV
- The skill writes the resulting file on the user's behalf.

### LinkedIn Profile (optional)

- On first run, the skill asks the user if they'd like to provide their LinkedIn profile URL as additional context.
- If provided, stored in `input/user_profile.md` alongside the other profile data.

## Outputs

All outputs are written to `output/<company_name>/<position_name>_<YYYY-MM-DD_HH-mm>/`. The first four files are always produced. The fifth (`salary.md`) is only produced when the listing has no salary range.

### 1. `analysis.md` — Position Analysis

- Summary of what the position expects from a candidate
- "What they're looking for" and "What they're NOT looking for" highlights
- User's strengths vs. the position requirements (matches)
- User's gaps vs. the position requirements (areas to develop)

### 2. `motivation_letter.md` — Motivation Letter

- Addressed to the proper receiver (or `[Recruiter Name]` placeholder if unknown)
- Highlights the user's main matches with the position
- Tone matches the user's personality profile (e.g. modest, direct, etc.)
- Ready-to-send draft with placeholders where information is missing

### 3. `preparation_plan.md` — Preparation Plan

- Topics to study or review, with concrete resource recommendations:
  - Public internet resources (blog posts, documentation)
  - O'Reilly books and courses
  - Other commonly used learning platforms
- Prioritized by relevance to the position's requirements

### 4. `interview_script.md` — Interview Script

- Talking points the user should bring up (e.g. "Project X maps to their requirement Y")
- Recommended general tone for the conversation
- Potential pitfalls the interviewer might steer toward
- Likely interview questions with suggested answers

### 5. `salary.md` — Salary Research & Negotiation (conditional)

This file is only generated when the job listing does **not** include a salary range. If the listing already contains salary information, this file is skipped entirely.

#### Trigger

After parsing the job listing, the skill checks whether a salary or compensation range was found. If not, it informs the user that no salary was listed and proceeds with the research automatically — no confirmation needed.

#### Research approach

The skill performs a **best-effort** web search using the job title, company name, and country (e.g. "Data Scientist salary Rabobank Netherlands"). It searches a few well-known sources:

- **Glassdoor** — salary estimates and reported salaries for the specific company and role
- **levels.fyi** — if applicable (mostly tech companies)
- **Payscale / Indeed Salaries** — general market data for the role in the country
- **LinkedIn Salary Insights** — if publicly accessible

The skill searches for the role within the **country** of the listing (e.g. "the Netherlands"), not a specific city. It does not adjust for cost-of-living differences between cities.

#### Contents

1. **Market salary range** — the general range found for this role and seniority level in the country, based on whatever sources returned useful data.

2. **Personalized recommendation** — a suggested negotiation range adjusted for the user's experience level, years of experience, and relevant skills (derived from `input/cv.md`). This should explain *why* the recommendation differs from the general range (e.g. "Your 8 years of experience and PhD put you in the upper quartile").

3. **Company compensation culture** — salary-specific data about the company's compensation practices:
   - How the company's reported salaries compare to market average (above/below/at market)
   - Whether the company is known for tough negotiation or generous offers
   - Any patterns in reported compensation data (e.g. "base salary below market but strong bonus structure")
   - Negotiation strategies others may have shared publicly

4. **Sources** — every piece of data must be attributed to a specific source with a URL. When data is limited or conflicting, the skill explicitly states the confidence level (e.g. "Only 3 salary reports found on Glassdoor — treat this range as approximate").

#### Constraints

- Only use publicly available data — no scraping behind login walls.
- Never fabricate salary numbers. If no data is found for the specific company, report only the general market range and state clearly that company-specific data was unavailable.
- All sources must be cited with URLs.

## Follow-up Mode

The skill supports a follow-up mode for refining previously generated application materials.

### Invocation

Instead of a job-listing URL, the user passes an output folder name (or a substring of one) as the argument:

```
/job-analyzer solution-architect-daily-banking-services_2026-05-01_20-56
/job-analyzer daily-banking
/job-analyzer solution-architect
```

### Argument disambiguation

The skill determines whether the argument is a URL (new analysis) or a folder reference (follow-up) by checking if the argument starts with `http://` or `https://`. Anything else is treated as a follow-up folder reference.

### Folder resolution

1. **Search** — the skill searches the entire `output/` hierarchy for folders whose name contains the argument as a substring (case-insensitive).
2. **Single match** — proceed directly with that folder.
3. **Multiple matches** — show all matching folders (with their full paths) and ask the user to pick the correct one.
4. **No matches** — inform the user that no matching folder was found and show the available output folders for reference.

### Context loading

The skill reads all existing output files in the resolved folder (`analysis.md`, `motivation_letter.md`, `preparation_plan.md`, `interview_script.md`, and `salary.md` if present) to understand the position and previous analysis. It does NOT re-fetch the original job listing.

### Change request

1. The skill asks the user interactively what they want to change (free-form text). Examples:
   - "The motivation letter should have a different intro, make it less like a sales pitch and more factual"
   - "I already know Kubernetes, update the preparation plan accordingly"
   - "Add more emphasis on my leadership experience across all documents"
2. The skill determines which output files are affected by the change request.
3. The skill shows the user which files it intends to modify and asks for confirmation before proceeding.
4. Changes are written in place, overwriting the existing files in the resolved folder.

### CV and profile

The skill still reads `input/cv.md` and `input/user_profile.md` during follow-up, since they provide the user context needed to make meaningful edits.

## Behavior

- The skill MUST NOT make assumptions about the user. When unsure, it asks questions via the appropriate tool.
- The skill asks as many questions as needed to produce high-quality output.
- Re-running the skill for the same position creates a new timestamped folder (no overwrites).

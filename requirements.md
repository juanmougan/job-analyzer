# Job Listing Analyzer — Requirements

## Overview

A Claude Code skill that receives a job listing and produces a comprehensive analysis, motivation letter, preparation plan, and interview script tailored to the user's profile.

## Inputs

### Job Listing (required)

The skill accepts the job listing via one of:

1. **LinkedIn URL** — the skill fetches and parses the listing from the provided URL.
2. **PDF fallback** — if fetching fails, the skill creates the folder `input/<company_name>/<position_name>/` and asks the user to print the LinkedIn listing as a PDF and place it there as `listing.pdf`. The skill then reads the PDF.

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

All outputs are written to `output/<company_name>/<position_name>_<YYYY-MM-DD_HH-mm>/`. All four files are produced in a single run.

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

## Behavior

- The skill MUST NOT make assumptions about the user. When unsure, it asks questions via the appropriate tool.
- The skill asks as many questions as needed to produce high-quality output.
- Re-running the skill for the same position creates a new timestamped folder (no overwrites).

---
name: job-analyzer
description: >
  Analyze a job listing against the user's CV and profile. Produces a position
  analysis, motivation letter, preparation plan, and interview script.
  Use when the user provides a LinkedIn job listing URL or says "analyze a job".
argument-hint: <linkedin-job-url>
allowed-tools:
  - Read
  - Write
  - Bash(ls *)
  - Bash(mkdir *)
  - Bash(date *)
  - WebFetch
  - AskUserQuestion
  - Glob
disable-model-invocation: true
---

# Job Listing Analyzer

Analyze a job listing against the user's CV and personal profile to produce tailored application materials.

## Workflow

Follow these steps in order. Do not skip any step.

### Step 1 — Validate arguments

The LinkedIn job listing URL is provided as `$ARGUMENTS`.

If `$ARGUMENTS` is empty, respond with:
> Usage: `/job-analyzer <linkedin-job-url>`
>
> Example: `/job-analyzer https://www.linkedin.com/jobs/view/12345678`

Then stop. Do not proceed.

If `$ARGUMENTS` does not contain `linkedin.com`, ask the user to confirm whether the URL is a job listing. If they confirm, proceed. If not, stop.

### Step 2 — Fetch the job listing

Use WebFetch to fetch the URL from `$ARGUMENTS`.

Extract from the listing:
- Job title
- Company name
- Location
- Required skills and qualifications
- Nice-to-have skills
- Responsibilities
- Team information
- Salary (if present)
- Full listing text

**If WebFetch fails, returns an error, or returns a login wall** (the content primarily mentions "Sign in", "Join LinkedIn", or contains very little job-specific information):

1. Ask the user for the company name and position name.
2. Sanitize both for filesystem use: lowercase, replace spaces with hyphens, remove special characters except hyphens.
3. Create the directory `input/<company_name>/<position_name>/` using `mkdir -p`.
4. Tell the user: "I couldn't fetch the listing. I've created the folder `input/<company_name>/<position_name>/`. Please print the LinkedIn page as a PDF and save it there as `listing.pdf`. Let me know when it's ready."
5. Wait for the user to confirm.
6. Read the PDF using the Read tool with `pages: "1-5"`.

### Step 3 — Read the user's CV

Read `input/cv.md`.

If the file does not exist, respond with:
> Your CV was not found at `input/cv.md`. Run `./setup.sh` to create it from the template, then edit it with your details.

Then stop. Do not proceed.

### Step 4 — Read or create the user profile

Check if `input/user_profile.md` exists by attempting to read it.

**If it exists:** read it. If any sections are empty or missing, ask the user about those specific sections only.

**If it does not exist:** load `references/user-profile-guide.md` and follow the interactive questionnaire to create the profile. Ask questions one at a time, waiting for each answer before asking the next. After all questions are answered, write the completed profile to `input/user_profile.md`.

### Step 5 — Ask clarifying questions

Review the job listing against the CV and user profile. If anything is unclear or ambiguous, ask the user. Specifically consider:

- Technologies mentioned in the listing that are not in the CV — does the user have experience with them?
- Seniority level — does the user's experience match what the role expects?
- Specific preferences for the motivation letter (points to highlight, things to avoid)
- Any other gaps or ambiguities

Do not make assumptions. Ask as many questions as needed.

### Step 6 — Create the output directory

1. Derive `<company_name>` and `<position_name>` from the listing (sanitize: lowercase, hyphens instead of spaces, remove special characters except hyphens).
2. Get a timestamp by running: `date +"%Y-%m-%d_%H-%M"`
3. Create `output/<company_name>/<position_name>_<timestamp>/` using `mkdir -p`.

### Step 7 — Generate output files

Load `references/output-templates.md` for the structure of each file.

Generate and write all four files sequentially into the output directory:

1. **`analysis.md`** — Position analysis with strengths and gaps
2. **`motivation_letter.md`** — Tailored motivation letter
3. **`preparation_plan.md`** — Study topics with specific resources
4. **`interview_script.md`** — Talking points, questions, and pitfalls

Use the user's actual CV content and profile when generating. Never use generic filler text.

### Step 8 — Report completion

After writing all four files, report:
- The output directory path
- A one-line summary of each generated file

## Rules

- Never assume anything about the user. When in doubt, ask via AskUserQuestion.
- The motivation letter and interview script tone MUST match the user's personality from their profile.
- Use `[Recruiter Name]` as placeholder if the receiver's name is not in the listing.
- Preparation resources must be specific and real: official documentation URLs, O'Reilly book titles, well-known course platforms.
- Re-running the skill for the same position creates a new timestamped folder. Never overwrite existing output.
- If the job listing is in a language other than English, ask the user what language they want the outputs in.

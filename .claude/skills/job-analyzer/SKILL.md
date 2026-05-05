---
name: job-analyzer
description: >
  Analyze a job listing against the user's CV and profile. Produces a position
  analysis, motivation letter, preparation plan, and interview script.
  Also supports follow-up mode to refine previously generated outputs.
  Use when the user provides a job listing URL, says "analyze a job",
  or wants to refine/follow up on a previous analysis.
argument-hint: <job-listing-url or output-folder-name>
allowed-tools:
  - Read
  - Write
  - Bash(ls *)
  - Bash(mkdir *)
  - Bash(date *)
  - Bash(find *)
  - WebFetch
  - AskUserQuestion
  - Glob
disable-model-invocation: true
---

# Job Listing Analyzer

Analyze a job listing against the user's CV and personal profile to produce tailored application materials. Also supports follow-up mode to refine previously generated outputs.

## Workflow

Follow these steps in order. Do not skip any step.

### Step 1 — Validate and route arguments

The argument is provided as `$ARGUMENTS`.

If `$ARGUMENTS` is empty, respond with:
> Usage:
> - New analysis: `/job-analyzer <job-listing-url>`
> - Follow-up: `/job-analyzer <output-folder-name-or-substring>`
>
> Examples:
> - `/job-analyzer https://www.linkedin.com/jobs/view/12345678`
> - `/job-analyzer solution-architect-daily-banking-services_2026-05-01_20-56`
> - `/job-analyzer daily-banking`

Then stop. Do not proceed.

**Determine the mode:**
- If `$ARGUMENTS` starts with `http://` or `https://` → **New analysis mode**. Go to Step 2.
- Otherwise → **Follow-up mode**. Go to Step F1.

---

## Follow-up Mode

### Step F1 — Resolve the output folder

Search the `output/` hierarchy for folders whose name contains `$ARGUMENTS` as a case-insensitive substring:

```
find output -type d -iname "*<ARGUMENTS>*"
```

- **No matches** — inform the user that no matching folder was found. List all available output folders with `find output -mindepth 2 -maxdepth 2 -type d` for reference. Then stop.
- **Single match** — proceed with that folder.
- **Multiple matches** — show all matching folders with their full paths and ask the user to pick the correct one using AskUserQuestion.

### Step F2 — Load existing outputs

Read all four output files from the resolved folder:
1. `analysis.md`
2. `motivation_letter.md`
3. `preparation_plan.md`
4. `interview_script.md`

These provide the full context of the position and previous analysis.

### Step F3 — Read CV and user profile

Read `input/cv.md` and `input/user_profile.md`. These are needed to make meaningful edits that stay consistent with the user's background and personality.

If either file is missing, follow the same handling as Steps 3 and 4 in new analysis mode.

### Step F4 — Ask for the change request

Ask the user what they want to change using AskUserQuestion. The question should be open-ended, inviting free-form text. For example:

> What would you like to change or improve in your application materials?

### Step F5 — Confirm affected files

Based on the user's change request, determine which of the four output files need to be modified. Present the list of files that will be changed to the user and ask for confirmation before proceeding using AskUserQuestion. For example:

> Based on your request, I would modify these files:
> - `motivation_letter.md` — rewrite the introduction with a more factual tone
> - `interview_script.md` — adjust talking points to match the updated letter
>
> Should I go ahead?

### Step F6 — Apply changes

Modify only the confirmed files. Write the updated content in place, overwriting the existing files in the resolved folder. Do not create a new folder.

After writing all changes, report:
- Which files were modified
- A one-line summary of what changed in each

Then stop. Do not continue to the new analysis steps.

---

## New Analysis Mode

### Step 2 — Fetch the job listing

Use WebFetch to fetch the URL from `$ARGUMENTS`.

Perform best-effort extraction. Extract as many of the following as available — do not fail if some fields are missing:
- Job title
- Company name
- Location
- Required skills and qualifications
- Nice-to-have skills
- Responsibilities
- Team information
- Salary (if present)
- Full listing text

**Login wall detection:** If the fetched content contains no job-specific information (e.g., it primarily mentions "Sign in", "Join now", "Create account", or contains very little substantive content), notify the user that the page appears to require authentication and proceed to the PDF fallback below.

**If WebFetch fails, returns an error, or a login wall is detected:**

1. Ask the user for the company name and position name.
2. Sanitize both for filesystem use: lowercase, replace spaces with hyphens, remove special characters except hyphens.
3. Create the directory `input/<company_name>/<position_name>/` using `mkdir -p`.
4. Tell the user: "I couldn't fetch the listing. I've created the folder `input/<company_name>/<position_name>/`. Please save the listing page as a PDF and place it there as `listing.pdf`. Let me know when it's ready."
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

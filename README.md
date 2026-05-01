# Job Listing Analyzer

A [Claude Code](https://docs.anthropic.com/en/docs/claude-code) skill that analyzes job listings against your CV and personal profile, producing tailored application materials.

Given a LinkedIn job listing URL, it generates:

- **Position Analysis** — strengths, gaps, and overall fit assessment
- **Motivation Letter** — personalized draft matching your communication style
- **Preparation Plan** — prioritized study topics with specific resources (docs, O'Reilly books, courses)
- **Interview Script** — talking points, likely questions with answers, and pitfalls to avoid

## Prerequisites

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) CLI installed

## Quick Start

```bash
git clone <repo-url>
cd job-analyzer
./setup.sh
```

Edit `input/cv.md` with your CV, then:

```bash
claude
```

Inside Claude Code:

```
/job-analyzer https://www.linkedin.com/jobs/view/12345678
```

On your first run, the skill will interactively guide you through creating a personal profile (`input/user_profile.md`) with questions about your communication style, career goals, and cultural context.

## Usage

```
/job-analyzer <linkedin-job-url>
```

### What happens

1. The skill fetches and parses the job listing from the URL
2. If fetching fails (e.g. LinkedIn login wall), it asks you to save the listing as a PDF instead
3. It reads your CV and personal profile
4. It asks clarifying questions if anything is ambiguous
5. It generates all four output files in `output/<company>/<position>_<timestamp>/`

### PDF Fallback

If the LinkedIn URL can't be fetched, the skill will:
1. Ask you for the company and position names
2. Create a folder at `input/<company>/<position>/`
3. Ask you to print the LinkedIn page as PDF and save it as `listing.pdf` in that folder

## Directory Structure

```
.
├── input/
│   ├── cv.md                  # Your CV (created from template by setup.sh)
│   ├── cv.template.md         # Template for new users
│   └── user_profile.md        # Your profile (created interactively on first run)
├── output/
│   └── <company>/
│       └── <position>_<timestamp>/
│           ├── analysis.md
│           ├── motivation_letter.md
│           ├── preparation_plan.md
│           └── interview_script.md
├── .claude/
│   └── skills/
│       └── job-analyzer/      # The skill definition
├── setup.sh
├── requirements.md
└── README.md
```

## Privacy

The `input/` and `output/` directories are gitignored. Your CV, personal profile, and all generated materials stay local and are never committed to version control. Do not remove these entries from `.gitignore`.

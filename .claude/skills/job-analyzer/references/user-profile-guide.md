# User Profile Creation Guide

When `input/user_profile.md` does not exist, guide the user through creating it by asking the following questions one at a time. Wait for each answer before proceeding to the next question.

## Question Flow

### 1. Communication Style

Ask:
> How would you describe your communication style? For example: direct and assertive, modest and understated, diplomatic, enthusiastic, analytical. Think about how you present yourself in professional settings.

### 2. Personality Traits

Ask:
> What personality traits define you professionally? For example: detail-oriented, big-picture thinker, collaborative, independent, creative problem-solver.

### 3. Career Motivations

Ask:
> What motivates you in your career? What are you looking for in your next role? What kind of work energizes you?

### 4. Career Goals

Ask:
> Where do you see yourself in 3-5 years? Are you aiming for a specific type of role, industry, or achievement?

### 5. Cultural Context

Ask:
> What is your country of origin, and where are you currently based? Are there any cultural nuances you'd like reflected in your applications? For example: Dutch directness, Latin warmth, British understatement, etc.

### 6. Language Preferences

Ask:
> Which language should the output documents be written in? Do you have any preferences for formality level?

### 7. Additional Context

Ask:
> Is there anything else about you that isn't captured in your CV but would be relevant for job applications? For example: volunteer work, personal projects, life circumstances, relocation flexibility, visa status.

### 8. LinkedIn Profile (Optional)

Ask:
> Would you like to provide your LinkedIn profile URL as additional context? This is optional but can help enrich the analysis.

## Output Format

After collecting all answers, write the file to `input/user_profile.md` using this structure:

```markdown
# User Profile

## Communication Style
[Answer from question 1]

## Personality Traits
[Answer from question 2]

## Career Motivations
[Answer from question 3]

## Career Goals
[Answer from question 4]

## Cultural Context
- **Country of origin:** [extracted from answer]
- **Current location:** [extracted from answer]
- **Cultural preferences:** [extracted from answer]

## Language Preferences
[Answer from question 6]

## Additional Context
[Answer from question 7]

## LinkedIn Profile
[URL from question 8, or "Not provided"]
```

After writing the file, confirm to the user: "Your profile has been saved to `input/user_profile.md`. You can edit it anytime to update your preferences."

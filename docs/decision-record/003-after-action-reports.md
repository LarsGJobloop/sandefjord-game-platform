---
id: 003
status: "proposed"
supersedes: null
superseded_by: null
---

# Decision Record 003: After Action Reports

## Context

We need a simple way to reflect on our work and capture lessons learned during the game platform project.

## Decision

Use lightweight after action reports for major milestones and incidents:

**Format**: Markdown files in `/docs/after-action-reports/YYYY-MM-DD-brief-description.md`

**Template**:

```markdown
# After Action Report: [Brief Description]
**Date**: YYYY-MM-DD

## What Happened
Brief description of the event.

## What Went Well
- Successes and positive outcomes

## What Could Be Improved  
- Challenges and areas for improvement

## Lessons Learned
- Key takeaways for future work
```

**When to write**: Major technical and social milestones and incidents.

## Consequences

### Positive

- Captures lessons learned for future reference
- Develops professional reflection habits
- Helps identify improvement opportunities

### Negative

- Additional documentation overhead
- May be inconsistently adopted

### Countermeasures

- Keep template minimal and focused
- Only require for significant events
- Use in regular project reviews

---
id: 000
status: "accepted"
supersedes: null
superseded_by: null
---

# Decision Record 000: Decision Record Format

## Status

Accepted

## Context

Need a lightweight way to document architectural and design decisions for the game platform implementation.

## Decision

Use YAML frontmatter + markdown format for decision records:

```yaml
---
id: 000
status: "proposed" | "under_review" | "accepted" | "rejected" | "superseded"
supersedes: null
superseded_by: null
---
```

**Content sections**: Context, Decision, Consequences, Countermeasures (optional), Future Considerations (optional)

*Note: This is the minimal record - decisions may require more extensive evaluation*

**Process**: Create as branches → PR review → status transitions

## Consequences

### Positive

- Clear record of decision reasoning
- Helps new team members understand architectural choices
- Lightweight format with minimal overhead

### Negative

- Requires discipline to maintain
- Could become outdated without active maintenance

### Countermeasures

- **Scope limitation**: Only record decisions that would be expensive to reverse
- **Minimal format**: Keep records short and focused
- **Regular review**: Supersede outdated decisions rather than updating them

## Implementation

- Store in `/docs/decision-record/` with zero-padded filenames (`000-`, `001-`, etc.)
- Use `/docs/decision-record/template.md` as starting point
- **Scope**: Only record decisions with significant cost of direction change (architectural, technology, process, design decisions that constrain future options)

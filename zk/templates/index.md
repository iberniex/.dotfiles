---
id: index-{{topic}}
title: "{{Title Case Topic}} Index"
type: index
tags:
  - index
  - {{topic}}
aliases:
  - {{topic}} topics
  - {{topic}} reference
  - {{topic}} knowledge hub
created: {{date}}
---

# {{Title Case Topic}} Index

A central hub for all notes, definitions, and resources related to **{{Title Case Topic}}**.


## Definitions & Terms

```dataviewjs
table title as "Term", file.link as "Note", tags
from "100-literature"
where contains(tags, "{{topic}}") and contains(tags, "term")
sort file.name asac
```

## Guides $ concepts


```dataviewjs
table title as "Guide", file.link as "Note", tags
from "100-literature"
where contains(tags, "{{topic}}") and contains(tags, "guide")
sort file.name asc
```

## Code Snippets & Patterns

```dataviewjs
table file.link as "Snippet", tags
from "snippets"
where contains(tags, "{{topic}}")
sort file.name asc
```

## Open Questions

```dataviewjs
table question as "Question", file.link as "Note"
from "literature"
where contains(tags, "{{topic}}") and question
```

---
# Back Matter
## Related Indexes

-

## Resources

-


---

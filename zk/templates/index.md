---
id: {{id}}
title: "{{title}} Index"
type: index
tags:
  - index
  - {{title}}
created: {{format-date now "medium"}}
---

# {{title}} Index

A central hub for all notes, definitions, and resources related to **{{Title Case Topic}}**.


**Definitions & Terms**

```dataview
table title as "Term", file.link as "Note", tags
from "100-Literature"
where contains(tags, "{{title}}") and contains(tags, "term")
sort file.name asac
```

**Guides $ concepts***


```dataview
table title as "Guide", file.link as "Note", tags
from "100-Literature"
where contains(tags, "{{title}}") and contains(tags, "guide")
sort file.name asc
```

**Code Snippets & Patterns**

```dataview
table file.link as "Snippet", tags
from "snippets"
where contains(tags, "{{title}}")
sort file.name asc
```

**Open Questions**

```dataview
table question as "Question", file.link as "Note"
from "Literature"
where contains(tags, "{{title}}") and question
```

---
# Back Matter

**Related Indexes**

-

**Resources**

-


---

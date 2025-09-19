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

**Related Journals**

```dataview
table title as "Journal", file.link as "Note", tags
from "002-Journal"
where contains(tags, "{{title}}") and contains(tags, "journal")
sort file.name asac
```

**Fleeting Notes**

```dataview
table title as "Fleeting", file.link as "Note", tags
from "001-Fleeting"
where contains(tags, "{{title}}") and contains(tags, "fleeting")
sort file.name asac
```

**Permanent Notes**

```dataview
table title as "Permanent", file.link as "Note", tags
from "200-Permanent"
where contains(tags, "{{title}}") and contains(tags, "permanent")
sort file.name asac
```


**Project Notes**

```dataview
table title as "Projects", file.link as "Note", tags
from "300-Projects"
where contains(tags, "{{title}}") and contains(tags, "projects")
sort file.name asac
```

**Definitions & Terms**

```dataview
table title as "Term", file.link as "Note", tags
from "100-Literature"
where contains(tags, "{{title}}") and contains(tags, "question")
sort file.name asac
```

**Guides $ concepts**


```dataview
table title as "Guide", file.link as "Note", tags
from "100-Literature"
where contains(tags, "{{title}}") and contains(tags, "guide")
sort file.name asac
```

**Code Snippets & Patterns**

```dataview
table file.link as "Snippet", as file.link as "Patterns" tags
from "snippets"
where contains(tags, "{{title}}")
sort file.name asac
```

**Open Questions**

```dataview
table question as "Prompt", file.link as "Note"
from "Literature"
where contains(tags, "{{title}}") and contains(tags, "prompt")
sort file.name asac
```

---
# Back Matter

**Related Indexes**

-

**Resources**

-


---

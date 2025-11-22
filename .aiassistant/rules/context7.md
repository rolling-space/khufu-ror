---
apply: always
---

Always use context7 when I need code generation, setup or configuration steps, or
library/API documentation. This means you should automatically use the Context7 MCP
tools to resolve library id and get library docs without me having to explicitly ask.

## Context7 Integration (Documentation & Research)

**Purpose**: Official library documentation, code examples, best practices, localization standards, code generation, setup or configuration steps, library/API documentation

**Activation Patterns**:
- Automatic: External library imports detected, framework-specific questions, scribe persona active
- Smart: Commands detect need for official documentation patterns

**Workflow Process**:
1. Library Detection: Scan imports, dependencies, package.json for library references
2. ID Resolution: Use `resolve-library-id` to find Context7-compatible library ID
3. Documentation Retrieval: Call `get-library-docs` with specific topic focus
4. Pattern Extraction: Extract relevant code patterns and implementation examples
5. Implementation: Apply patterns with proper attribution and version compatibility
6. Validation: Verify implementation against official documentation
7. Caching: Store successful patterns for session reuse

**Error Recovery**:
- Library not found → WebSearch for alternatives → Manual implementation
- Documentation timeout → Use cached knowledge → Note limitations
- Invalid library ID → Retry with broader search terms → Fallback to WebSearch
- Version mismatch → Find compatible version → Suggest upgrade path
- Server unavailable → Activate backup Context7 instances → Graceful degradation

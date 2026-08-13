# MASTER PROMPT 1
# PROJECT REQUIREMENTS → PRODUCTION-GRADE DOCUMENTATION GENERATOR

## ROLE

Act as a Senior Principal Software Architect, Product Architect, Technical Lead, QA Architect, Security Architect, DevOps Architect, Documentation Architect, and AI-Agent Project Planner.

Your task is to analyze the complete project information provided by the user and create a **full production-grade project documentation system** that can later be used by any coding agent or LLM to build the project.

This prompt is ONLY for:

```text
REQUIREMENT ANALYSIS
+
ARCHITECTURE DESIGN
+
DOCUMENTATION GENERATION
+
DOCUMENTATION CONSISTENCY
+
PROJECT ROADMAP
```

Do NOT start implementing the project code.

Do NOT generate the step-by-step coding Master Loop yet.

The output of this prompt will become the project's permanent documentation foundation.

---

# 1. USER PROJECT INPUT

The user will provide the project information below.

```text
PROJECT NAME:
<name>

PROJECT TYPE:
<web app / API / SaaS / bot / AI system / trading system / automation / desktop / mobile / other>

PROJECT SUMMARY:
<complete project summary>

PROBLEM:
<problem to solve>

PROJECT GOAL:
<goal>

TARGET USERS:
<users>

CORE FEATURES:
<features>

ADVANCED FEATURES:
<features>

USER WORKFLOW:
<workflow>

BUSINESS LOGIC:
<logic>

TECHNICAL REQUIREMENTS:
<requirements>

PREFERRED LANGUAGE:
<language>

PREFERRED FRAMEWORK:
<framework>

DATABASE:
<database>

EXTERNAL APIs:
<APIs>

THIRD-PARTY SERVICES:
<services>

UI/UX REQUIREMENTS:
<requirements>

PERFORMANCE REQUIREMENTS:
<requirements>

SECURITY REQUIREMENTS:
<requirements>

SCALABILITY REQUIREMENTS:
<requirements>

DEPLOYMENT ENVIRONMENT:
<environment>

INFRASTRUCTURE:
<infrastructure>

TESTING REQUIREMENTS:
<requirements>

KNOWN CONSTRAINTS:
<constraints>

KNOWN RISKS:
<risks>

EXISTING CODE:
<existing repository information>

EXISTING DOCUMENTATION:
<existing docs>

SPECIAL REQUIREMENTS:
<special requirements>

OTHER INFORMATION:
<any other information>
```

The user may provide incomplete information.

Do not assume that missing information is known.

---

# 2. REQUIREMENT ANALYSIS

First analyze the supplied information.

Separate:

```text
EXPLICIT REQUIREMENTS
INFERRED REQUIREMENTS
ASSUMPTIONS
MISSING REQUIREMENTS
AMBIGUITIES
CONFLICTS
CONSTRAINTS
DEPENDENCIES
RISKS
NON-GOALS
```

Use requirement IDs where appropriate:

```text
BR-###
FR-###
NFR-###
SEC-###
PERF-###
DATA-###
API-###
UX-###
OPS-###
```

Each important requirement should be:

```text
specific
traceable
testable where possible
architecturally actionable
```

Do not silently invent major business logic.

When safe, use reasonable assumptions and explicitly document them.

---

# 3. PRODUCTION-GRADE DOCUMENTATION PACKAGE

Create ALL of the following files:

```text
1. Rules.md
2. Architecture.md
3. MASTER_LOOP.md
4. Memory.md
5. Tasks.md
6. Testing.md
7. Acceptance.md
8. PRB.md
9. Design.md
10. Phases.md
11. Contracts.md
12. Skills.md
13. Decisions.md
14. Changelog.md
```

The files must be FULL documents.

Do not generate empty shells.

Do not use generic filler that ignores the user's project.

Every file must be specifically adapted to the provided project.

---

# 4. PRB.md

Create:

```text
Project Overview
Problem Statement
Background
Vision
Mission
Goals
Objectives
Target Users
Use Cases
Functional Scope
Non-Goals
Business Requirements
Functional Requirements
Non-Functional Requirements
Constraints
Assumptions
Dependencies
Risks
Success Criteria
Requirement IDs
Requirement Traceability
```

Clearly separate:

```text
MUST HAVE
SHOULD HAVE
NICE TO HAVE
OUT OF SCOPE
```

---

# 5. Architecture.md

Design the complete production architecture.

Include:

```text
Architecture Overview
System Context
High-Level Architecture
Component Architecture
Module Boundaries
Service Boundaries
Data Flow
Control Flow
Dependency Flow
API Layer
Business/Domain Layer
Application/Service Layer
Persistence Layer
Infrastructure Layer
External Integrations
Security Boundaries
Failure Boundaries
Caching Strategy
Concurrency Model
Scalability Model
Observability
Deployment Architecture
Environment Separation
Configuration Strategy
Backup/Recovery where relevant
Architecture Invariants
```

Where useful, provide ASCII diagrams.

Architecture must reflect the actual requirements.

Do not add components only because they sound "enterprise".

---

# 6. Design.md

Define the detailed implementation design.

Include where applicable:

```text
Module Responsibilities
Service Responsibilities
Class/Object Responsibilities
Interfaces
Algorithms
Data Processing
State Management
Persistence Design
Transactions
Caching
Concurrency
Retries
Timeouts
Idempotency
Error Handling
Logging
Configuration
Feature Flags
Validation
Performance Design
Security Design
Migration Strategy
Backward Compatibility
```

Keep implementation practical.

Avoid unnecessary abstraction.

---

# 7. Rules.md

Create binding engineering rules.

Use explicit language:

```text
MUST
MUST NOT
SHOULD
SHOULD NOT
```

Include:

```text
Architecture Rules
Coding Rules
Security Rules
Testing Rules
Git Rules
Dependency Rules
Database Rules
API Rules
Logging Rules
Error Handling Rules
Scope Rules
Documentation Rules
Agent Rules
Completion Rules
Recovery Rules
```

Rules must protect the project from uncontrolled agent behavior.

---

# 8. Phases.md

Create the entire project roadmap.

Divide the project into logical phases.

Each phase must contain:

```text
Phase ID
Name
Goal
Objective
Scope
Dependencies
Major Deliverables
Tasks
Testing
Acceptance Criteria
Exit Criteria
Risks
Checkpoint
```

Phase ordering must respect technical dependencies.

---

# 9. Tasks.md

Break phases into actionable coding tasks.

Each task must include:

```text
TASK ID
Phase
Title
Objective
Description
Dependencies
Priority
Affected Area
Expected Deliverables
Acceptance Criteria
Testing Requirements
Risk
Status
Checkpoint
```

Initial state should normally be:

```text
TODO
```

Do not claim implementation is completed unless the user supplied verified existing state.

Task granularity must be suitable for an AI coding agent.

---

# 10. MASTER_LOOP.md

Create the project's permanent agent workflow document.

This document must define:

```text
Startup
Documentation Reading
Repository Inspection
State Reconstruction
Task Selection
Scope Control
Implementation
Testing
Audit
Acceptance
Documentation Update
Memory Update
Git Checkpoint
Phase Gate
Failure Handling
Recovery
Resume
Final Reporting
Stop Conditions
```

This file is the project's operating protocol.

---

# 11. Memory.md

Create an initial project state model.

Include:

```text
Current Phase
Current Task
Task Status
Last Verified Checkpoint
Last Verified Commit
Latest Test Result
Acceptance Status
Known Issues
Known Blockers
Current Objective
Current Resume Point
Next Safe Action
```

Since implementation has not yet begun, use explicit states such as:

```text
NOT_STARTED
NONE
TBD
```

Never fabricate progress.

---

# 12. Testing.md

Create a complete quality strategy.

Include applicable sections:

```text
Testing Philosophy
Unit Tests
Integration Tests
API Tests
Database Tests
E2E Tests
UI Tests
Security Tests
Performance Tests
Load Tests
Regression Tests
Static Analysis
Type Checking
Linting
Build Validation
Deployment Validation
Test Data
Test Environment
Required Commands
Quality Gates
Failure Handling
```

Use project-specific commands when known.

---

# 13. Acceptance.md

Define measurable acceptance criteria.

Include:

```text
Definition of Done
Requirement Acceptance
Feature Acceptance
API Acceptance
UI Acceptance
Security Acceptance
Performance Acceptance
Reliability Acceptance
Deployment Acceptance
Phase Acceptance
Production Readiness Acceptance
```

Every critical feature must have objective acceptance criteria.

---

# 14. Contracts.md

Define project contracts where applicable:

```text
API Contracts
Request Schemas
Response Schemas
Error Schemas
Database Contracts
Event Contracts
Module Interfaces
External Service Contracts
Configuration Contracts
Versioning
Compatibility Rules
```

Never fabricate unknown exact schemas.

Use:

```text
TBD
PROPOSED
```

where necessary.

---

# 15. Skills.md

Define required agent capabilities.

Include:

```text
Programming Skills
Framework Skills
Database Skills
Testing Skills
Git Skills
Docker Skills
CI/CD Skills
Cloud Skills
Security Skills
AI/LLM Skills
Browser Automation Skills
Domain-Specific Skills
```

For every skill explain:

```text
Purpose
When Needed
Expected Standard
Validation
Restrictions
```

Never include secrets.

---

# 16. Decisions.md

Create decision records for major architectural choices.

Use:

```text
Decision ID
Status
Title
Context
Decision
Reason
Alternatives
Rejected Alternatives
Tradeoffs
Consequences
```

Use `PROPOSED` for decisions that still require implementation validation.

Do not pretend the user made a decision that they did not make.

---

# 17. Changelog.md

Initialize the project documentation history.

Create an initial entry such as:

```text
Documentation baseline created.
```

Separate:

```text
Added
Changed
Fixed
Removed
Security
Breaking Changes
Documentation
```

Do not fabricate implementation history.

---

# 18. Skills / Tool Selection

Based on project requirements, identify appropriate:

```text
languages
frameworks
databases
testing tools
CI/CD tools
container tools
security tools
observability tools
browser tools
AI/LLM tools
```

Do not unnecessarily prescribe technologies when the user has not requested them.

---

# 19. DOCUMENT CONSISTENCY AUDIT

After creating all 14 files, perform a cross-document audit.

Verify:

```text
PRB ↔ Architecture
PRB ↔ Design
PRB ↔ Phases
Architecture ↔ Design
Architecture ↔ Contracts
Architecture ↔ Rules
Phases ↔ Tasks
Tasks ↔ Acceptance
Testing ↔ Acceptance
Tasks ↔ Memory
Decisions ↔ Architecture
Skills ↔ Technology
MASTER_LOOP ↔ Rules
```

Detect and resolve:

```text
contradictions
missing requirements
orphan tasks
orphan acceptance criteria
undefined dependencies
duplicate responsibilities
wrong terminology
architecture gaps
missing testing coverage
missing security coverage
```

---

# 20. REQUIREMENT TRACEABILITY

Create a traceability model:

```text
Requirement
↓
Architecture
↓
Design
↓
Phase
↓
Task
↓
Test
↓
Acceptance Criterion
```

Critical requirements must be traceable through the entire lifecycle.

---

# 21. FINAL DOCUMENTATION QUALITY GATE

Before final output, verify:

```text
All 14 files exist
All files contain project-specific content
Requirements are internally consistent
Architecture matches requirements
Tasks match phases
Tests cover requirements
Acceptance covers requirements
Contracts match architecture
Rules constrain agent behavior
MASTER_LOOP supports implementation
Memory supports state tracking
Decisions explain major choices
Changelog establishes baseline
```

If something is missing, fix it before delivering.

---

# 22. REQUIRED OUTPUT ORDER

Return the result in this order:

## SECTION A — PROJECT ANALYSIS

```text
Project Understanding
Requirements
Assumptions
Risks
Ambiguities
Missing Requirements
Non-Goals
```

## SECTION B — DOCUMENTATION PACKAGE

Provide the complete contents of:

```text
Rules.md
Architecture.md
MASTER_LOOP.md
Memory.md
Tasks.md
Testing.md
Acceptance.md
PRB.md
Design.md
Phases.md
Contracts.md
Skills.md
Decisions.md
Changelog.md
```

## SECTION C — DOCUMENTATION AUDIT

Provide:

```text
Consistency Result
Requirement Coverage
Traceability Result
Missing Coverage
Known Assumptions
Known Risks
```

## SECTION D — INITIAL PROJECT ROADMAP

Provide:

```text
Phase 0
Phase 1
Phase 2
...
```

with task IDs.

## IMPORTANT

Do NOT create the coding-agent next-step Master Loop Prompt in this response.

That belongs to a separate execution prompt.

# END OF MASTER PROMPT 1
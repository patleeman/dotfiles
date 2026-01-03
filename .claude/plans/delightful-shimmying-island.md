# Plan: Magical Automation Setup

## Goal
Make automation setup "magical" for non-technical users. Users express intent ("remind me every morning to check email") and the agent handles everything - no navigation to separate pages, no understanding of triggers vs skills vs subscriptions.

## Core Changes

### 1. Add `automation_create` Tool (Backend)

**New file:** `packages/go-backend/internal/tools/automation.go`

A unified tool that agents use inline during conversation:

```go
type AutomationCreateTool struct {
    // Parameters:
    // - type: "schedule" | "event" | "skill"
    // - name: Human-readable name
    // - description: What this does
    // - schedule: Natural language ("every morning at 9am") or cron
    // - event_type: For events - "clipboard_change", "file_change", etc.
    // - prompt_template: What agent should do when triggered
}
```

**Behavior:**
- For schedules: Delegates to existing `ScheduleAgentTool` logic
- For events: Writes `trigger.yaml` to `config/triggers/{name}/` and auto-subscribes
- For skills: Writes `skill.md` to `config/skills/{name}/`

**Also add:**
- `automation_list` - Shows all automations for the agent
- `automation_delete` - Removes an automation

### 2. Natural Language Schedule Parser

**New file:** `packages/go-backend/internal/utils/schedule_parser.go`

Converts natural language to cron:
- "every morning" → "0 9 * * *"
- "every weekday at 9am" → "0 9 * * 1-5"
- "every hour" → "0 * * * *"
- "daily at 5pm" → "0 17 * * *"

### 3. Add "Automations" Tab to Agent Workspace (Frontend)

**New file:** `packages/desktop/ui/src/components/Agent/AutomationsTab.tsx`

Shows unified view of agent's automations:
- Scheduled tasks
- Trigger subscriptions
- Available skills
- Enable/disable toggles
- Edit/delete actions

**Modify:** `packages/desktop/ui/src/components/Agent/AgentWorkspace.tsx`
- Add "Automations" tab option

### 4. De-emphasize Triggers/Skills Pages

**Modify:** `packages/desktop/ui/src/App.tsx`
- Move /triggers and /skills to "Advanced" section
- Or hide from main nav, accessible via Settings

### 5. Register New Tools

**Modify:** `packages/go-backend/cmd/server/handlers.go`
- Register `automation_create`, `automation_list`, `automation_delete` tools

## Files to Modify

| File | Change |
|------|--------|
| `packages/go-backend/internal/tools/automation.go` | NEW - Core automation tools |
| `packages/go-backend/internal/utils/schedule_parser.go` | NEW - NL schedule parser |
| `packages/go-backend/cmd/server/handlers.go` | Register new tools |
| `packages/desktop/ui/src/components/Agent/AutomationsTab.tsx` | NEW - Unified view |
| `packages/desktop/ui/src/components/Agent/AgentWorkspace.tsx` | Add Automations tab |
| `packages/desktop/ui/src/App.tsx` | De-emphasize triggers/skills pages |

## Example User Experience

**Before (technical):**
1. User goes to /triggers
2. Clicks "New Trigger" → creates Trigger Architect
3. Works with architect to create trigger files
4. Goes back to their agent
5. Agent subscribes to the trigger

**After (magical):**
1. User tells agent: "Remind me every morning to check my calendar"
2. Agent: "I've set up a daily reminder at 9am. I'll prompt you to check your calendar each morning."
3. Done.

## Implementation Order

1. `automation_create` tool with schedule support only (quick win)
2. `automation_list` tool
3. Natural language schedule parser
4. Automations tab in UI
5. De-emphasize triggers/skills pages
6. Event trigger support in `automation_create`

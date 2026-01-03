# E2E Testing Plan for Familiar Desktop UI

## Overview
Add comprehensive end-to-end tests using Playwright against the real Go backend, covering all main user workflows.

## Infrastructure Setup

### 1. Playwright Configuration
Create `playwright.config.ts` in `packages/desktop/ui/`:
- Base URL: `http://localhost:5173` (Vite dev server)
- Test directory: `e2e/`
- Browsers: Chromium (primary), optionally Firefox/WebKit
- Timeout: 30s per test
- Retries: 2 in CI, 0 locally
- Screenshots/videos on failure

### 2. Test Scripts (package.json)
```
"test:e2e": "playwright test"
"test:e2e:ui": "playwright test --ui"
"test:e2e:headed": "playwright test --headed"
```

### 3. Global Setup/Teardown
- `e2e/global-setup.ts`: Start Go backend before tests
- `e2e/global-teardown.ts`: Stop backend after tests
- Use test database/config to avoid polluting real data

## Test Structure

```
packages/desktop/ui/
├── e2e/
│   ├── global-setup.ts      # Start backend
│   ├── global-teardown.ts   # Stop backend
│   ├── fixtures/
│   │   └── test-fixtures.ts # Page objects, helpers
│   ├── agent.spec.ts        # Agent CRUD tests
│   ├── chat.spec.ts         # Chat interaction tests
│   ├── settings.spec.ts     # Settings configuration tests
│   ├── skills.spec.ts       # Skills management tests
│   ├── triggers.spec.ts     # Triggers management tests
│   ├── usage.spec.ts        # Usage view tests
│   └── navigation.spec.ts   # Navigation & keyboard shortcuts
└── playwright.config.ts
```

## Test Coverage by Workflow

### 1. Agent Management (`agent.spec.ts`)
- Create new agent with default model
- Create agent with specific model selection
- Rename agent via context menu
- Delete single agent with confirmation
- Bulk select and delete multiple agents
- Filter agents by status (running/stopped)
- Group agents by model provider
- Navigate between agents

### 2. Chat Interaction (`chat.spec.ts`)
- Send a text message
- View agent response streaming
- Approve tool call request
- Reject tool call request
- "Always allow" pattern approval
- Handle secret request modal
- View inline scope proposal
- Expand/collapse scope proposal
- Stop running agent mid-execution

### 3. Settings Configuration (`settings.spec.ts`)
- Add API key for cloud provider
- Remove API key
- Enable/disable provider
- Add custom provider endpoint
- Select model for capability
- Toggle auto-compaction
- Enable/disable sub-agents (Claude Code, Codex)
- Toggle unrestricted execution mode
- Add vault secret
- Remove vault secret
- Change keyboard shortcuts
- Switch theme

### 4. Skills Management (`skills.spec.ts`)
- View skills list
- Create new skill
- Edit skill description
- Delete skill with confirmation
- Context menu actions
- Navigate to skill directory

### 5. Triggers Management (`triggers.spec.ts`)
- View triggers list
- Create new trigger
- Edit trigger configuration
- Delete trigger with confirmation
- Subscribe agent to trigger
- Unsubscribe agent from trigger

### 6. Usage Analytics (`usage.spec.ts`)
- View usage summary
- Check provider breakdown table
- Check model utilization table
- Check agent usage table
- Check tool output volume
- Verify cost calculations display

### 7. Navigation & UI (`navigation.spec.ts`)
- Cmd+K opens search/command bar
- Escape closes modals
- Sidebar collapse/expand
- Explorer panel resize
- Tab navigation in settings
- Route navigation via sidebar
- Keyboard shortcuts for all actions

## Page Objects / Fixtures

### `test-fixtures.ts`
```typescript
// Reusable page objects
class AgentPage {
  async createAgent(name: string, model?: string)
  async deleteAgent(name: string)
  async selectAgent(name: string)
  async sendMessage(text: string)
  async waitForResponse()
}

class SettingsPage {
  async addApiKey(provider: string, key: string)
  async removeApiKey(provider: string)
  async selectModel(capability: string, model: string)
}

// etc.
```

## Files to Create/Modify

| File | Action |
|------|--------|
| `packages/desktop/ui/playwright.config.ts` | Create |
| `packages/desktop/ui/e2e/global-setup.ts` | Create |
| `packages/desktop/ui/e2e/global-teardown.ts` | Create |
| `packages/desktop/ui/e2e/fixtures/test-fixtures.ts` | Create |
| `packages/desktop/ui/e2e/agent.spec.ts` | Create |
| `packages/desktop/ui/e2e/chat.spec.ts` | Create |
| `packages/desktop/ui/e2e/settings.spec.ts` | Create |
| `packages/desktop/ui/e2e/skills.spec.ts` | Create |
| `packages/desktop/ui/e2e/triggers.spec.ts` | Create |
| `packages/desktop/ui/e2e/usage.spec.ts` | Create |
| `packages/desktop/ui/e2e/navigation.spec.ts` | Create |
| `packages/desktop/ui/package.json` | Add test scripts |
| `packages/desktop/ui/.gitignore` | Add playwright artifacts |

## Implementation Order

1. **Setup**: Playwright config, global setup/teardown, package.json scripts
2. **Fixtures**: Page objects and test helpers
3. **Navigation tests**: Basic routing and UI interactions (simplest)
4. **Agent tests**: CRUD operations
5. **Settings tests**: Configuration workflows
6. **Chat tests**: Message interaction and tool approvals
7. **Skills/Triggers tests**: Management workflows
8. **Usage tests**: Analytics display verification

## Notes

- Tests will require the Go backend to be built and available
- Consider using a test-specific config/database for isolation
- Add `test-results/` and `playwright-report/` to `.gitignore`
- May need to handle WebSocket connections in tests

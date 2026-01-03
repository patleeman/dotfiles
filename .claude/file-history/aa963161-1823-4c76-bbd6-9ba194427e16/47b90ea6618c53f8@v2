# Familiar Desktop UI Refactoring Plan

## Overview
Refactor the entire desktop application from IRC-style aesthetic to a modern dense dashboard design based on `docs/familiar-dense.jsx` and `docs/familiar-settings.jsx`.

**Scope:**
- Full redesign of all views (including chat/workspace)
- Remove theme selector and other themes (light, cobalt2, nerv)
- Keep monospace only for code/data display
- Complete overhaul in one pass

---

## Phase 1: Foundation & Shared Components

### 1.1 Update Theme System
**File:** `packages/desktop/ui/src/index.css`
- Update `:root` CSS variables to new palette:
  - `--background: 15 17 23` (#0f1117)
  - `--surface: 10 11 15` (#0a0b0f)
  - `--border: 30 41 59` (#1e293b)
  - `--accent: 99 102 241` (#6366f1 - indigo)
  - `--text-primary: 226 232 240` (#e2e8f0)
  - `--text-secondary: 148 163 184` (#94a3b8)
  - `--text-tertiary: 100 116 139` (#64748b)
- Remove `[data-theme='light']`, `[data-theme='cobalt2']`, `[data-theme='nerv']` blocks
- Change base font from monospace to system font
- Add scrollbar styling for new colors

### 1.2 Create Shared UI Components
**New directory:** `packages/desktop/ui/src/components/ui/`

| Component | Purpose |
|-----------|---------|
| `Sparkline.tsx` | Mini SVG line charts for metrics |
| `LoadBar.tsx` | Progress bar with color thresholds (green/yellow/red) |
| `Status.tsx` | Colored circle + 3-letter code (RUN, WAI, PAU, IDL, ERR) |
| `Tag.tsx` | Pill badges with colored backgrounds |
| `Metric.tsx` | Value + unit + optional trend arrow |
| `Toggle.tsx` | Switch component |
| `Input.tsx` | Styled text input |
| `Select.tsx` | Styled select dropdown |
| `Button.tsx` | Primary/default/danger variants |
| `SidebarSection.tsx` | Collapsible sections with chevron |
| `SidebarItem.tsx` | Navigation item with icon, label, count |
| `SettingRow.tsx` | Label + description + control layout |
| `ProviderCard.tsx` | Provider configuration cards |
| `Section.tsx` | Collapsible content section |
| `index.ts` | Barrel export |

---

## Phase 2: Navigation & Layout

### 2.1 Top Navigation Bar
**File:** `packages/desktop/ui/src/components/Unibar.tsx`
- Height: 36px (from 24px)
- Add branding: Zap icon + "Familiar" text + DEV tag
- Nav buttons: Title case ("Fleet", "Skills", etc.)
- Remove: uppercase, tracking-widest, slash prefixes
- Add: Search input with icon and `Cmd+K` hint
- Active state: Indigo background

### 2.2 Status Bar
**File:** `packages/desktop/ui/src/components/Agent/StatusBar.tsx`
- Height: 24px
- Replace bracket notation with `Status` component
- Use `Tag` component for model/provider
- Simplify trigger display
- Add connection indicator with colored circle

### 2.3 App Layout
**File:** `packages/desktop/ui/src/App.tsx`
- Remove `font-mono` from root
- Remove theme loading/saving logic
- Update margin for new header height
- Remove `applyTheme` function

---

## Phase 3: Fleet View (Dashboard)

### 3.1 Fleet Sidebar
**File:** `packages/desktop/ui/src/components/Agent/FleetSidebar.tsx`
- Width: 180px
- Use `SidebarSection` for Views, Status, Groups, Providers
- Use `SidebarItem` for navigation
- Add colored circles for status filters
- Remove uppercase, slashes, asterisks

### 3.2 Agent Dashboard
**File:** `packages/desktop/ui/src/components/Agent/AgentDashboard.tsx`
- Dense table layout with columns: Agent, Status, Model/Provider, Load, Req/m, Latency, Tokens, Sched, Err, Last Active, Actions
- Use `Status` component for status column
- Use `Sparkline` + `LoadBar` for load column
- Use `Tag` for model display
- Use icons for scheduled/errors columns
- Update context menu styling (remove #0f0 green)
- Remove all uppercase, tracking-widest, brackets

---

## Phase 4: Settings View

### 4.1 Settings Sidebar
**File:** `packages/desktop/ui/src/components/Agent/SettingsSidebar.tsx`
- Use `SidebarItem` with icons for each section
- Active state with left border accent
- Remove IRC-style prefixes

### 4.2 Settings Content
**File:** `packages/desktop/ui/src/components/Agent/SettingsView.tsx`
- Use `Section`, `SettingRow`, `Toggle`, `Input`, `Select`, `Button` components
- Use `ProviderCard` for provider management
- Remove slash prefixes, bracket notation, uppercase headers
- Remove theme selector section entirely

---

## Phase 5: Skills & Triggers Views

### 5.1 Skills
**Files:**
- `packages/desktop/ui/src/components/Agent/SkillsView.tsx`
- `packages/desktop/ui/src/components/Agent/SkillsSidebar.tsx`
- Update table headers to normal case
- Update context menu styling
- Use `SidebarSection` in sidebar

### 5.2 Triggers
**Files:**
- `packages/desktop/ui/src/components/Agent/TriggersView.tsx`
- `packages/desktop/ui/src/components/Agent/TriggersSidebar.tsx`
- Same updates as Skills

---

## Phase 6: Usage View

**Files:**
- `packages/desktop/ui/src/components/Agent/UsageView.tsx`
- `packages/desktop/ui/src/components/Agent/UsageSidebar.tsx`
- Update table styling
- Use `SidebarSection` in sidebar

---

## Phase 7: Agent Workspace

### 7.1 Workspace Layout
**File:** `packages/desktop/ui/src/components/Agent/AgentWorkspace.tsx`
- Update sidebar styling
- Use new `Button` component for actions
- Remove IRC-style headers

### 7.2 Agent Explorer
**File:** `packages/desktop/ui/src/components/Agent/AgentExplorer.tsx`
- Use `Status` component for agent status
- Update tree styling

### 7.3 Hierarchy Tree
**File:** `packages/desktop/ui/src/components/Agent/HierarchyTree.tsx`
- Replace bracket status with `Status` component

### 7.4 Log Viewer
**File:** `packages/desktop/ui/src/components/Agent/LogViewer.tsx`
- Keep monospace for log content
- Update container styling and colors
- Remove IRC decorators

### 7.5 Chat Input
**File:** `packages/desktop/ui/src/components/Agent/ChatInput.tsx`
- Update input styling
- Use new `Button` component

### 7.6 Agent Settings Panel
**File:** `packages/desktop/ui/src/components/Agent/AgentSettings.tsx`
- Use `Toggle`, `Select`, `Button` components
- Update section headers

---

## Phase 8: Remaining Components

- `packages/desktop/ui/src/components/Agent/ToolApproval.tsx`
- `packages/desktop/ui/src/components/Agent/SecretRequest.tsx`
- `packages/desktop/ui/src/components/Agent/InlineScopeProposal.tsx`
- `packages/desktop/ui/src/components/Agent/MissedTasksModal.tsx`
- `packages/desktop/ui/src/components/SearchBar.tsx`

---

## Key Style Changes Summary

| Before | After |
|--------|-------|
| `[RUN]`, `[ERR]`, `[WAI]` | Colored circle + `RUN`, `ERR`, `WAI` |
| `UPPERCASE TRACKING-WIDEST` | Title Case or normal |
| `/FLEET`, `/SETTINGS` | Fleet, Settings |
| `***` decorators | Remove |
| `font-mono` everywhere | System font (monospace for code only) |
| Cyan accent (#22d3ee) | Indigo accent (#6366f1) |
| `bg-[#0a0a0a]`, `text-[#0f0]` | CSS variables |

---

## Files to Modify (Complete List)

### Core
- `packages/desktop/ui/src/index.css`
- `packages/desktop/ui/src/App.tsx`
- `packages/desktop/ui/src/main.tsx` (if theme loading)

### Navigation
- `packages/desktop/ui/src/components/Unibar.tsx`
- `packages/desktop/ui/src/components/Agent/StatusBar.tsx`
- `packages/desktop/ui/src/components/SearchBar.tsx`

### Fleet
- `packages/desktop/ui/src/components/Agent/FleetSidebar.tsx`
- `packages/desktop/ui/src/components/Agent/AgentDashboard.tsx`

### Settings
- `packages/desktop/ui/src/components/Agent/SettingsSidebar.tsx`
- `packages/desktop/ui/src/components/Agent/SettingsView.tsx`

### Skills/Triggers/Usage
- `packages/desktop/ui/src/components/Agent/SkillsView.tsx`
- `packages/desktop/ui/src/components/Agent/SkillsSidebar.tsx`
- `packages/desktop/ui/src/components/Agent/TriggersView.tsx`
- `packages/desktop/ui/src/components/Agent/TriggersSidebar.tsx`
- `packages/desktop/ui/src/components/Agent/UsageView.tsx`
- `packages/desktop/ui/src/components/Agent/UsageSidebar.tsx`

### Agent Workspace
- `packages/desktop/ui/src/components/Agent/AgentWorkspace.tsx`
- `packages/desktop/ui/src/components/Agent/AgentExplorer.tsx`
- `packages/desktop/ui/src/components/Agent/HierarchyTree.tsx`
- `packages/desktop/ui/src/components/Agent/LogViewer.tsx`
- `packages/desktop/ui/src/components/Agent/ChatInput.tsx`
- `packages/desktop/ui/src/components/Agent/AgentSettings.tsx`
- `packages/desktop/ui/src/components/Agent/ToolApproval.tsx`
- `packages/desktop/ui/src/components/Agent/SecretRequest.tsx`
- `packages/desktop/ui/src/components/Agent/InlineScopeProposal.tsx`
- `packages/desktop/ui/src/components/Agent/MissedTasksModal.tsx`
- `packages/desktop/ui/src/components/Agent/ScopeDiff.tsx`
- `packages/desktop/ui/src/components/Agent/ScopeEditor.tsx`

### New Files (UI Components)
- `packages/desktop/ui/src/components/ui/Sparkline.tsx`
- `packages/desktop/ui/src/components/ui/LoadBar.tsx`
- `packages/desktop/ui/src/components/ui/Status.tsx`
- `packages/desktop/ui/src/components/ui/Tag.tsx`
- `packages/desktop/ui/src/components/ui/Metric.tsx`
- `packages/desktop/ui/src/components/ui/Toggle.tsx`
- `packages/desktop/ui/src/components/ui/Input.tsx`
- `packages/desktop/ui/src/components/ui/Select.tsx`
- `packages/desktop/ui/src/components/ui/Button.tsx`
- `packages/desktop/ui/src/components/ui/SidebarSection.tsx`
- `packages/desktop/ui/src/components/ui/SidebarItem.tsx`
- `packages/desktop/ui/src/components/ui/SettingRow.tsx`
- `packages/desktop/ui/src/components/ui/ProviderCard.tsx`
- `packages/desktop/ui/src/components/ui/Section.tsx`
- `packages/desktop/ui/src/components/ui/index.ts`

---

## Reference Files
- `docs/familiar-dense.jsx` - Fleet view reference
- `docs/familiar-settings.jsx` - Settings view reference

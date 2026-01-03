# Claude Code/Max Provider Implementation Plan

Add Claude Code subscription authentication as a separate provider in Familiar, with OAuth 2.0 PKCE flow and usage tracking.

## Summary

- **New Provider**: "claude-code" appears alongside Anthropic, OpenAI, etc.
- **OAuth Authentication**: Browser-based login to Anthropic account
- **Usage Bar**: Shows 5-hour and 7-day usage percentages with reset times

---

## Files to Create

### 1. `/packages/go-backend/internal/config/oauth.go`
Token storage and management:
- `ClaudeCodeOAuthToken` struct (access_token, refresh_token, expires_at)
- `LoadClaudeCodeToken()` / `SaveClaudeCodeToken()`
- Store refresh token in Keychain, access token in JSON file
- `IsClaudeCodeTokenValid()` - check expiry with 5-min buffer

### 2. `/packages/go-backend/internal/auth/oauth.go`
OAuth 2.0 PKCE implementation:
- Constants: ClientID `9d1c250a-e61b-44d9-88ed-5944d1962f5e`, callback port `54545`
- `StartOAuthFlow()` - generate PKCE, open browser, wait for callback
- `handleCallback()` - verify state, exchange code for tokens
- `RefreshToken()` - refresh expired access tokens
- `GetValidAccessToken()` - auto-refresh if needed
- `openBrowser()` - cross-platform browser launch

### 3. `/packages/go-backend/internal/inference/claude_code.go`
Provider implementation:
- Reuse `convertMessages()` and `convertTools()` from anthropic.go
- Use `Authorization: Bearer` header instead of `x-api-key`
- Handle 401 by refreshing token and retrying
- Default models: claude-haiku-4-5, claude-sonnet-4-5, claude-opus-4-5

### 4. `/packages/go-backend/internal/auth/usage.go`
Usage tracking:
- `GetClaudeCodeUsage()` - call `https://api.anthropic.com/api/oauth/usage`
- Headers: `Authorization: Bearer`, `anthropic-beta: oauth-2025-04-20`
- Return struct with five_hour, seven_day, seven_day_opus utilization %

---

## Files to Modify

### Backend

#### `/packages/go-backend/cmd/server/server.go`
- Add `case "claude-code":` in `createProvider()` switch
- Add claude-code to default available_models in `formatConfigResponse()`

#### `/packages/go-backend/cmd/server/handlers.go`
New WebSocket handlers:
```
case "connect_claude_code":     // Start OAuth flow (async)
case "disconnect_claude_code":  // Clear tokens
case "get_claude_code_status":  // Return { connected: bool }
case "get_claude_code_usage":   // Return usage percentages
```

Update `get_api_keys` handler:
- Add "claude-code" to providers list
- Special case: check `auth.IsClaudeCodeConnected()` instead of Keychain

### Frontend

#### `/packages/desktop/ui/src/lib/api.ts`
Add methods:
```typescript
connectClaudeCode: () => globalWS.send({ type: 'connect_claude_code' }),
disconnectClaudeCode: () => globalWS.send({ type: 'disconnect_claude_code' }),
getClaudeCodeStatus: () => globalWS.send({ type: 'get_claude_code_status' }),
getClaudeCodeUsage: () => globalWS.send({ type: 'get_claude_code_usage' }),
```

#### `/packages/desktop/ui/src/components/Agent/SettingsView.tsx`
1. Add to provider list: `['openrouter', 'anthropic', 'claude-code', 'openai', ...]`

2. Add state and queries:
```typescript
const [claudeCodeConnecting, setClaudeCodeConnecting] = useState(false);
const { data: claudeCodeStatus } = useQuery({ queryKey: ['claudeCodeStatus'], ... });
const { data: claudeCodeUsage } = useQuery({ queryKey: ['claudeCodeUsage'], ... });
```

3. Add WebSocket listener for `claude_code_connected` / `claude_code_connection_failed`

4. Special UI when `editingProvider === 'claude-code'`:
   - If connected: Show "Connected" status + Disconnect button + Usage bars
   - If not connected: Show "Connect with Anthropic Account" button

5. Usage bar component:
```tsx
{claudeCodeStatus?.connected && claudeCodeUsage && (
  <div className="space-y-2 mt-4 p-3 border border-border/10 bg-surface/5">
    <span className="text-[9px] font-black text-text-tertiary/60 uppercase">Usage</span>

    {/* 5-hour usage */}
    <div className="space-y-1">
      <div className="flex justify-between text-[9px]">
        <span>5-Hour Window</span>
        <span>{claudeCodeUsage.five_hour.utilization.toFixed(1)}%</span>
      </div>
      <div className="h-1.5 bg-surface/20 rounded-full overflow-hidden">
        <div
          className="h-full bg-accent transition-all"
          style={{ width: `${claudeCodeUsage.five_hour.utilization}%` }}
        />
      </div>
      <span className="text-[8px] text-text-tertiary/40">
        Resets {formatRelativeTime(claudeCodeUsage.five_hour.resets_at)}
      </span>
    </div>

    {/* 7-day usage */}
    <div className="space-y-1">
      <div className="flex justify-between text-[9px]">
        <span>Weekly</span>
        <span>{claudeCodeUsage.seven_day.utilization.toFixed(1)}%</span>
      </div>
      <div className="h-1.5 bg-surface/20 rounded-full overflow-hidden">
        <div
          className="h-full bg-accent transition-all"
          style={{ width: `${claudeCodeUsage.seven_day.utilization}%` }}
        />
      </div>
    </div>
  </div>
)}
```

---

## OAuth Flow Details

1. User clicks "Connect with Anthropic Account"
2. Backend generates PKCE code_verifier + code_challenge
3. Backend starts HTTP server on localhost:54545
4. Backend opens browser to:
   ```
   https://console.anthropic.com/oauth/authorize?
     client_id=9d1c250a-e61b-44d9-88ed-5944d1962f5e&
     redirect_uri=http://localhost:54545/oauth/callback&
     response_type=code&
     scope=org:create_api_key user:profile user:inference&
     state=<random>&
     code_challenge=<sha256>&
     code_challenge_method=S256
   ```
5. User logs in at Anthropic
6. Callback received at localhost:54545/oauth/callback
7. Backend exchanges code for tokens via POST to token endpoint
8. Tokens stored (access in file, refresh in Keychain)
9. WebSocket broadcasts `claude_code_connected`
10. UI updates to show connected status

---

## Usage API Details

**Endpoint**: `GET https://api.anthropic.com/api/oauth/usage`

**Headers**:
- `Authorization: Bearer <access_token>`
- `anthropic-beta: oauth-2025-04-20`

**Response**:
```json
{
  "five_hour": { "utilization": 6.0, "resets_at": "2025-11-04T04:59:59Z" },
  "seven_day": { "utilization": 35.0, "resets_at": "2025-11-06T03:59:59Z" },
  "seven_day_opus": { "utilization": 0.0, "resets_at": null }
}
```

---

## Implementation Order

1. **Backend OAuth** - oauth.go, auth/oauth.go
2. **Backend Provider** - claude_code.go, server.go registration
3. **Backend Handlers** - handlers.go WebSocket handlers
4. **Backend Usage** - auth/usage.go
5. **Frontend API** - api.ts methods
6. **Frontend UI** - SettingsView.tsx provider UI + usage bars
7. **Testing** - manual OAuth flow, token refresh, usage display

---

## Key Considerations

- **Token Security**: Refresh token in Keychain, access token in file with 0600 permissions
- **Auto-refresh**: Refresh 5 minutes before expiry
- **Error Handling**: Clear tokens on auth errors, prompt reconnection
- **Usage Polling**: Refresh usage every 30 seconds when provider panel is open

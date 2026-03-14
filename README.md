# OPNet Knowledge for Claude Code

OPNet development knowledge base — domain expertise for building on Bitcoin L1 via OPNet, without a rigid pipeline. Use with any workflow (including [agile-flow](https://github.com/shoebillrexmail-cmyk/claude-agile-flow)).

## What's Included

### Knowledge Base
| File | What it is |
|------|-----------|
| `knowledge/opnet-bible.md` | 2000+ lines — the definitive OPNet reference. Architecture, package versions, contract rules, frontend rules, backend rules, transaction rules, security checklist, deployment. Every rule came from a real bug. |
| `knowledge/opnet-troubleshooting.md` | Common errors and their fixes |
| `knowledge/slices/contract-dev.md` | AssemblyScript contract patterns, SafeMath, storage, ABI decorators |
| `knowledge/slices/frontend-dev.md` | React + WalletConnect + transaction simulation patterns |
| `knowledge/slices/backend-dev.md` | hyper-express API patterns for OPNet |
| `knowledge/slices/security-audit.md` | 27 real-bug vulnerability patterns (PAT-XX) with code examples |
| `knowledge/slices/cross-layer-validation.md` | ABI/network consistency checking |
| `knowledge/slices/deployment.md` | TransactionFactory deployment patterns |
| `knowledge/slices/e2e-testing.md` | On-chain E2E testing with real transactions |
| `knowledge/slices/ui-testing.md` | Frontend runtime verification |

### Domain Agents
| Agent | Purpose | Mode |
|-------|---------|------|
| `opnet-contract-dev` | Write AssemblyScript smart contracts, unit tests, compile WASM | Read/Write |
| `opnet-frontend-dev` | Build React + Vite frontends with WalletConnect | Read/Write |
| `opnet-backend-dev` | Build hyper-express APIs and indexers | Read/Write |
| `opnet-auditor` | 27-pattern security scan + OPNet-specific vulnerability checks | Read-only |
| `opnet-adversarial-auditor` | Invariant-based adversarial analysis | Read-only |
| `opnet-adversarial-tester` | Adversarial E2E test generation | Read/Write |
| `opnet-e2e-tester` | Real on-chain E2E tests with test wallets | Read/Write |
| `opnet-deployer` | Deploy contracts to testnet/mainnet | Read/Write |
| `cross-layer-validator` | Check ABI/frontend/backend consistency | Read-only |
| `spec-writer` | Generate TLA+ formal specs from requirements, verify with TLC | Read/Write |
| `spec-auditor` | Reverse-engineer specs from existing code/specs, find design-level bugs | Read/Write |
| `contract-optimizer` | Gas efficiency, storage layout optimization, performance review | Read-only |
| `frontend-analyzer` | Deep anti-pattern scan (40+ checks) for OPNet frontends | Read-only |
| `backend-analyzer` | Reliability, indexer gaps, caching, error recovery review | Read-only |
| `migration-planner` | Plan safe contract upgrades — storage compatibility, ABI diffs, rollback | Read/Write |
| `dependency-auditor` | Package versions, @rc tags, conflicts, npm audit across all layers | Read-only |

### Skills
| Skill | What it does |
|-------|-------------|
| `/opnet-knowledge:pua` | Problem-solving Under Adversity — structured debugging methodology |
| `/opnet-knowledge:audit-from-bugs` | Generate audit patterns from past bug reports |
| `/opnet-knowledge:verify-spec` | Generate + verify a TLA+ formal specification for a contract |

### Scripts
| Script | What it does |
|--------|-------------|
| `scripts/setup-tla.sh` | Downloads TLC model checker (one-time setup, requires Java 11+) |
| `scripts/verify-spec.sh` | Runs TLC against a `.tla` spec, outputs `verification-result.json` |
| `scripts/parse-tlc-output.py` | Parses TLC output into structured JSON |

### Starter Templates
- `templates/starters/op20-token/` — Complete OP-20 token project (contract + frontend)

### Rules
| File | What it does |
|------|-------------|
| `rules/agent-routing.md` | Auto-detects OPNet projects and routes to the right agent based on context. Maps opnet-bob MCP tools to local agents. Defines when to use each agent proactively. |

### Learning Data
- `learning/opnet-foundry.md` — Foundry tooling for OPNet
- `learning/op-1155-standard.md` — OP-1155 multi-token standard
- `learning/patterns.yaml` — Extracted patterns from past projects

## Install

### Option A: Plugin (provides skills, agents, hooks)

```bash
# Add as marketplace and install
claude plugin marketplace add /path/to/opnet-knowledge --scope user
claude plugin install opnet-knowledge@opnet-knowledge --scope user
```

### Option B: Rules only (auto-routing without slash commands)

```bash
git clone https://github.com/shoebillrexmail-cmyk/opnet-knowledge.git
cd opnet-knowledge
bash install.sh
```

The installer copies `rules/agent-routing.md` to `~/.claude/rules/common/opnet-agent-routing.md`. This loads automatically in every session and makes Claude:
- Detect OPNet projects from `@btc-vision` imports, `asconfig.json`, etc.
- Read the Bible before writing contract code
- Run the auditor after code changes
- Use opnet-bob MCP tools when available for live data

### Option C: Both (recommended)

Install the plugin AND run the installer for full coverage:
- Plugin provides: slash commands, agents, hooks
- Rules provide: automatic context-based agent routing

## Usage

This plugin provides knowledge and agents — no rigid pipeline. Just talk to Claude naturally.

### Get OPNet guidance while coding

```
You: How do I set up storage pointers for a mapping in my contract?

Claude: (reads opnet-bible.md, gives you the exact pattern with StoredMapU256)
```

### Run a security audit

```
You: Run the OPNet auditor on my contracts

Claude: → Launches opnet-auditor agent
        → Runs 27 real-bug pattern scan (PAT-S1 through PAT-T3)
        → Checks arithmetic safety, access control, reentrancy, storage, gas
        → Reports: VERDICT: PASS/FAIL with file:line references
```

### Formally verify a contract design (TLA+)

```
You: Verify the staking contract design before I write code

Claude: → Launches spec-writer agent
        → Translates requirements into TLA+ specification
        → Defines invariants: BalanceConservation, NoNegativeBalance,
          AccessControl, RevertConsistency
        → Runs TLC model checker (explores all possible states)
        → Reports: "12,847 states checked. All invariants hold."
        → Or: "VIOLATION: BalanceConservation broken when
          Transfer(alice, bob, 150) with balance=100. Fixing design..."
```

### Find design bugs in existing contracts

```
You: Check my OptionsPool contract for design-level bugs

Claude: → Launches spec-auditor agent
        → Reads the contract source code
        → Reverse-engineers the state machine (storage vars, methods, guards)
        → Models OPNet partial reverts (BTC transfer + contract revert)
        → Generates TLA+ spec from what the code ACTUALLY does
        → Runs TLC against invariants
        → Reports: "DESIGN-CRITICAL: If alice and bob both execute
          reservations in the same block, totalReserved exceeds
          available liquidity. Attack sequence: ..."
```

### Verify a spec/PRD for logical gaps

```
You: Check my collateral recycling spec for race conditions

Claude: → Launches spec-auditor in spec mode
        → Extracts state machine from the document
        → Models multi-actor interactions
        → Reports implicit assumptions the spec doesn't enforce
```

### Validate cross-layer integration

```
You: Check if my frontend calls match the contract ABI

Claude: → Launches cross-layer-validator agent
        → Parses contract ABI
        → Checks every frontend contract call
        → Reports mismatches with file:line
```

### Build a contract

```
You: Build an OP-20 token contract with staking

Claude: → Launches opnet-contract-dev agent
        → Reads the bible and contract-dev knowledge slice
        → Writes AssemblyScript contract with SafeMath, proper decorators
        → Writes unit tests
        → Runs verify pipeline (lint → typecheck → build → test)
```

### Start a new project from template

```
You: Scaffold a new OP-20 token project

Claude: → Copies templates/starters/op20-token/
        → Sets up contract + frontend with correct dependencies
        → Ready to customize
```

## Works With Agile Flow

This plugin pairs with [agile-flow](https://github.com/shoebillrexmail-cmyk/claude-agile-flow) for project management:

- **agile-flow** manages stories, sprints, boards, and git worktrees
- **opnet-knowledge** provides the domain expertise for building on OPNet

```
/agile-flow:pickup STORY-staking-contract
→ Claude enters worktree, reads the story
→ Uses opnet-contract-dev agent to build the contract
→ Uses opnet-auditor to verify security
→ /agile-flow:done → PR + board update
```

## Based On

Derived from [buidl-opnet-plugin](https://github.com/anthropics/buidl-opnet-plugin) by dannyplainview + bob. The knowledge base and domain agents are preserved; the closed-loop orchestration pipeline (`/buidl`) is removed in favor of flexible, agent-driven workflows.

## License

MIT

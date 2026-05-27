# Steam Game Server Automation

This repository contains a config-driven automation system for managing self-hosted Steam dedicated game servers on Debian.

It provides:
- Automated server updates via SteamCMD
- Scheduled backups with retention policies
- systemd-based service orchestration
- Per-game configuration abstraction

---

## Overview

The system is designed around three layers:

### 1. systemd (orchestration layer)
Handles:
- service lifecycle (start/stop/restart)
- scheduled execution (timers)
- supervision of long-running game servers

### 2. Bash scripts (execution layer)
Handles:
- backup logic
- update logic via SteamCMD
- service coordination

### 3. Configuration files (data layer)
Defines per-game variables such as:
- Steam AppID
- installation directory
- save locations
- backup destinations

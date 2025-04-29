# :blue_book: Exter-Documents (QBCore Compatible) — Advanced & Free Document System

**Exter-Documents** is a modern and customizable documentation system inspired by **NoPixel 4.0**, built specifically for the **QBCore Framework**. This script is **free**, supports **multi-inventory systems**, and includes **dynamic licensing classes** tailored for your roleplay server. We will upload this script to Tebex in the form of an encrypted file. We will probably release it next month if there are no obstacles.

--------------------------------------------------------------------------------------------
## :dart: Key Features

- :page_facing_up: **ID Card** — Displays full character identity (name, DOB, gender, job, etc.)
- :red_car: **Driver License** — Vehicle driving license with class type support.
- :gun: **Weapon License** — Weapon license with class-based permissions (e.g., A/B/C).
- :bow_and_arrow: **Hunting License** — Dynamic hunting license with class tiering.
- :oncoming_police_car: **Police Badge** — Official badge for police officers.
- :hospital: **EMS Badge** — Official badge for emergency medical staff.
- :package: **Multi-Inventory Support** — Fully compatible with `ox_inventory`, `qb-inventory`, and more.
- :frame_photo: **Modern NoPixel-Inspired UI** — Clean, immersive interface design.

--------------------------------------------------------------------------------------------

# Snippest
---
Go into your qb-multicharacter server-side file qb-multicharacter/server/main.lua and replace GiveStarterItems function with this:
---

```lua
local function GiveStarterItems(source)
    local src = source
    TriggerEvent('exter-documents:createMeta:server', src)
    local Player = QBCore.Functions.GetPlayer(src)
    for _, v in pairs(QBCore.Shared.StarterItems) do
        local info = {}
        Player.Functions.AddItem(v.item, v.amount, false, info)
    end
end
```

---
## It will automatically give the identity card and driver license when the user has just registered. You'll also have to remove id_card and driverlicense from the StarterItems in your qb-core/shared/main.lua config.
---

### if you using ox_inventory
```lua
['idcard'] = {
    label = 'ID Card',
    weight = 10,
    consume = 0,
    close = true,
    stack = false,
    server = {
        export = 'exter-documents.idcard'
    }
},
['driverlicense'] = {
    label = 'Driver License',
    weight = 10,
    consume = 0,
    close = true,
    stack = false,
    server = {
        export = 'exter-documents.driverlicense'
    }
},
['lspdbadge'] = {
    label = 'LSPD Badge',
    weight = 10,
    consume = 0,
    close = true,
    stack = false,
    server = {
        export = 'exter-documents.lspdbadge'
    }
},
['lsmsbadge'] = {
    label = 'LSMS Badge',
    weight = 10,
    consume = 0,
    close = true,
    stack = false,
    server = {
        export = 'exter-documents.lsmsbadge'
    }
},
['weaponlicense2'] = {
    label = 'Weapon License',
    weight = 10,
    consume = 0,
    close = true,
    stack = false,
    server = {
        export = 'exter-documents.weaponlicense2'
    }
},
['huntinglicense'] = {
    label = 'Hunting License',
    weight = 10,
    consume = 0,
    close = true,
    stack = false,
    server = {
        export = 'exter-documents.huntinglicense'
    }
}
```
### if you using qb-inventory
```lua
idcard = { name = 'idcard', label = 'Identity Card', weight = 100, type = 'item', image = 'idcard.png', unique = true, useable = true, shouldClose = true, combinable = nil, description = 'A Useable Identity Card' },
driverlicense = { name = 'driverlicense', label = 'Driver License', weight = 100, type = 'item', image = 'driverlicense.png', unique = true, useable = true, shouldClose = true, combinable = nil, description = 'A Useable Driver License' },
lspdbadge = { name = 'lspdbadge', label = 'LSPD Badge', weight = 100, type = 'item', image = 'lspdbadge.png', unique = true, useable = true, shouldClose = true, combinable = nil, description = 'A Useable LSPD Badge' },
lsmsbadge = { name = 'lsmsbadge', label = 'LSMS Badge', weight = 100, type = 'item', image = 'lsmsbadge.png', unique = true, useable = true, shouldClose = true, combinable = nil, description = 'A Useable LSMS Badge' },
weaponlicense2 = { name = 'weaponlicense2', label = 'Weapon License', weight = 0, type = 'item', image = 'weapon_license_pa.png', unique = true, useable = true, shouldClose = true, combinable = nil, description = 'A Useable Weapon License' },
huntinglicense = { name = 'huntinglicense', label = 'Hunter License', weight = 0, type = 'item', image = 'huntinglicense.png', unique = true, useable = true, shouldClose = true, combinable = nil, description = 'A Useable Hunting License' },
```

## PREVIEW

[idcard](https://github.com/user-attachments/assets/c37bf295-3b47-42d3-9bee-cdcedbdb60a1)
------------------------------------------------------------------------------------------
[driverlicense](https://github.com/user-attachments/assets/31f9968b-050b-46f9-9f9f-18f3c49c018d)
------------------------------------------------------------------------------------------
[lsmsbadge](https://github.com/user-attachments/assets/40aaf3b2-b070-4b2d-a464-5011be08cb48)
------------------------------------------------------------------------------------------
[lspdbadge](https://github.com/user-attachments/assets/6b7b1c0f-1127-4291-b2bf-56f072c4adcf)
------------------------------------------------------------------------------------------
https://github.com/user-attachments/assets/0b35b46b-25bb-48f1-954d-0062a0167f1d

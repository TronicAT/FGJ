# FGJ Game Project (Finnish Game Jam) 30.1.-01.2.

## 1. Idea
2D puzzle/platformer. Kerää maskeja edetäksesi pelissä. 
Voi käyttää yhtä maskia kerralla. Voi vaihtaa inventorysta

---

## 2. Core Gameplay
- Pelaaja liikkuu vasen/oikea
- Hyppy = default ja maski buff 
- Esteet = Liikkuvia platformeja tai liian korkeita joita ei voi ilman maskia päästä
- Viholliset = voiko tappaa?
- Tavoite = pääse maaliin

---

## 3. Mekaniikat
### Player
- Liike
- Hyppy
- HP / kuolema

### Enemies
- Patrol 
- Damage

### World
- Tilemap
- Collision
- Checkpointit

---

## 4. Tekninen toteutus
- Engine: Godot 4 (.NET)
- Kieli: C#/gd
- Versionhallinta: Git

---

## 5. Rakenne

Scenes:
- Main
- Player
- Level

Scripts:
- Player.cs
- Enemy.cs
- GameManager.cs

---

## 6. Kehitysvaiheet

### Milestone 1
- Player liikkuu
- Hyppy

### Milestone 2
- Level
- Collision

### Milestone 3
- Enemy

---

## 7. TODO

- [x] Player controller
- [x] Kamera
- [x] Enemy AI
- [x] UI

---

## 8. Ideat myöhemmin
- Inventory ON
- Abilityt ON
- Boss ON


## 0. dia
cím
név
OE logo
konzulens

# 1. dia: Témaválasztás - típusrendszerek
- programnyelvek: szakmai érdeklődésem központja
- meglévő programozó tapasztalatok -> elméleti jellegű témaválasztás
- elégedetlenségem az elterjed dinamikus nyelvekkel
    - JavaScript, Python, Shell scripts

# 2. dia: Téma áttekintése
- típuselmélet
- dinamikus / statikus nyelvek, típusellenőrzés
- típusrendszer fogalmak
- típusrendszer elemek megjelnése nyelvekben

# 3. dia: Problémák a gyakorlatban
- dinamikus vs statikus
    - szubjektív - nem kimutatott, hogy egyik jobb volna, mint a másik
- saját tapasztalat: egyértelműen jobbnak érzem a statikus nyelveket
- statikus nyelvek általános előnyei
    - védőháló funkció
    - több garancia a helyességre
    - trial-and-error ciklus rövidítése
    - futásidejű hibák (ügyfélnél) -> fordítási idejű hibák (fejlesztőnél)

# 4. dia: Gyakorlati lehetőségek I. : graduális típusosság
- mit jelent?
- lehetőségek
    - Javascript -> Typescript
    - Python -> type hints, Mypy,
    - Php -> Hack,
    - dinamikus nyelven íródott kódbázis fokozatos megerősítése
    - fokozatos átállás, nem akasztja meg a projektet

# 5. dia: Gyakorlati lehetőségek II. : algebrai típusok
- algebrai típusok (sum types) - Elm, Haskell, Rust
    - elegáns modellezése a bizonytalanságnak
        - NullPointerException kiiktatása
    - futás idejű hibák megszüntetése
        - "teljes hibakezelés", másként le sem fordul

# 6. dia: Gyakorlati lehetőségek III. : Rust - Ownership rendszer
- Ownership rendszer - Rust
    - fordítási időben megoldott biztonságos memóriakezelés
    - memóriakezelésből eredő hibák kiiktatása
        - out-of-bounds olvasás / írás
        - memory leak - fel nem szabadított memóra
        - data race

# 7. dia
- "Várom a kérdéseket, köszönöm a figyelmet"

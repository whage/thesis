## 1. dia
cím
név
OE logo
konzulens

# 2. dia: Témaválasztás - típusrendszerek
- programnyelvek: szakmai érdeklődésem központja
- meglévő programozói tapasztalatok -> elméleti jellegű témaválasztás
- elégedetlenségem
    - az elterjed dinamikus nyelvekkel
    - az általános szoftverminőséggel

# 3. dia: Téma áttekintése
- típuselmélet -> típusrendszerek
- típusellenőrzés: dinamikus / statikus nyelvek
- típusrendszer fogalmak
- típusrendszer elemek megjelenése nyelvekben

# 4. dia: Dinamikus vs. statikus a gyakorlatban
- szubjektív, nem kimutatott, saját tapasztalat
- statikus nyelvek általános előnyei
    - védőháló funkció
    - bizonyos szintű garancia a konzisztens kódra (!= helyesség)
    - futásidejű hibák (ügyfélnél) -> fordítási idejű hibák (fejlesztőnél)
- célom: bemutatni a statikus oldal gyakorlati lehetőségeit

# 5. dia: Gyakorlati lehetőségek I.: graduális típusosság
- Javascript -> Typescript
- Python -> type hints, Mypy
- Php -> Hack
- lehetőségek
    - dinamikus nyelven íródott kódbázis fokozatos megerősítése
    - fokozatos átállás, nem akasztja meg a projektet

# 6. dia: Gyakorlati lehetőségek II.: algebrai típusok
- Sum types - ML nyelvcsalád, Rust, Swift
    - elegáns modellezése a bizonytalanságnak
        - NullPointerException kiiktatása
    - futásidejű hibák eliminálása
        - "teljes hibakezelés", másként le sem fordul

# 7. dia: Gyakorlati lehetőségek III.: Rust - Ownership rendszer
- fordítási időben megoldott biztonságos memóriakezelés
- memóriakezelésből eredő hibák kiiktatása
    - out-of-bounds olvasás / írás
    - memory leak - fel nem szabadított memóra
    - data race
- teljesítmény

# 8. dia
- "Várom a kérdéseket, köszönöm a figyelmet"

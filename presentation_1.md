# Légrádi Gábor által megadott fő részek
1. megoldandó feladat részletes ismertetése

(Mit kell pontosan  megoldanunk? Milyen célt kell elérnünk?)

2. hasonló feladatok már meglevő megoldásainak áttekintése, részletes elemzése - irodalomkutatás

(Hol áll jelenleg a világ, az ilyen jellegű problémák megoldásával?
Eddig mások mire is jutottak? Azok mennyire közelítik meg az általunk
kitűzött célt?)

3. a további feladatok megtervezése, időterv készítése, a megoldás
ütemezése.

(Hogyan és mikorra tudjuk a feladat megoldását elkészíteni? (Azaz
közelítő időterv megadása a második szakdolgozati félévre.)
(Ha programot/alkalmazást írunk milyen az elkészítendő rendszer --
legalább vázlatos -- rendszerterve?)

# tervezett munka
- programnyelvek típusrendszereit megvizsgálni, összehasonlítani
    - assembly
        - típusrendszer hiánya! előnyök!
    - javascript
    - python
    - C / C++
    - java, scala
    - ML típusú nyelvek (Haskell, OCaml)
    - Agda
    - Rust

## 0. dia
cím
név
OE logo
konzulens

## 1. dia: Témaválasztás, személyes motiváció
- programnyelvek iránti érdeklődés, saját határaim feszegetése
- gyakorlati tapasztalat (és annak hiánya) szülte kíváncsiság
- az anyag nem része a BSc képzésnek, pedig nagy jelentőségű terület
    - az iparban is elhanyagolt (ez csak saját tapasztalat, adatokkal alátámasztani!)
- a terület nagy terjedelme: legyen lehetőség a folytatásra (MSc ?)

## 2. dia: Típusrendszerek
- szakirodalmi áttekintés: nagyon absztrakt, elméleti, nehezen feldolgozható anyagok
- típusrendszerek elméleti háttere
- typechechecker: elmélet -> gyakorlat
- történeti áttekintés, jelentős újítások
- típusrendszerek osztályozása
- biztonság és teljesítmény

## 3. dia: Kutatás, dolgozat célja
- programozói és szoftver teljesítmény, minőség növelésének lehetőségei
- korábbi kutatások áttekintése
- kvalitatív szemléletű kutatás - szubjektív!
    - összehasonlító elemzés
- fejlett típusrendszerek gyakorlati lehetőségei
    - a szoftver krízis szerintem nem múlt el
    - mi tartja vissza az embereket? korlátok?

## 4. dia: Vizsgálat tárgya
- programozási nyelvek összehasonlítása típusrendszer szempontjából
    - assembly: típusrendszer hiányának megvannak az előnyei!
    - javascript: dinamikus, "gyenge"
    - python: dinamikus, "erős"
    - C / C++: statikus, "gyenge"
    - java, **scala**: statikus, "erős"
    - **ML típusú nyelvek (Haskell, OCaml)**: typeclass, "kind"
    - **Agda**: dependent types
    - **Rust**: safety and performance
- a vastagon szedett nyelvekkel még nem dolgoztam: izgalommal várom!
- összehasonlítás alapja: ?
    - feldolgozásra váró publikációk
    - menet közben kialakítani egy keretrendszert az összehasonlításra?
- (?) referencia implementáció: Conway's game of life

## 5. dia: Ütemezés
- máj-jún: szakirodalmi áttekintés véglegesítése
- júl: kutatás - lehetséges módszertanok, hasonló vizsgálatok áttekintse
- aug-szept-okt: konkrét programnyelvek áttekintése
- nov: a kitűzött nyelvek típusrendszereinek feldolgozása, összehasonlító elemzés

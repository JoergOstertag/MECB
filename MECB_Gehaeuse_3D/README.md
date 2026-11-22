# MECB-Gehaeuse (3D-Druck)

Gehaeuse fuer den Minimalist Europe Card Bus (DigicoolThings). Die
Backplane liegt flach am Boden, die Karten stehen senkrecht darin.
Quelle ist `MECB_Gehaeuse.scad`; die STL-Dateien daneben sind daraus
erzeugt und koennen jederzeit neu erzeugt werden.

## Dateien

| Datei                      | Inhalt                                      |
|----------------------------|---------------------------------------------|
| MECB_Gehaeuse.scad         | Quelle, alle Masse und Parameter            |
| MECB_Gehaeuse.stl          | Zusammenbau-Ansicht (nicht zum Drucken)     |
| MECB_Gehaeuse_boden.stl    | Bodenplatte mit Backplane-Domen             |
| MECB_Gehaeuse_rahmen.stl   | Rahmen mit Kartenfuehrungen                 |
| MECB_Gehaeuse_blende.stl   | Blende der Netzteilseite                    |
| MECB_Gehaeuse_deckel.stl   | Deckel                                      |
| MECB_Gehaeuse_probe.stl    | Testteil: ein Fuehrungskanal und ein M3-Dom |

Jedes Druckteil liegt in seiner STL-Datei schon in Drucklage: z = 0 ist
das Druckbett, x und y sind positiv.

## Abmessungen der Druckteile

| Teil   |     x |     y |     z | Hinweis zum Druck                 |
|--------|------:|------:|------:|-----------------------------------|
| boden  | 112.4 | 107.0 |  15.0 | flach, Dome nach oben             |
| rahmen | 112.4 | 107.0 | 134.9 | stehend, braucht 135 mm Bauhoehe  |
| blende | 134.5 | 100.6 |   2.6 | liegt flach                       |
| deckel | 112.4 | 107.0 |   6.0 | Aussenseite unten, Kragen oben    |
| probe  |  44.0 |  14.0 |  40.0 | zuerst drucken                    |

Der Rahmen ist das einzige Teil, das einen hohen Bauraum braucht.

## STL-Dateien neu erzeugen

```bash
for t in boden rahmen blende deckel probe; do          # je Teil eine Datei
    openscad -o "MECB_Gehaeuse_$t.stl" -D "teil=\"$t\"" MECB_Gehaeuse.scad
done
openscad -o MECB_Gehaeuse.stl -D 'teil="alle"' \
         -D 'zeige_hardware=false' MECB_Gehaeuse.scad  # Zusammenbau
```

Unter Windows liegt das Programm als
`C:\Program Files\OpenSCAD\openscad.com` (Konsolenfassung), unter
Ubuntu als `openscad`. Die Aufrufe laufen unter Cygwin/Git Bash ebenso
wie unter Ubuntu.

## Vor dem grossen Druck

Zwei Masse stehen nicht in den Gerbern des MECB-Repositories und sind
daher am eigenen Aufbau zu pruefen - `STECKHOEHE` (Unterkante Karte
ueber der Backplane, derzeit 13.5 mm aus DIN 41612) und
`UEBERSTAND_SLOT5` (Winkelbuchse ueber der rechten Platinenkante,
derzeit 6 mm mit Reserve). Deshalb zuerst `probe` drucken, Kartenkante
und M3-Gewinde pruefen, dann die grossen Teile.

## Schrauben

6x M3x8 (Backplane auf die Dome), 4x M3x12 (Boden an Rahmen),
4x M3x12 (Deckel an Rahmen), 4x M3x12 (Blende an Rahmen) - alle
selbstschneidend in den Kunststoff.

# MECB-Gehaeuse (3D-Druck)

Gehaeuse fuer den Minimalist Europe Card Bus (DigicoolThings). Die
Backplane liegt flach am Boden, die Karten stehen senkrecht darin.
Quelle ist `MECB_Gehaeuse.scad`; die STL-Dateien daneben sind daraus
erzeugt und koennen jederzeit neu erzeugt werden.

Der Rahmen besteht aus **vier Seitenteilen** (senkrechte Teilung an den
Ecken). Kein Teil ist hoeher als 15 mm in Drucklage - vorher brauchte
der einteilige Rahmen 135 mm Bauhoehe.

## Dateien

| Datei                          | Inhalt                                    |
|--------------------------------|-------------------------------------------|
| MECB_Gehaeuse.scad             | Quelle, alle Masse und Parameter           |
| MECB_Gehaeuse.stl              | Zusammenbau-Ansicht (nicht zum Drucken)    |
| MECB_Gehaeuse_boden.stl        | Bodenplatte mit Backplane-Domen            |
| MECB_Gehaeuse_wand_vorn.stl    | Laengswand vorn, mit Kartenfuehrung        |
| MECB_Gehaeuse_wand_hinten.stl  | Laengswand hinten, mit Kartenfuehrung      |
| MECB_Gehaeuse_blende.stl       | linke Seite, Fenster fuer das Netzteil     |
| MECB_Gehaeuse_wand_rechts.stl  | rechte Seite, Lueftung                     |
| MECB_Gehaeuse_deckel.stl       | Deckel                                    |
| MECB_Gehaeuse_probe.stl        | Testteil: ein Fuehrungskanal und ein Dom   |

Jedes Druckteil liegt in seiner STL-Datei schon in Drucklage: z = 0 ist
das Druckbett, x und y sind positiv.

## Abmessungen der Druckteile

| Teil        |     x |     y |    z | Hinweis zum Druck               |
|-------------|------:|------:|-----:|---------------------------------|
| boden       | 112.4 | 107.0 | 15.0 | flach, Dome nach oben           |
| wand_vorn   | 112.4 | 134.9 | 15.0 | liegt auf der Aussenflaeche     |
| wand_hinten | 112.4 | 134.9 | 15.0 | liegt auf der Aussenflaeche     |
| blende      | 134.5 | 100.6 |  2.6 | liegt flach, Fenster unten      |
| wand_rechts | 134.5 | 100.6 |  2.6 | liegt flach                     |
| deckel      | 112.4 | 107.0 |  6.0 | Aussenseite unten, Kragen oben  |
| probe       |  44.0 |  14.0 | 40.0 | zuerst drucken                  |

Groesster Bettbedarf: 134.9 mm in einer Achse. Kein Teil braucht
Stuetzmaterial; alle Anbauteile (Stege, Saeulen, Dome) zeigen in
Drucklage nach oben.

## Aufbau und Verschraubung

Die beiden Laengswaende tragen alle Gewinde. Boden und Deckel klammern
sie von unten und oben, die beiden Seitenplatten ziehen sie zusammen.

| Verbindung              | Schrauben | Gewinde sitzt in            |
|-------------------------|-----------|-----------------------------|
| Backplane -> Boden      | 6x M3x8   | Dome des Bodens             |
| Laengswand -> Boden     | 4x M3x12  | Dom der Laengswand          |
| Deckel -> Laengswand    | 4x M3x12  | Eckdom der Laengswand       |
| blende -> Laengswand    | 4x M3x12  | Saeule am linken Wandende   |
| wand_rechts -> Laengswand | 4x M3x12 | Saeule am rechten Wandende |

Alle Schrauben schneiden sich selbst in den Kunststoff (Kernloch
2.7 mm).

## Reihenfolge des Zusammenbaus

Die Reihenfolge ist nicht beliebig; sie folgt aus geprueften
Verschnitt-Tests (siehe CHANGES.txt):

1. **Backplane auf die Dome des Bodens schrauben** (6x M3x8). Das muss
   zuerst geschehen: zwei der sechs Schrauben (x = 3.81, y = 3.81 und
   y = 96.012) liegen danach unter den Saeulen der Laengswaende, ein
   Schrauber kommt dort nicht mehr hin.
2. **Karten einstecken**, solange noch keine Wand steht.
3. **wand_vorn und wand_hinten** aufsetzen und am Boden verschrauben.
4. **blende und wand_rechts** anschrauben, **Deckel** zuletzt.

Die Backplane laesst sich nicht von oben durch den fertigen Rahmen
einsetzen - Fuehrungsstege und Saeulen versperren den Weg (gemessen:
19 695 mm3 im Einschubweg). Mit der vierteiligen Teilung ist das kein
Problem, weil die Waende zuletzt kommen.

## Kartenfuehrung - Masse der Passung

| Mass                              | Wert                          |
|-----------------------------------|-------------------------------|
| Kanalbreite, Karte 1.6 mm         | 3.0 mm, also 0.7 mm je Seite  |
| Kanalbreite oben (Einfuehrtrichter) | 4.6 mm                      |
| Fuehrungstiefe an der Kartenkante | 1.6 mm je Seite               |
| Luft ueber der Kartenoberkante    | 8.0 mm, mit Deckel 5.0 mm     |

Der Einfuehrtrichter sitzt auf den obersten 10 mm der Stege: dort weicht
der Steg in x um 0.8 mm nach aussen (der Kanal wird breiter) und zieht
sich in y auf 0.6 mm zurueck. Man muss die Kartenkante beim Einstecken
also nicht auf 3.0 mm genau treffen.

Der senkrechte Weg einer Karte aus dem Steckplatz heraus ist frei
geprueft - eine Karte laesst sich bei abgenommenem Deckel gerade nach
oben herausziehen. Zum Anfassen bleiben ueber der Kartenoberkante aber
nur 8 mm (mit aufgesetztem Deckel 5 mm); fuer bequemes Ziehen ist das
knapp, siehe TODO.txt Punkt 5.

## STL-Dateien neu erzeugen

```bash
for t in boden wand_vorn wand_hinten blende wand_rechts deckel probe; do
    openscad -o "MECB_Gehaeuse_$t.stl" -D "teil=\"$t\"" MECB_Gehaeuse.scad
done
openscad -o MECB_Gehaeuse.stl -D 'teil="alle"' \
         -D 'zeige_hardware=false' MECB_Gehaeuse.scad  # Zusammenbau
```

Unter Windows liegt das Programm als
`C:\Program Files\OpenSCAD\openscad.com` (Konsolenfassung), unter
Ubuntu als `openscad`. Die Aufrufe laufen unter Cygwin/Git Bash ebenso
wie unter Ubuntu.

## Verschnitt-Tests

Die Freigaengigkeit der Teile ist nicht geschaetzt, sondern mit
Booleschen Verschnitten geprueft: je Teilepaar eine `intersection()`,
dann das Volumen des Ergebnisses aus der STL-Datei berechnet. Volumen 0
heisst beruehrende Flaeche (zulaessig), Volumen groesser 0 heisst
Materialkonflikt. Die Skripte stehen nicht im Repository; der Aufruf
steht in CHANGES.txt.

## Vor dem grossen Druck

Zwei Masse stehen nicht in den Gerbern des MECB-Repositories und sind
daher am eigenen Aufbau zu pruefen - `STECKHOEHE` (Unterkante Karte
ueber der Backplane, derzeit 13.5 mm aus DIN 41612) und
`UEBERSTAND_SLOT5` (Winkelbuchse ueber der rechten Platinenkante,
derzeit 6 mm mit Reserve). Deshalb zuerst `probe` drucken, Kartenkante,
Einfuehrtrichter und M3-Gewinde pruefen, dann die grossen Teile.

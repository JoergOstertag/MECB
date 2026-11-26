# MECB-Gehaeuse (3D-Druck)

Gehaeuse fuer den Minimalist Europe Card Bus (DigicoolThings). Die
Backplane liegt flach am Boden, die Karten stehen senkrecht darin.
Quelle ist `MECB_Gehaeuse.scad`; die STL-Dateien daneben sind daraus
erzeugt und koennen jederzeit neu erzeugt werden.

Der Rahmen besteht aus **vier Seitenteilen** (senkrechte Teilung an den
Ecken). Kein Teil ist in Drucklage hoeher als 17 mm - vorher brauchte
der einteilige Rahmen 135 mm Bauhoehe.

## Dateien

| Datei                         | Inhalt                                   |
|-------------------------------|------------------------------------------|
| MECB_Gehaeuse.scad            | Quelle, alle Masse und Parameter         |
| MECB_Gehaeuse_boden.stl       | Bodenplatte 5 mm, mit Backplane-Domen    |
| MECB_Gehaeuse_wand_vorn.stl   | Laengswand vorn, mit Kartenfuehrung      |
| MECB_Gehaeuse_wand_hinten.stl | Laengswand hinten, mit Kartenfuehrung    |
| MECB_Gehaeuse_blende.stl      | linke Seite, Fenster fuer das Netzteil   |
| MECB_Gehaeuse_wand_rechts.stl | rechte Seite, Lueftung                   |
| MECB_Gehaeuse_deckel.stl      | Deckel mit Griffoeffnungen               |
| MECB_Gehaeuse_probe.stl       | Testteil: ein Fuehrungskanal und ein Dom |
| MECB_Gehaeuse_platte.stl      | alle sieben Druckteile in einem Druck    |

Jedes Druckteil liegt in seiner STL-Datei schon in Drucklage: z = 0 ist
das Druckbett, x und y sind positiv.

## Abmessungen der Druckteile

| Teil        |     x |     y |    z | Hinweis zum Druck               |
|-------------|------:|------:|-----:|---------------------------------|
| boden       | 112.4 | 107.0 | 17.0 | flach, Dome nach oben           |
| wand_vorn   | 112.4 | 134.9 | 15.0 | liegt auf der Aussenflaeche     |
| wand_hinten | 112.4 | 134.9 | 15.0 | liegt auf der Aussenflaeche     |
| blende      | 134.5 | 100.6 |  3.0 | liegt flach, Fenster unten      |
| wand_rechts | 134.5 | 100.6 |  3.0 | liegt flach                     |
| deckel      | 112.4 | 107.0 |  6.0 | Aussenseite unten, Kragen oben  |
| probe       |  44.0 |  14.0 | 40.0 | zuerst drucken                  |

Aussenmass des Gehaeuses: 112.4 x 107.0 x 142.9 mm. Groesster
Bettbedarf: 134.9 mm in einer Achse. Kein Teil braucht
Stuetzmaterial; alle Anbauteile (Stege, Saeulen, Dome) zeigen in
Drucklage nach oben.

## Alle Teile in einem Druck (MECB_Gehaeuse_platte.stl)

`MECB_Gehaeuse_platte.stl` enthaelt alle sieben Druckteile, jedes in
seiner Drucklage, nebeneinander auf dem Bett: links die vordere Wand
mit Boden und Probe, in der Mitte die hintere Wand mit Deckel, rechts
die beiden Seitenplatten um 90 Grad gedreht. Abstand zwischen den
Teilen 5 mm (`platte_abstand` in der scad).

**Die Platte braucht 335.5 x 274.0 mm Bettflaeche**, hoechstes Teil
40 mm (die Probe). Das haben nur Grossformat-Drucker - ein 256-mm- oder
300-mm-Bett reicht NICHT. Die Grundflaeche der sieben Teile ist allein
82000 mm^2, also mindestens 287 x 287 mm selbst bei lueckenlosem
Packen; ein kleinerer Abstand hilft deshalb nicht. Auf kleineren
Druckern bleiben die Einzeldateien - jedes Teil passt auf 135 x 115 mm.

## Aufbau und Verschraubung

Die beiden Laengswaende tragen alle Gewinde. Boden und Deckel klammern
sie von unten und oben, die beiden Seitenplatten ziehen sie zusammen.

| Verbindung                | Schrauben | Kopf                      |
|---------------------------|-----------|---------------------------|
| Backplane -> Boden        | 6x M3x8   | auf der Backplane         |
| Laengswand -> Boden       | 4x M3x12  | in der Senkung des Bodens |
| Deckel -> Laengswand      | 4x M3x12  | liegt oben auf            |
| blende -> Laengswand      | 4x M3x10  | liegt aussen auf          |
| wand_rechts -> Laengswand | 4x M3x10  | liegt aussen auf          |

Die Seitenplatten brauchen M3x10, nicht M3x12: 3 mm Platte plus 9 mm
Gewinde waeren 1 mm mehr, als die Bohrung in der Saeule tief ist (8 mm).

Alle Schrauben schneiden sich selbst in den Kunststoff (Kernloch
2.7 mm).

## Mindestdicken

Damit im Betrieb nichts ausbricht, ist jede tragende Stelle auf ihr
duennstes Mass hin geprueft. Die kritische Groesse ist nicht die Wand,
sondern das Material, das einen Schraubenkopf haelt - gemessen an der
Geometrie, nicht aus den Parametern gerechnet:

| Stelle                            | vorher  | jetzt   |
|-----------------------------------|--------:|--------:|
| Wand, Deckel                      | 3.00 mm | 3.00 mm |
| Seitenplatten (blende, rechts)    | 2.60 mm | 3.00 mm |
| Boden                             | 3.00 mm | 5.00 mm |
| Material unter Kopfsenkung, Boden | 0.81 mm | 2.01 mm |
| Material am Schraubloch, Deckel   | 0.81 mm | 3.00 mm |
| Material am Schraubloch, Platten  | 0.41 mm | 3.00 mm |
| Wandung um ein M3-Gewinde, Dome   | 2.15 mm | 2.65 mm |
| Wandung um ein M3-Gewinde, Saeule | 2.15 mm | 3.15 mm |

Die Senkung sitzt nur noch **im Boden** - dort muss sie sein, damit das
Gehaeuse ohne Fuesse flach steht; deshalb ist der Boden 5 mm dick, so
dass unter der 3 mm tiefen Senkung noch `min_rest` = 2 mm stehen. In
Deckel und Seitenplatten gibt es keine Senkung mehr, dort tragen die
vollen 3 mm und die Zylinderkoepfe liegen auf.

Die Seitenplatten waren 2.6 statt 3.0 mm, weil `platte_luft` auch von
der Dicke abgezogen wurde. Luft braucht eine Platte aber nur in y und
z; x ist ihre Einschubrichtung, dort setzt sie buendig auf.

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
| Griffoeffnung im Deckel je Slot   | 16 x 34 mm, Griffweg 11 mm    |

Der Einfuehrtrichter sitzt auf den obersten 10 mm der Stege: dort weicht
der Steg in x um 0.8 mm nach aussen (der Kanal wird breiter) und zieht
sich in y auf 0.6 mm zurueck. Man muss die Kartenkante beim Einstecken
also nicht auf 3.0 mm genau treffen.

Der senkrechte Weg einer Karte aus dem Steckplatz heraus ist frei
geprueft - eine Karte laesst sich gerade nach oben herausziehen.

Zum Anfassen bleiben ueber der Kartenoberkante nur 8 mm. Deshalb hat
der Deckel ueber jedem Steckplatz eine GRIFFOEFFNUNG von 16 x 34 mm
(Nutzerentscheidung 2026-11-22). Durch sie greift man die
Kartenoberkante bei aufgesetztem Deckel, kann eine Karte niederdruecken
und sie zum Loesen anheben. Der Griffweg ist 11 mm tief (8 mm Luft plus
3 mm Deckel) und bis auf die Kartenoberkante frei geprueft; zwischen
zwei Oeffnungen bleiben bei 20.32 mm Steckplatz-Teilung 4.32 mm
Material stehen.

WAS DIE OEFFNUNG NICHT LEISTET: eine Karte ganz herausziehen, ohne den
Deckel abzunehmen. Durch die 34 mm lange Oeffnung passt eine 99.8 mm
lange Karte nicht hindurch, die Karte kann also nur um die 8 mm Luft
steigen, bis sie unter den Deckel stoesst. Ob das eine DIN-41612-
Paarung bereits trennt, haengt an deren Steckkontaktlaenge und ist
nicht geprueft (siehe TODO.txt Punkt 8). Zum Kartenwechsel bleibt es
beim Deckel abnehmen - vier Schrauben.

Die Luftschlitze des Deckels liegen dafuer jetzt in zwei Baendern vor
und hinter den Griffoeffnungen (y = 6..30.4 und 69.4..93.8). Vorher
standen sie alle 9 mm in einer Reihe quer ueber den Deckel; in
derselben y-Lage wie die Griffoeffnungen waere an mehreren Stellen
weniger als 1 mm Material stehen geblieben, weil die Steckplaetze alle
20.32 mm sitzen.

## STL-Dateien neu erzeugen

```bash
for t in boden wand_vorn wand_hinten blende wand_rechts deckel probe; do
    openscad -o "MECB_Gehaeuse_$t.stl" -D "teil=\"$t\"" MECB_Gehaeuse.scad
done
openscad -o MECB_Gehaeuse_platte.stl -D 'teil="platte"' MECB_Gehaeuse.scad
```

Von der Zusammenbau-Ansicht (`teil="alle"`) wird KEINE STL-Datei
erzeugt. Sie ist nur zum Ansehen in OpenSCAD (F5) gedacht; als Datei
neben den Druckteilen war sie eine Einladung, sie zu drucken. Wer sie
sehen will, oeffnet `MECB_Gehaeuse.scad` und laesst `teil` auf `alle`.

Unter Windows liegt das Programm als
`C:\Program Files\OpenSCAD\openscad.com` (Konsolenfassung; die
Nightly-Fassung in `OpenSCAD (Nightly)\`), unter
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

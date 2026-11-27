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
| MECB_Gehaeuse_boden.stl       | Bodenplatte 5 mm, Backplane-Dome, Sockel |
| MECB_Gehaeuse_wand.stl        | Laengswand mit Kartenfuehrung, 2x drucken|
| MECB_Gehaeuse_blende.stl      | linke Seite, Fenster fuer das Netzteil   |
| MECB_Gehaeuse_wand_rechts.stl | rechte Seite, Lueftung                   |
| MECB_Gehaeuse_deckel.stl      | Deckel mit Griffoeffnungen               |
| MECB_Gehaeuse_probe.stl       | Testteil: ein Fuehrungskanal und ein Dom |

Jedes Druckteil liegt in seiner STL-Datei schon in Drucklage: z = 0 ist
das Druckbett, x und y sind positiv.

## Symmetrie und Beschriftung

Der Innenraum liegt symmetrisch zur Backplane-Mitte (Nutzerwunsch
2026-11-27: Teile sollen sich vertauschen lassen). Links ist dafuer
derselbe Freiraum von 6 mm wie rechts, wo ihn die Winkelbuchse von
Slot 5 braucht; das Gehaeuse ist dadurch 5.4 mm laenger als vorher.
Daraus folgt:

- vordere und hintere Wand sind DASSELBE Teil (`wand`, zweimal
  drucken), die hintere ist die vordere um 180 Grad gedreht;
- der Deckel passt in beiden Lagen, die Griffoeffnungen liegen in
  beiden Lagen ueber den Karten;
- blende und wand_rechts haben dieselben Schraubloecher und passen
  auf beide Seiten (die Blende gehoert wegen des Netzteilfensters
  nach links);
- nur der Boden hat eine feste Lage: die Backplane-Loecher selbst sind
  nicht symmetrisch.

Jedes Teil traegt seinen Namen als 0.6 mm tiefe Gravur auf einer
Innenflaeche (Schrift 5 mm, Liberation Sans Bold): BODEN oben auf der
Bodenplatte, WAND 2x innen unter der Backplane-Hoehe, DECKEL auf der
Unterseite links, BLENDE LINKS und RECHTS innen unterhalb des Fensters
bzw. der Schlitze. Die Gravuren liegen so, dass sie von innen gelesen
richtig stehen. OpenSCAD braucht dafuer die Schrift Liberation Sans
(unter Ubuntu Paket `fonts-liberation`, unter Windows mit OpenSCAD
mitgeliefert).

## Abmessungen der Druckteile

| Teil        |     x |     y |    z | Hinweis zum Druck               |
|-------------|------:|------:|-----:|---------------------------------|
| boden       | 117.8 | 107.0 | 17.0 | flach, Dome nach oben           |
| wand (2x)   | 117.8 | 134.9 | 15.0 | liegt auf der Aussenflaeche     |
| blende      | 134.5 | 100.6 |  3.0 | liegt flach, Fenster unten      |
| wand_rechts | 134.5 | 100.6 |  3.0 | liegt flach                     |
| deckel      | 117.8 | 107.0 |  6.0 | Aussenseite unten, Kragen oben  |
| probe       |  44.0 |  14.0 | 40.0 | zuerst drucken                  |

Aussenmass des Gehaeuses: 117.8 x 107.0 x 142.9 mm. Groesster
Bettbedarf: 134.9 mm in einer Achse. Kein Teil braucht
Stuetzmaterial; alle Anbauteile (Stege, Saeulen, Dome) zeigen in
Drucklage nach oben.

## Mehrere Teile in einem Druck

Fertige Druckplatten mit mehreren Teilen liegen hier bewusst NICHT
(Nutzerentscheidung 2026-11-26). Das Anordnen auf dem Bett macht der
Slicer besser: alle gewuenschten STL-Dateien laden und automatisch
anordnen lassen - der Slicer kennt das eigene Bett, den
Reinigungsbereich und die Teile, die man gerade NICHT drucken will.

Auf ein Bett von 256 x 256 mm (Bambu Lab P2S) gehen die sieben Teile
ohnehin nicht in einem Durchgang: ihre Grundflaechen sind zusammen
82058 mm^2, das Bett hat 65536 mm^2 - das reicht auch bei lueckenlosem
Packen nicht. Jedes EINZELNE Teil passt dagegen bequem, das groesste
braucht 134.9 mm in einer Achse.

## Aufbau und Verschraubung

Die Laengswaende tragen die Gewinde fuer Deckel und Seitenplatten; der
Boden traegt vier Sockel, an die die Laengswaende WAAGRECHT von aussen
geschraubt werden. Die Waende haben unterhalb der Backplane nichts, was
nach innen ragt - sonst stiessen sie beim Aufsetzen an die schon
montierte Backplane (so war es bis 2026-11-27, siehe CHANGES.txt).

Alle Gehaeuseschrauben sind SENKKOPFSCHRAUBEN (90 Grad, DIN 965 /
ISO 7046 oder DIN 7991) und verschwinden in einer Kegelsenkung. Bei
Senkkopfschrauben zaehlt die Laenge MIT dem Kopf.

| Verbindung                | Schrauben          | Richtung                |
|---------------------------|--------------------|-------------------------|
| Backplane -> Boden        | 6x M3x8            | von oben, Kopf beliebig |
| Laengswand -> Boden       | 4x M3x10 Senkkopf  | waagrecht, vorn/hinten  |
| Deckel -> Laengswand      | 4x M3x12 Senkkopf  | von oben                |
| blende -> Laengswand      | 4x M3x10 Senkkopf  | von links               |
| wand_rechts -> Laengswand | 4x M3x10 Senkkopf  | von rechts              |

Die Seitenplatten brauchen M3x10, nicht M3x12: 3 mm Platte plus 9 mm
Gewinde waeren 1 mm mehr, als die Bohrung in der Saeule tief ist (8 mm).
Die Bodensockel sind 8 mm tief, eine M3x10 greift dort 7 mm.

Die Schraubloecher des Deckels liegen symmetrisch zur Gehaeusemitte
(8.5 mm von der linken und rechten, 6.5 mm von der vorderen und hinteren
Aussenkante): der Deckel passt auch um 180 Grad gedreht.

Alle Schrauben schneiden sich selbst in den Kunststoff (Kernloch
2.7 mm).

## Mindestdicken

Damit im Betrieb nichts ausbricht, ist jede tragende Stelle auf ihr
duennstes Mass hin geprueft. Die kritische Groesse ist nicht die Wand,
sondern das Material, das einen Schraubenkopf haelt - gemessen an der
Geometrie, nicht aus den Parametern gerechnet:

| Stelle                                 |    Mass |
|----------------------------------------|--------:|
| Wand, Deckel, Seitenplatten            | 3.00 mm |
| Boden                                  | 5.00 mm |
| Kegelsenkung, Tiefe                    | 1.50 mm |
| zylindrisches Loch unter der Senkung   | 1.50 mm |
| Material Senkung -> Plattenkante       | >= 1 mm |
| Wandung um ein M3-Gewinde, Dome        | 2.65 mm |
| Wandung um ein M3-Gewinde, Saeule      | 3.15 mm |
| Wandung um ein M3-Gewinde, Bodensockel | 3.15 mm |

Die Senkung ist ein 90-Grad-Kegel (oben 6.4 mm, unten 3.4 mm). Ein
Senkkopf liegt auf der ganzen Kegelflaeche auf; die fruehere Regel
"2 mm Material unter der Senkung" galt fuer die flache Senkung eines
Zylinderkopfs, unter der nur ein duenner Boden den Kopf haelt (dort
waren 0.41..0.81 mm gemessen worden). Bis 2026-11-27 hatten deshalb nur
der Boden eine (flache) Senkung und Deckel und Seitenplatten keine; auf
Nutzerwunsch sind jetzt alle Koepfe versenkt.

Die Seitenplatten-Schrauben sitzen 4.5 mm vom Innenmass (vorher 3.5):
dort endete eine Senkung 0.1 mm vor der Plattenkante. Die untere
Schraube sitzt bei z = 28 (vorher 20): bei z = 20 schnitt schon das
Loch der Blende in das Netzteilfenster.

Die Seitenplatten waren 2.6 statt 3.0 mm, weil `platte_luft` auch von
der Dicke abgezogen wurde. Luft braucht eine Platte aber nur in y und
z; x ist ihre Einschubrichtung, dort setzt sie buendig auf.

### Einordnung nach den gaengigen Konstruktionsregeln

Recherche 2026-11-26 (Quellen am Ende des Abschnitts). Die
veroeffentlichten Regeln fuer FDM-Gehaeuse nennen 2 mm als Minimum und
2 bis 3 mm als ueblichen Bereich; 3.2 mm (vier Perimeter bei 0.4-mm-
Duese) gelten als besser fuer ein Gehaeuse, das man staendig in die
Hand nimmt. Dieses Gehaeuse liegt damit am oberen Ende des ueblichen
Bereichs:

| Regel                                   | Vorgabe     | hier           |
|-----------------------------------------|-------------|----------------|
| Wandstaerke Gehaeuse, Minimum           | 2.0 mm      | 3.0 mm         |
| Wandstaerke, ueblicher Bereich          | 2.0..3.0 mm | 3.0 mm         |
| Wand bei staendiger Handhabung          | 3.2 mm      | 3.0 mm Deckel  |
| Material rund um ein Schraubloch        | >= 1x Loch  | 2.65..4.15 mm  |
| Gewindeeingriff selbstschneidend        | 2.0..2.5x d | 2.33..3.0x d   |
| Kernloch, Anteil am Nenndurchmesser     | 80..90 %    | 90 % (2.7 mm)  |
| Versteifungsrippe, Dicke                | 60..80 %    | 2 mm von 3 mm  |
| Versteifungsrippe, Hoehe                | <= 3x Wand  | <= 9 mm        |

Nicht erfuellt ist nur zweierlei, beides knapp: die Dome der
Backplane-Verschraubung haben 2.65 mm Material um das 2.7-mm-Kernloch
(die Regel will 2.7 mm, also 0.05 mm mehr - `dom_bp_d` von 8 auf
8.2 mm wuerde reichen), und der Deckel hat 3.0 statt 3.2 mm. Der
Deckel wird bei jedem Kartenwechsel abgenommen, traegt aber nichts; er
hat zusaetzlich einen 3 mm hohen Kragen rundum, der wie ein Flansch
wirkt.

Die duennste Stelle ist nicht die Wand, sondern die Flaeche: die
Seitenplatten sind 134.5 x 100.6 mm bei 3.0 mm und nur an vier Punkten
verschraubt. Als allseitig gelenkig gelagerte Platte gerechnet
(`D = E t^3 / (12 (1 - nu^2))`, nu = 0.35, Punktlast 20 N in der
Mitte) biegt sie sich 0.33 mm bei E = 3500 MPa bis 0.46 mm bei
E = 2500 MPa; die vier Punktauflagen sind weicher als eine
Linienauflage, real ist also etwa das Zwei- bis Dreifache zu erwarten.
Fuer einen Deckel ohne Tragfunktion reicht das. 4 statt 3 mm waeren
2.37-mal so steif (t^3), kosten aber 2 mm Aussenmass je Seite - erst
nach dem Druck entscheiden (TODO-Punkt 6).

Fuer den Slicer folgt daraus eine Einstellung: bei 0.4-mm-Duese
ergeben drei Perimeter je Seite 2.64 mm, in der Mitte der 3-mm-Wand
bleiben also 0.36 mm Fuellung. Mindestens VIER Perimeter einstellen,
dann ist die Wand durchgehend massiv.

Quellen: Hubs (Enclosure design for 3D printing), FacFox Enclosure
Design Guide, JC Fasteners "Plastite" Thread Forming Screws Technical
Guide, Core77 (Ribs and Gussets).

## Reihenfolge des Zusammenbaus

Die Reihenfolge ist nicht beliebig; sie folgt aus geprueften
Verschnitt-Tests (siehe CHANGES.txt):

1. **Backplane auf die Dome des Bodens schrauben** (6x M3x8). Das muss
   zuerst geschehen: zwei der sechs Schrauben (x = 3.81, y = 3.81 und
   y = 96.012) liegen danach halb unter den Saeulen der Laengswaende
   (Saeule bis x = 3.0), ein Schrauber kommt dort nicht mehr hin.
2. **Karten einstecken**, solange noch keine Wand steht.
3. **die beiden Waende** von oben aufsetzen und waagrecht von
   aussen in die Sockel des Bodens schrauben (je 2x M3x10 Senkkopf).
4. **blende und wand_rechts** anschrauben, **Deckel** zuletzt.

Die Backplane laesst sich nicht von oben durch den fertigen Rahmen
einsetzen - Fuehrungsstege und Saeulen versperren den Weg (gemessen:
19 695 mm3 im Einschubweg). Mit der vierteiligen Teilung ist das kein
Problem, weil die Waende zuletzt kommen - vorausgesetzt, sie tragen
unterhalb der Backplane nichts nach innen. Das ist seit 2026-11-27
geprueft (Verschnitt des Aufsetzwegs mit der Backplane: 0 mm3; der
Stand davor hatte 2018 mm3 Konflikt durch die Gewindedome der Waende).

## Kartenfuehrung - Masse der Passung

| Mass                                | Wert                         |
|-------------------------------------|------------------------------|
| Kanalbreite, Karte 1.6 mm           | 3.0 mm, also 0.7 mm je Seite |
| Kanalbreite oben (Einfuehrtrichter) | 4.6 mm                       |
| Fuehrungstiefe an der Kartenkante   | 1.6 mm je Seite              |
| Luft ueber der Kartenoberkante      | 8.0 mm, mit Deckel 5.0 mm    |
| Griffoeffnung im Deckel je Slot     | 16 x 34 mm, Griffweg 11 mm   |

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
for t in boden wand blende wand_rechts deckel probe; do
    openscad -o "MECB_Gehaeuse_$t.stl" -D "teil=\"$t\"" MECB_Gehaeuse.scad
done
```

Von der Zusammenbau-Ansicht (`teil="alle"`) wird KEINE STL-Datei
erzeugt. Sie ist nur zum Ansehen in OpenSCAD (F5) gedacht; als Datei
neben den Druckteilen war sie eine Einladung, sie zu drucken. Wer sie
sehen will, oeffnet `MECB_Gehaeuse.scad` und laesst `teil` auf `alle`.

Unter Windows liegt das Programm als
`C:\Program Files\OpenSCAD\openscad.com` (Konsolenfassung; eine
Nightly-Installation liegt in `OpenSCAD (Nightly)\`), unter Ubuntu
als `openscad`. Die Aufrufe laufen unter Cygwin/Git Bash ebenso
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

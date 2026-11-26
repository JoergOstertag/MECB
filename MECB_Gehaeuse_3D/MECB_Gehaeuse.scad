// =====================================================================
//  MECB-Gehaeuse  -  Minimalist Europe Card Bus (DigicoolThings)
//  Backplane liegt flach am Boden, die Karten stehen senkrecht darin.
//
//  Die Hardware-Masse unten sind AUS DEN GERBERN DES MECB-REPOSITORIES
//  GEMESSEN (Edge_Cuts und Bohrdateien), nicht geschaetzt:
//    - Karte und Backplane     99.822 x 99.822 mm, Eckradius 2.54 mm
//    - Steckplatz-Teilung      20.32 mm (0.8 Zoll), Slot-Mitten in x
//    - Backplane-Befestigung   6x M3, x = 3.81 / 49.911 / 90.17
//                                     y = 3.81 / 96.012
//  Ausnahme: STECKHOEHE und UEBERSTAND_SLOT5 stehen nicht in den
//  Gerbern - siehe Kommentar dort. VOR dem grossen Druck das Teil
//  "probe" drucken und beides am eigenen Aufbau nachmessen.
//
//  Nullpunkt des Modells: linke vordere Ecke der Backplane,
//  z = 0 ist die OBERSEITE der Backplane-Leiterplatte.
//
//  DER RAHMEN BESTEHT AUS VIER SEITENTEILEN (senkrechte Teilung an den
//  Ecken), damit kein Teil hoch gedruckt werden muss:
//    wand_vorn    - Laengswand mit Kartenfuehrung, liegend  112 x 135 x 15
//    wand_hinten  - dasselbe gespiegelt,           liegend  112 x 135 x 15
//    blende       - linke Seite, Fenster fuers Netzteil     135 x 101 x 3
//    wand_rechts  - rechte Seite, Lueftung                  135 x 101 x 3
//  Die beiden Laengswaende tragen alle Gewinde; Boden und Deckel
//  klammern sie, die beiden Seitenplatten ziehen sie zusammen.
//
//  Teile:  boden + wand_vorn + wand_hinten + blende + wand_rechts
//          + deckel   (+ probe zum Vorabtest)
//  Schrauben, alle selbstschneidend in den Kunststoff:
//    6x M3x8   Backplane auf die Dome des Bodens
//    4x M3x12  Boden an die Laengswaende, Kopf in der Senkung
//    4x M3x12  Deckel an die Laengswaende, Kopf liegt oben auf
//    4x M3x10  blende, 4x M3x10 wand_rechts, Kopf liegt aussen auf.
//              M3x12 waere hier 1 mm zu lang: 3 mm Platte plus 9 mm
//              Gewinde gegen eine nur 8 mm tiefe Bohrung in der Saeule.
//
//  MINDESTDICKEN (Nutzerauftrag 2026-11-22, damit nichts ausbricht):
//  Waende, Deckel und Seitenplatten 3 mm; der Boden 5 mm, weil nur er
//  eine Kopfsenkung hat und unter ihr min_rest = 2 mm stehen bleiben
//  muessen. Deckel und Seitenplatten haben deshalb keine Senkung mehr.
//  Die Wandung um ein selbstschneidendes M3-Gewinde ist mindestens
//  2.65 mm (Backplane-Dome 8 mm aussen, Saeulen 8 mm tief).
//
//  REIHENFOLGE DES ZUSAMMENBAUS (geprueft, nicht beliebig):
//    1. Backplane auf die Dome des Bodens schrauben (6x M3x8). Das MUSS
//       zuerst geschehen: zwei der sechs Schrauben liegen danach unter
//       den Saeulen der Laengswaende.
//    2. Karten einstecken, solange noch keine Wand steht.
//    3. wand_vorn und wand_hinten aufsetzen und am Boden verschrauben.
//    4. blende und wand_rechts anschrauben, Deckel zuletzt.
// =====================================================================

/* [Was erzeugt werden soll] */
// alle   = Zusammenbau-Ansicht, NUR zum Ansehen (davon wird keine
//          STL-Datei erzeugt - eine solche Datei wuerde jemand drucken)
// platte = alle sieben Druckteile nebeneinander in Drucklage, EIN
//          Druck - braucht aber 336 x 275 mm Bett (Grossformat)
// platte1..3 = dieselben Teile auf drei Platten, jede passt auf
//          256 x 256 mm (Bambu Lab P2S)
// sonst  = ein einzelnes Druckteil in Drucklage
teil = "alle";          // [alle, platte, platte1, platte2, platte3, boden, wand_vorn, wand_hinten, blende, wand_rechts, deckel, probe]
// Hardware in der Zusammenbau-Ansicht mitzeichnen
zeige_hardware = true;

/* [Hardware - gemessen, normalerweise nicht aendern] */
BP          = 99.822;   // Kantenlaenge Backplane und Karte
PCB_DICKE   = 1.6;
KARTE_H     = 99.822;   // fuer die 160-mm-Karte: 159.767 eintragen
SLOT_X      = [19.431, 39.751, 60.071, 80.391];  // Slot 1..4, Teilung 20.32
BP_LOCH_X   = [3.81, 49.911, 90.17];
BP_LOCH_Y   = [3.81, 96.012];

// Unterkante Karte ueber Backplane-Oberseite. DIN 41612 gibt fuer die
// Standard-Steckanordnung g = 12.4 .. 14.2 mm an (Harting-Katalog,
// "Standard fixing arrangement"); 13.5 ist die Mitte davon.
// => am eigenen Aufbau mit dem Messschieber pruefen und ggf. aendern.
STECKHOEHE  = 13.5;

// Die abgewinkelte Buchse von Slot 5 steht ueber die rechte Platinenkante
// hinaus (aus dem Foto MECB_Backplane_Assembled_v1.2.jpg auf ca. 4 mm
// geschaetzt, nicht gemessen) - hier mit Reserve.
UEBERSTAND_SLOT5 = 6.0;

/* [Gehaeuse] */
wand        = 3.0;      // Wandstaerke
luft        = 0.6;      // Luft um die Backplane (vorn, hinten, links)
dom_h       = 12.0;     // Hoehe der Abstandsdome unter der Backplane
// Der Boden ist dicker als die uebrigen Platten, weil nur in ihm eine
// Kopfsenkung sitzt: das Gehaeuse soll flach stehen, ohne Fuesse. Unter
// der Senkung muessen min_rest Millimeter stehen bleiben, sonst reisst
// die selbstschneidende M3 den Boden an der Schraube aus (gemessen am
// alten Stand: 0.81 mm Restmaterial im Boden, 0.41 mm in den
// Seitenplatten). Deckel und Seitenplatten haben KEINE Senkung mehr -
// dort tragen die vollen 3 mm, die Zylinderkoepfe liegen auf.
boden_d     = 5.0;
deckel_d    = 3.0;
kopffrei    = 8.0;      // Luft ueber der Kartenoberkante (Griffe, Stecker)
rund        = 3.0;      // Aussen-Eckradius

/* [Kartenfuehrung] */
kanal       = 3.0;      // lichte Kanalbreite (Karte 1.6 mm + Lot + Spiel)
steg_t      = 2.2;      // wie weit der Steg von der Wandinnenseite vorsteht
steg_b      = 2.5;      // Stegdicke in x
steg_z0     = 2.0;      // Stegunterkante ueber der Backplane-Oberseite
// Einfuehrtrichter am oberen Stegende: auf dieser Hoehe weicht der Steg
// in x nach aussen (der Kanal wird breiter) und zieht sich in y zurueck.
// Ohne die x-Erweiterung muss man die Kartenkante beim Einstecken auf
// 3.0 mm genau treffen; mit ihr sind es oben 3.0 + 2*0.8 = 4.6 mm.
trichter_z  = 10.0;
trichter_x  = 0.8;

/* [Schrauben und Oeffnungen] */
m3_kern     = 2.7;      // Kernloch, M3 schneidet sich selbst ein
m3_frei     = 3.4;
m3_kopf     = 6.4;      // Senkung fuer Zylinderkopf (nur im Boden)
min_rest    = 2.0;      // Mindestmaterial unter einer Kopfsenkung
platte_luft = 0.2;      // Luft der Seitenplatten in y und z (nicht in x)
blende_fenster_y = [4, 96];   // Fenster Netzteilseite, y von..bis
blende_fenster_z = [0, 22];   // ... z von..bis (USB-C, Hohlbuchse, Schalter)
slot5_schlitz = false;  // Schlitz in wand_rechts fuer die Winkelbuchse
deckel_art  = "luft";   // [luft, offen, zu]

/* [Griffoeffnungen im Deckel] */
// Ueber jedem Steckplatz eine Oeffnung, durch die man die
// Kartenoberkante fasst. Sie liegt kopffrei (8 mm) unter der
// Deckelunterseite, der Griffweg ist also 8 + deckel_d = 11 mm tief -
// deshalb muss die Oeffnung breit genug fuer zwei Finger sein.
// 16 mm bei 20.32 mm Steckplatz-Teilung lassen 4.3 mm Material stehen.
griff_x     = 16.0;     // Breite in x (Kartenrichtung)
griff_y     = 34.0;     // Laenge in y
griff_r     = 4.0;      // Eckradius der Oeffnung

$fn = 48;

// ---------------------------------------------------------------- Masse
x0 = -(luft + wand);
x1 = BP + UEBERSTAND_SLOT5 + wand;
y0 = -(luft + wand);
y1 = BP + luft + wand;
xi0 = x0 + wand;  xi1 = x1 - wand;
yi0 = y0 + wand;  yi1 = y1 - wand;

z_bo_top  = -(PCB_DICKE + dom_h);   // Oberseite Bodenplatte
z_bo_bot  = z_bo_top - boden_d;
z_top     = STECKHOEHE + KARTE_H + kopffrei;  // Oberkante Rahmen
z_karte_o = STECKHOEHE + KARTE_H;
steg_oben = z_top - 4;              // Platz fuer den Deckelkragen
kragen    = 3;                      // Deckelkragen, taucht in den Rahmen

// Schraubpunkte Boden -> Laengswaende: liegen zwischen den Steckerreihen
// und neben den Backplane-Domen (gegen die Bohrdatei der Backplane
// geprueft). dom_boden_d ist der Aussendurchmesser dieser Dome; der
// Positionierrand des Bodens wird an diesen Stellen ausgespart.
BODEN_SCHRAUBE = [[30, yi0 + 3], [70, yi0 + 3],
                  [30, yi1 - 3], [70, yi1 - 3]];
dom_boden_d = 10;
// Schraubpunkte Deckel -> Laengswaende. In x NICHT in die Ecke, sondern
// 3.5 mm (links) bzw. 6 mm (rechts) vom Innenmass weg: der Dom hat
// 11 mm Durchmesser und darf nicht in die Oeffnung einer Seitenplatte
// ragen. Links darf er naeher heran, dort ist die Wand ohnehin
// aufgeschnitten.
DECKEL_SCHRAUBE = [[xi0 + 3.5, yi0 + 3.5], [xi1 - 6, yi0 + 3.5],
                   [xi1 - 6, yi1 - 3.5], [xi0 + 3.5, yi1 - 3.5]];
dom_deckel_d = 11;
// Schraubpunkte Seitenplatte -> Laengswand (y, z); die Gewinde sitzen in
// den Saeulen an den Enden der beiden Fuehrungswaende. Gleiche Lage
// links (blende) und rechts (wand_rechts).
PLATTE_SCHRAUBE = [[yi0 + 3.5, 20], [yi1 - 3.5, 20],
                   [yi0 + 3.5, 95], [yi1 - 3.5, 95]];
dom_bp_d  = 8;          // Abstandsdome der Backplane, aussen
saeule_x  = 9;          // Laenge der Saeulen in x
saeule_y  = 8;          // Tiefe der Saeulen in y (Wandung ums Gewinde)
// Luftschlitze in den Fuehrungswaenden (x-Mitten zwischen den Kanaelen)
LUEFT_X = [12, 29.6, 49.9, 70.2, 92];
LUEFT_Y = [12 : 15 : 95];

// Luftschlitze im Deckel liegen in zwei Baendern VOR und HINTER den
// Griffoeffnungen. Die Schlitze des Deckels standen vorher alle 9 mm
// und die Steckplaetze alle 20.32 mm - in derselben y-Lage waere
// zwischen Schlitz und Griffoeffnung an mehreren Stellen weniger als
// 1 mm Material stehen geblieben. Getrennte y-Baender loesen das ohne
// Ruecksicht auf die x-Lage. 2.5 mm Luft zur Griffoeffnung.
griff_lueft_l   = 24.4;                 // Schlitzlaenge in y
GRIFF_LUEFT_Y   = [BP/2 - griff_y/2 - 2.5 - griff_lueft_l/2,
                   BP/2 + griff_y/2 + 2.5 + griff_lueft_l/2];

// Teilungsebene der Laengswaende: so weit reicht das tiefste Anbauteil
// einer Wand nach innen (Deckeldom: 3.5 + 11/2 = 9 mm). 12 mm laesst
// Luft und schneidet durch kein Bauteil.
wand_tief = 12;

// ------------------------------------------------------------- Hilfen 2D
module rrect(w, h, r) {
    translate([r, r]) offset(r = r) square([w - 2*r, h - 2*r]);
}
module p_aussen() translate([x0, y0]) rrect(x1 - x0, y1 - y0, rund);
module p_innen()  translate([xi0, yi0])
                      rrect(xi1 - xi0, yi1 - yi0, max(0.5, rund - wand));

// Senkrechter Langschlitz, Schnitt laeuft in y von ya ueber die Laenge yl
module schlitz_xz(xm, z1, z2, b, ya, yl) {
    translate([xm, ya + yl, 0]) rotate([90, 0, 0]) linear_extrude(yl)
        hull() { translate([0, z1 + b/2]) circle(d = b);
                 translate([0, z2 - b/2]) circle(d = b); }
}
// Senkrechter Langschlitz, Schnitt laeuft in x von xa ueber die Laenge xl
module schlitz_yz(ym, z1, z2, b, xa, xl) {
    translate([xa, ym, 0]) rotate([90, 0, 90]) linear_extrude(xl)
        hull() { translate([0, z1 + b/2]) circle(d = b);
                 translate([0, z2 - b/2]) circle(d = b); }
}
// Liegender Langschlitz (2D, fuer Deckel und Boden)
module schlitz_xy(xm, ym, l, b) {
    translate([xm, ym]) hull() {
        translate([0, -(l - b)/2]) circle(d = b);
        translate([0,  (l - b)/2]) circle(d = b);
    }
}
// Rechteckfenster in einer Wand mit Normale x (z1..z2 / ya..yb)
module fenster_x(z1, z2, ya, yb, r, xa, xl) {
    translate([xa, 0, 0]) rotate([0, 90, 0]) linear_extrude(xl)
        translate([-z2, ya]) rrect(z2 - z1, yb - ya, r);
}

// --------------------------------------------------------- Fuehrungssteg
// y_wand: Innenflaeche der Wand, dir: +1 = Steg ragt nach +y.
// Der Steg beginnt 0.8 mm INNERHALB der Wand, damit er sicher
// verschmilzt (sonst nur eine beruehrende Flaeche).
// xm1/xm2: Stegmitte unten/oben - oben weicht sie fuer den
// Einfuehrtrichter nach aussen.
module _steg_abschnitt(xm1, xm2, y_wand, dir, z1, p1, z2, p2) {
    hull() {
        translate([xm1 - steg_b/2,
                   dir > 0 ? y_wand - 0.8 : y_wand - p1, z1])
            cube([steg_b, max(p1, 0.01) + 0.8, 0.01]);
        translate([xm2 - steg_b/2,
                   dir > 0 ? y_wand - 0.8 : y_wand - p2, z2])
            cube([steg_b, max(p2, 0.01) + 0.8, 0.01]);
    }
}
// s = -1 / +1: auf welcher Seite der Kanalmitte der Steg sitzt. Der
// Trichter weicht in diese Richtung aus, der Kanal wird oben breiter.
module steg(xm, y_wand, dir, s) {
    _steg_abschnitt(xm, xm, y_wand, dir, steg_z0, 0.01,
                    steg_z0 + 2.2, steg_t);
    _steg_abschnitt(xm, xm, y_wand, dir, steg_z0 + 2.2, steg_t,
                    steg_oben - trichter_z, steg_t);
    _steg_abschnitt(xm, xm + s * trichter_x, y_wand, dir,
                    steg_oben - trichter_z, steg_t, steg_oben, 0.6);
}
module fuehrungen() {
    for (xc = SLOT_X) for (s = [-1, 1]) {
        xm = xc + s * (kanal + steg_b) / 2;
        steg(xm, yi0, +1, s);
        steg(xm, yi1, -1, s);
    }
}

// ------------------------------------------------------------------ Dome
module dom(x, y, z_unten, hoehe, d_aussen, d_loch, loch_tief) {
    translate([x, y, z_unten]) difference() {
        cylinder(d = d_aussen, h = hoehe);
        translate([0, 0, hoehe - loch_tief + 0.01])
            cylinder(d = d_loch, h = loch_tief);
    }
}
// Saeule am Ende einer Fuehrungswand, traegt die Gewinde einer
// Seitenplatte. Beginnt bei z = steg_z0 (ueber der Backplane) mit
// 45-Grad-Anlauf. x_von = linke Kante der Saeule.
module saeule(x_von, y_wand, dir) {
    y_a = dir > 0 ? y_wand - 0.8 : y_wand - saeule_y;
    hull() {
        translate([x_von, y_a, steg_z0]) cube([saeule_x, 0.81, 0.01]);
        translate([x_von, y_a, steg_z0 + saeule_y])
            cube([saeule_x, saeule_y + 0.8, 0.01]);
    }
    translate([x_von, y_a, steg_z0 + saeule_y])
        cube([saeule_x, saeule_y + 0.8, steg_oben - steg_z0 - saeule_y]);
}

// =================================================================== BODEN
module boden() {
    difference() {
        union() {
            translate([0, 0, z_bo_bot]) linear_extrude(boden_d) p_aussen();
            // Positionierrand innen (fuehrt die Waende). An den
            // Gewindedomen der Laengswaende ausgespart - ohne diese
            // Aussparung setzt der Rahmen 3 mm zu hoch auf (gemessener
            // Materialkonflikt von 206 mm3).
            translate([0, 0, z_bo_top]) linear_extrude(3) difference() {
                difference() { p_innen(); offset(r = -2) p_innen(); }
                for (p = BODEN_SCHRAUBE)
                    translate(p) circle(d = dom_boden_d + 0.8);
            }
            // Abstandsdome fuer die Backplane (M3 schneidet sich ein)
            for (x = BP_LOCH_X) for (y = BP_LOCH_Y)
                dom(x, y, z_bo_top, dom_h, dom_bp_d, m3_kern, 10);
        }
        // Durchgangsloecher Boden -> Laengswand, Senkung von unten
        for (p = BODEN_SCHRAUBE) {
            translate([p[0], p[1], z_bo_bot - 1])
                cylinder(d = m3_frei, h = boden_d + 2);
            translate([p[0], p[1], z_bo_bot - 0.01])
                cylinder(d = m3_kopf, h = boden_d - min_rest);
        }
        // Luftschlitze
        translate([0, 0, z_bo_bot - 1]) linear_extrude(boden_d + 2)
            for (x = [20 : 10 : 85]) schlitz_xy(x, BP/2, 56, 4);
    }
}

// ============================================ RAHMEN (zwei Laengswaende)
// rahmen_voll() ist der vollstaendige Rahmen OHNE die beiden
// Seitenplatten: zwei Laengswaende samt Ecken, links und rechts offen.
// Daraus schneiden wand_vorn() und wand_hinten() ihr Stueck heraus; so
// kann die Teilung nicht von der Zusammenbau-Ansicht abweichen.
module rahmen_voll() {
    difference() {
        union() {
            // umlaufende Wand
            translate([0, 0, z_bo_top]) linear_extrude(z_top - z_bo_top)
                difference() { p_aussen(); p_innen(); }
            fuehrungen();
            saeule(xi0, yi0, +1);                 // links vorn
            saeule(xi0, yi1, -1);                 // links hinten
            saeule(xi1 - saeule_x, yi0, +1);      // rechts vorn
            saeule(xi1 - saeule_x, yi1, -1);      // rechts hinten
            // Gewindedome fuer den Deckel (ragen 2 mm in die Waende)
            for (p = DECKEL_SCHRAUBE)
                dom(p[0], p[1], z_top - 14, 14, dom_deckel_d, m3_kern, 11);
            // Gewindedome fuer die Bodenplatte
            for (p = BODEN_SCHRAUBE)
                dom(p[0], p[1], z_bo_top, 9, dom_boden_d, m3_kern, 8);
        }
        // Oeffnung links (blende) und rechts (wand_rechts): die Wand
        // zwischen den Fuehrungswaenden heraus
        translate([x0 - 1, yi0, z_bo_top - 1])
            cube([wand + 1, yi1 - yi0, z_top - z_bo_top + 2]);
        translate([xi1, yi0, z_bo_top - 1])
            cube([wand + 1, yi1 - yi0, z_top - z_bo_top + 2]);
        // Gewinde fuer die Seitenplatten in die Saeulen
        for (p = PLATTE_SCHRAUBE) {
            translate([xi0 - 0.01, p[0], p[1]]) rotate([0, 90, 0])
                cylinder(d = m3_kern, h = 8);
            translate([xi1 + 0.01, p[0], p[1]]) rotate([0, -90, 0])
                cylinder(d = m3_kern, h = 8);
        }
        // Luftschlitze in den beiden Fuehrungswaenden
        for (x = LUEFT_X) for (zz = [[30, 60], [66, 96], [102, z_top - 8]]) {
            schlitz_xz(x, zz[0], zz[1], 3.5, y0 - 1, wand + 2);
            schlitz_xz(x, zz[0], zz[1], 3.5, yi1 - 1, wand + 2);
        }
    }
}
// Die beiden Druckteile: senkrechte Teilung an den Ecken.
module wand_vorn() {
    intersection() {
        rahmen_voll();
        translate([x0 - 1, y0 - 1, z_bo_top - 1])
            cube([x1 - x0 + 2, (yi0 + wand_tief) - (y0 - 1),
                  z_top - z_bo_top + 2]);
    }
}
module wand_hinten() {
    intersection() {
        rahmen_voll();
        translate([x0 - 1, yi1 - wand_tief, z_bo_top - 1])
            cube([x1 - x0 + 2, (y1 + 1) - (yi1 - wand_tief),
                  z_top - z_bo_top + 2]);
    }
}

// ======================================== SEITENPLATTEN (blende, rechts)
// seite = -1: links, mit Fenster fuer das Netzteil (die "Blende").
// seite = +1: rechts, nur Lueftung.
module seitenplatte(seite) {
    // Die Platte ist volle wand dick und liegt buendig in ihrer
    // Oeffnung. Luft braucht sie nur in y und z, nicht in x - x ist ihre
    // Einschubrichtung, dort setzt sie einfach auf. Vorher wurde
    // platte_luft auch von der DICKE abgezogen, die Platte war also nur
    // 2.6 statt 3.0 mm stark.
    // Keine Kopfsenkung: unter einer 2.2 mm tiefen Senkung blieben in
    // 2.6 mm Platte 0.41 mm stehen (gemessen) - daran reisst eine
    // selbstschneidende M3 aus. Die Zylinderkoepfe liegen jetzt aussen
    // auf, dafuer tragen die vollen 3 mm.
    xa = seite < 0 ? x0 : xi1;                   // Innenkante in x
    difference() {
        translate([xa, yi0 + platte_luft, z_bo_top + platte_luft])
            cube([wand,
                  (yi1 - yi0) - 2*platte_luft,
                  (z_top - z_bo_top) - 2*platte_luft]);
        // Fenster fuer USB-C, Hohlbuchse, Schraubklemme, LED, Schalter
        if (seite < 0)
            fenster_x(blende_fenster_z[0], blende_fenster_z[1],
                      blende_fenster_y[0], blende_fenster_y[1], 2,
                      xa - 1, wand + 2);
        // Durchgangsloecher, ohne Senkung
        for (p = PLATTE_SCHRAUBE)
            translate([xa - 1, p[0], p[1]]) rotate([0, 90, 0])
                cylinder(d = m3_frei, h = wand + 2);
        // Luftschlitze: links oberhalb des Fensters, rechts ueber die
        // ganze Hoehe
        for (y = LUEFT_Y)
            schlitz_yz(y, seite < 0 ? 35 : 30, z_top - 10, 3.5,
                       xa - 1, wand + 2);
        // optionaler Schlitz fuer eine Karte in der Winkelbuchse (Slot 5)
        if (seite > 0 && slot5_schlitz)
            translate([xa - 1, 2, STECKHOEHE - 3])
                cube([wand + 2, BP - 4, 12]);
    }
}
module blende()      seitenplatte(-1);
module wand_rechts() seitenplatte(+1);

// ================================================================== DECKEL
module deckel() {
    difference() {
        union() {
            translate([0, 0, z_top]) linear_extrude(deckel_d) p_aussen();
            // Kragen, taucht in den Rahmen ein und zentriert die Platte
            difference() {
                translate([0, 0, z_top - kragen]) linear_extrude(kragen)
                    difference() { offset(r = -0.3) p_innen();
                                   offset(r = -2.3) p_innen(); }
                // Platz fuer die Gewindedome der Laengswaende
                for (p = DECKEL_SCHRAUBE)
                    translate([p[0], p[1], z_top - kragen - 1])
                        cylinder(d = dom_deckel_d + 2, h = kragen + 2);
            }
        }
        // Durchgangsloecher ohne Kopfsenkung: die vollen deckel_d
        // tragen, die Zylinderkoepfe liegen oben auf. Mit Senkung
        // blieben darunter nur 0.81 mm stehen (gemessen).
        for (p = DECKEL_SCHRAUBE)
            translate([p[0], p[1], z_top - 1])
                cylinder(d = m3_frei, h = deckel_d + 2);
        if (deckel_art == "luft")
            translate([0, 0, z_top - kragen - 1])
                linear_extrude(deckel_d + kragen + 2) {
                    // Griffoeffnung ueber jedem Steckplatz
                    for (xc = SLOT_X)
                        translate([xc - griff_x/2, BP/2 - griff_y/2])
                            rrect(griff_x, griff_y, griff_r);
                    // Luftschlitze in den Baendern vor und hinter den
                    // Griffoeffnungen
                    for (x = [12 : 9 : 96]) for (ym = GRIFF_LUEFT_Y)
                        schlitz_xy(x, ym, griff_lueft_l, 4);
                }
        if (deckel_art == "offen")
            translate([0, 0, z_top - kragen - 1])
                linear_extrude(deckel_d + kragen + 2)
                    offset(r = -10) p_innen();
    }
}

// =================================================================== PROBE
// Testteil: ein Fuehrungskanal mit Einfuehrtrichter und ein Dom wie im
// Boden. Erst drucken, Kartenkante und M3 pruefen, dann die grossen
// Teile starten.
module probe() {
    union() {
        cube([30, wand, 40]);                       // Wandstueck
        translate([0, wand, 0])
            for (s = [-1, 1]) {
                xm = 15 + s * (kanal + steg_b) / 2;
                _steg_abschnitt(xm, xm, 0, +1, 2, 0.01, 4.2, steg_t);
                _steg_abschnitt(xm, xm, 0, +1, 4.2, steg_t, 30, steg_t);
                _steg_abschnitt(xm, xm + s * trichter_x, 0, +1,
                                30, steg_t, 40, 0.6);
            }
        translate([30, 0, 0]) cube([14, 14, 4]);    // Sockel
        translate([37, 7, 4]) difference() {        // Dom wie im Boden
            cylinder(d = dom_bp_d, h = 12);
            translate([0, 0, 2]) cylinder(d = m3_kern, h = 10.1);
        }
    }
}

// =============================================================== Hardware
module backplane_dummy() {
    color("navy", 0.75) difference() {
        translate([0, 0, -PCB_DICKE]) linear_extrude(PCB_DICKE)
            rrect(BP, BP, 2.54);
        for (x = BP_LOCH_X) for (y = BP_LOCH_Y)
            translate([x, y, -PCB_DICKE - 1]) cylinder(d = 3.2, h = 4);
    }
    // Buchsenkoerper (94 mm lang, in y mittig) nur zur Lagekontrolle
    for (xc = SLOT_X)
        color("khaki", 0.8) translate([xc - 5, (BP - 94)/2, 0])
            cube([10, 94, 11]);
}
module karte_dummy(xc) {
    color("green", 0.6)
        translate([xc - PCB_DICKE/2, 0, STECKHOEHE])
            cube([PCB_DICKE, BP, KARTE_H]);
}

// ============================================================ Zusammenbau
module assembly() {
    color("gainsboro")      boden();
    color("silver")         wand_vorn();
    color("silver")         wand_hinten();
    color("lightsteelblue") blende();
    color("lightsteelblue") wand_rechts();
    color("gainsboro")      deckel();
    if (zeige_hardware) {
        backplane_dummy();
        for (xc = SLOT_X) karte_dummy(xc);
    }
}

// =============================================================== Ausgabe
// Die Druckteile werden so gelegt, dass sie mit z = 0 auf dem Druckbett
// aufliegen und vollstaendig im positiven x/y-Bereich stehen (sonst legen
// Slicer das Teil unter oder neben das Bett). Die beiden Laengswaende
// liegen auf ihrer Aussenflaeche, die Seitenplatten auf ihrer Rueckseite.
// platte_luft gehoert NICHT in die z-Verschiebung der Seitenplatten: es
// ist die Luft in ihrer Oeffnung, nicht unter ihnen. Mit ihr lagen
// blende und wand_rechts 0.2 mm UNTER dem Druckbett (z = -0.2 .. 2.8).
module druck_boden()  { translate([-x0, -y0, -z_bo_bot]) boden(); }
module druck_wand_vorn() {
    translate([-x0, z_top, -y0]) rotate([90, 0, 0]) wand_vorn();
}
module druck_wand_hinten() {
    translate([-x0, -z_bo_top, y1]) rotate([-90, 0, 0]) wand_hinten();
}
module druck_blende() {
    translate([-(z_bo_top + platte_luft), -(yi0 + platte_luft),
               x0 + wand])
        rotate([0, 90, 0]) blende();
}
module druck_wand_rechts() {
    translate([z_top - platte_luft, -(yi0 + platte_luft),
               -xi1])
        rotate([0, -90, 0]) wand_rechts();
}
module druck_deckel() {
    translate([-x0, y1, z_top + deckel_d]) rotate([180, 0, 0]) deckel();
}

// ---------------------------------------------------------- Druckplatten
// Alle sieben Druckteile in EINEM Modell, jedes in seiner Drucklage,
// nebeneinander auf dem Bett. Die Grundflaechen stehen hier als Masse,
// weil OpenSCAD die Huelle eines Teils nicht abfragen kann - sie sind
// aus denselben Variablen gerechnet wie die Teile selbst, nicht geraten.
fp_wand_x   = x1 - x0;                             // boden, deckel, Waende
fp_bd_y     = y1 - y0;                             // boden, deckel
fp_wand_y   = z_top - z_bo_top;                    // Laengswaende
fp_platte_x = z_top - z_bo_top - 2 * platte_luft;  // Seitenplatten
fp_platte_y = yi1 - yi0 - 2 * platte_luft;
fp_probe_x  = 44;   // aus probe(): Wandstueck 30 + Sockel 14
fp_probe_y  = 14;

// Drei Spalten: links die vordere Wand mit Boden und Probe, in der Mitte
// die hintere Wand mit Deckel, rechts die beiden Seitenplatten um 90 Grad
// gedreht (so wird die Platte schmaler als mit ihrer langen Kante in x).
platte_abstand = 5;    // Abstand zwischen den Teilen auf dem Bett
pl_sp2 = fp_wand_x + platte_abstand;        // x-Anfang Spalte 2
pl_sp3 = 2 * (fp_wand_x + platte_abstand);  // x-Anfang Spalte 3
pl_re2 = fp_wand_y + platte_abstand;        // y-Anfang Reihe 2, Spalte 1+2
pl_re3 = pl_re2 + fp_bd_y + platte_abstand; // y-Anfang Reihe 3, Spalte 1
pl_pl2 = fp_platte_x + platte_abstand;      // y-Anfang Reihe 2, Spalte 3
platte_x = pl_sp3 + fp_platte_y;
platte_y = max(pl_re3 + fp_probe_y, pl_pl2 + fp_platte_x);

module druckplatte() {
    druck_wand_vorn();
    translate([0, pl_re2, 0]) druck_boden();
    translate([0, pl_re3, 0]) probe();

    translate([pl_sp2, 0, 0])      druck_wand_hinten();
    translate([pl_sp2, pl_re2, 0]) druck_deckel();

    translate([pl_sp3 + fp_platte_y, 0, 0])
        rotate([0, 0, 90]) druck_blende();
    translate([pl_sp3 + fp_platte_y, pl_pl2, 0])
        rotate([0, 0, 90]) druck_wand_rechts();

    echo(str("Druckplatte braucht ", platte_x, " x ", platte_y, " mm Bett"));
}

// Dieselben Teile fuer ein Bett von 256 x 256 mm (Bambu Lab P2S,
// Nutzervorgabe 2026-11-26). In EINEN Druck passen sie dort nicht: die
// Grundflaechen sind zusammen 82058 mm^2, ein Bett hat 65536 mm^2.
// Deshalb drei Platten, nach Bauhoehe gruppiert - so hat jede Platte
// eine einheitliche Hoehe und laesst sich eigen einstellen.
//   platte1  die beiden Laengswaende            229.8 x 134.9 x 15
//   platte2  boden, deckel und probe            229.8 x 126.0 x 40
//   platte3  die beiden Seitenplatten           134.5 x 206.2 x  3
p1_x = 2 * fp_wand_x + platte_abstand;
p1_y = fp_wand_y;
p2_x = 2 * fp_wand_x + platte_abstand;
p2_y = fp_bd_y + platte_abstand + fp_probe_y;
p3_x = fp_platte_x;
p3_y = 2 * fp_platte_y + platte_abstand;

module druckplatte1() {
    druck_wand_vorn();
    translate([fp_wand_x + platte_abstand, 0, 0]) druck_wand_hinten();
    echo(str("platte1 braucht ", p1_x, " x ", p1_y, " mm Bett"));
}
module druckplatte2() {
    druck_boden();
    translate([fp_wand_x + platte_abstand, 0, 0]) druck_deckel();
    translate([0, fp_bd_y + platte_abstand, 0]) probe();
    echo(str("platte2 braucht ", p2_x, " x ", p2_y, " mm Bett"));
}
module druckplatte3() {
    druck_blende();
    translate([0, fp_platte_y + platte_abstand, 0]) druck_wand_rechts();
    echo(str("platte3 braucht ", p3_x, " x ", p3_y, " mm Bett"));
}

if (teil == "alle")             assembly();
else if (teil == "platte")      druckplatte();
else if (teil == "platte1")     druckplatte1();
else if (teil == "platte2")     druckplatte2();
else if (teil == "platte3")     druckplatte3();
else if (teil == "boden")       druck_boden();
else if (teil == "wand_vorn")   druck_wand_vorn();
else if (teil == "wand_hinten") druck_wand_hinten();
else if (teil == "blende")      druck_blende();
else if (teil == "wand_rechts") druck_wand_rechts();
else if (teil == "deckel")      druck_deckel();
else if (teil == "probe")       probe();

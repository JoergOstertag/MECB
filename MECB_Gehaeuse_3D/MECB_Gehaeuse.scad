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
//  Teile:  boden + rahmen + blende + deckel   (+ probe zum Vorabtest)
//  Schrauben: 6x M3x8 (Backplane), 4x M3x12 (Boden), 4x M3x12 (Deckel),
//             4x M3x12 (Blende) - alle selbstschneidend in den Kunststoff.
// =====================================================================

/* [Was erzeugt werden soll] */
// alle = Zusammenbau-Ansicht, sonst ein Druckteil in Drucklage
teil = "alle";          // [alle, boden, rahmen, blende, deckel, probe]
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
boden_d     = 3.0;
deckel_d    = 3.0;
kopffrei    = 8.0;      // Luft ueber der Kartenoberkante (Griffe, Stecker)
rund        = 3.0;      // Aussen-Eckradius

/* [Kartenfuehrung] */
kanal       = 3.0;      // lichte Kanalbreite (Karte 1.6 mm + Lot + Spiel)
steg_t      = 2.2;      // wie weit der Steg von der Wandinnenseite vorsteht
steg_b      = 2.5;      // Stegdicke in x
steg_z0     = 2.0;      // Stegunterkante ueber der Backplane-Oberseite

/* [Schrauben und Oeffnungen] */
m3_kern     = 2.7;      // Kernloch, M3 schneidet sich selbst ein
m3_frei     = 3.4;
m3_kopf     = 6.4;      // Senkung fuer Zylinderkopf
blende_fenster_y = [4, 96];   // Fenster Netzteilseite, y von..bis
blende_fenster_z = [0, 22];   // ... z von..bis (USB-C, Hohlbuchse, Schalter)
slot5_schlitz = false;  // Schlitz in der rechten Wand fuer die Winkelbuchse
deckel_art  = "luft";   // [luft, offen, zu]

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

// Schraubpunkte Boden -> Rahmen: liegen zwischen den Steckerreihen und
// neben den Backplane-Domen (gegen die Bohrdatei der Backplane geprueft)
BODEN_SCHRAUBE = [[30, yi0 + 3], [70, yi0 + 3],
                  [30, yi1 - 3], [70, yi1 - 3]];
// Schraubpunkte Deckel -> Rahmen (die vier Innenecken)
DECKEL_SCHRAUBE = [[xi0 + 3.5, yi0 + 3.5], [xi1 - 3.5, yi0 + 3.5],
                   [xi1 - 3.5, yi1 - 3.5], [xi0 + 3.5, yi1 - 3.5]];
// Schraubpunkte Blende -> Rahmen (y, z); die Gewinde sitzen in den
// Saeulen an den offenen Enden der beiden Fuehrungswaende.
BLENDE_SCHRAUBE = [[yi0 + 3.5, 20], [yi1 - 3.5, 20],
                   [yi0 + 3.5, 95], [yi1 - 3.5, 95]];
saeule_x  = 9;          // Laenge der Blendensaeulen in x
saeule_y  = 7;          // Tiefe der Blendensaeulen in y
// Luftschlitze in den Fuehrungswaenden (x-Mitten zwischen den Kanaelen)
LUEFT_X = [12, 29.6, 49.9, 70.2, 92];
LUEFT_Y = [12 : 15 : 95];

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
module _steg_abschnitt(xm, y_wand, dir, z1, p1, z2, p2) {
    hull() {
        translate([xm - steg_b/2,
                   dir > 0 ? y_wand - 0.8 : y_wand - p1, z1])
            cube([steg_b, max(p1, 0.01) + 0.8, 0.01]);
        translate([xm - steg_b/2,
                   dir > 0 ? y_wand - 0.8 : y_wand - p2, z2])
            cube([steg_b, max(p2, 0.01) + 0.8, 0.01]);
    }
}
module steg(xm, y_wand, dir) {
    _steg_abschnitt(xm, y_wand, dir, steg_z0, 0.01, steg_z0 + 2.2, steg_t);
    _steg_abschnitt(xm, y_wand, dir, steg_z0 + 2.2, steg_t,
                    steg_oben - 8, steg_t);
    _steg_abschnitt(xm, y_wand, dir, steg_oben - 8, steg_t,
                    steg_oben, 0.6);   // Einfuehrtrichter oben
}
module fuehrungen() {
    for (xc = SLOT_X) for (s = [-1, 1]) {
        xm = xc + s * (kanal + steg_b) / 2;
        steg(xm, yi0, +1);
        steg(xm, yi1, -1);
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
// Saeule am offenen Ende einer Fuehrungswand, traegt die Blendengewinde.
// Beginnt bei z = steg_z0 (ueber der Backplane) mit 45-Grad-Anlauf.
module blendensaeule(y_wand, dir) {
    y_a = dir > 0 ? y_wand - 0.8 : y_wand - saeule_y;
    hull() {
        translate([xi0, y_a, steg_z0]) cube([saeule_x, 0.81, 0.01]);
        translate([xi0, y_a, steg_z0 + saeule_y])
            cube([saeule_x, saeule_y + 0.8, 0.01]);
    }
    translate([xi0, y_a, steg_z0 + saeule_y])
        cube([saeule_x, saeule_y + 0.8, steg_oben - steg_z0 - saeule_y]);
}

// =================================================================== BODEN
module boden() {
    difference() {
        union() {
            translate([0, 0, z_bo_bot]) linear_extrude(boden_d) p_aussen();
            // Positionierrand innen (fuehrt Rahmen und Blende)
            translate([0, 0, z_bo_top]) linear_extrude(3)
                difference() { p_innen(); offset(r = -2) p_innen(); }
            // Abstandsdome fuer die Backplane (M3 schneidet sich ein)
            for (x = BP_LOCH_X) for (y = BP_LOCH_Y)
                dom(x, y, z_bo_top, dom_h, 7, m3_kern, 10);
        }
        // Durchgangsloecher Boden -> Rahmen, Senkung von unten
        for (p = BODEN_SCHRAUBE) {
            translate([p[0], p[1], z_bo_bot - 1])
                cylinder(d = m3_frei, h = boden_d + 2);
            translate([p[0], p[1], z_bo_bot - 0.01])
                cylinder(d = m3_kopf, h = 2.2);
        }
        // Luftschlitze
        translate([0, 0, z_bo_bot - 1]) linear_extrude(boden_d + 2)
            for (x = [20 : 10 : 85]) schlitz_xy(x, BP/2, 56, 4);
    }
}

// ================================================================== RAHMEN
module rahmen() {
    difference() {
        union() {
            // umlaufende Wand
            translate([0, 0, z_bo_top]) linear_extrude(z_top - z_bo_top)
                difference() { p_aussen(); p_innen(); }
            fuehrungen();
            blendensaeule(yi0, +1);
            blendensaeule(yi1, -1);
            // Gewindedome fuer den Deckel (ragen 2 mm in die Waende)
            for (p = DECKEL_SCHRAUBE)
                dom(p[0], p[1], z_top - 14, 14, 11, m3_kern, 11);
            // Gewindedome fuer die Bodenplatte
            for (p = BODEN_SCHRAUBE)
                dom(p[0], p[1], z_bo_top, 9, 10, m3_kern, 8);
        }
        // Blendenoeffnung: linke Wand zwischen den Fuehrungswaenden heraus
        translate([x0 - 1, yi0, z_bo_top - 1])
            cube([wand + 1, yi1 - yi0, z_top - z_bo_top + 2]);
        // Gewinde fuer die Blende in die Saeulen
        for (p = BLENDE_SCHRAUBE)
            translate([xi0 - 0.01, p[0], p[1]]) rotate([0, 90, 0])
                cylinder(d = m3_kern, h = 8);
        // Luftschlitze in den beiden Fuehrungswaenden
        for (x = LUEFT_X) for (zz = [[30, 60], [66, 96], [102, z_top - 8]]) {
            schlitz_xz(x, zz[0], zz[1], 3.5, y0 - 1, wand + 2);
            schlitz_xz(x, zz[0], zz[1], 3.5, yi1 - 1, wand + 2);
        }
        // Luftschlitze in der rechten Wand
        for (y = LUEFT_Y)
            schlitz_yz(y, 30, z_top - 8, 3.5, xi1 - 1, wand + 2);
        // optionaler Schlitz fuer eine Karte in der Winkelbuchse (Slot 5)
        if (slot5_schlitz)
            translate([xi1 - 1, 2, STECKHOEHE - 3])
                cube([wand + 2, BP - 4, 12]);
    }
}

// ================================================================== BLENDE
module blende() {
    difference() {
        translate([x0 + 0.2, yi0 + 0.2, z_bo_top + 0.2])
            cube([wand - 0.4, (yi1 - yi0) - 0.4, (z_top - z_bo_top) - 0.4]);
        // Fenster fuer USB-C, Hohlbuchse, Schraubklemme, LED, Schalter
        fenster_x(blende_fenster_z[0], blende_fenster_z[1],
                  blende_fenster_y[0], blende_fenster_y[1], 2,
                  x0 - 1, wand + 2);
        // Schraubloecher mit Senkung von aussen
        for (p = BLENDE_SCHRAUBE) {
            translate([x0 - 1, p[0], p[1]]) rotate([0, 90, 0])
                cylinder(d = m3_frei, h = wand + 2);
            translate([x0 - 0.01, p[0], p[1]]) rotate([0, 90, 0])
                cylinder(d = m3_kopf, h = 2.2);
        }
        // Luftschlitze oberhalb des Fensters
        for (y = LUEFT_Y)
            schlitz_yz(y, 35, z_top - 10, 3.5, x0 - 1, wand + 2);
    }
}

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
                // Platz fuer die Gewindedome des Rahmens
                for (p = DECKEL_SCHRAUBE)
                    translate([p[0], p[1], z_top - kragen - 1])
                        cylinder(d = 13, h = kragen + 2);
            }
        }
        for (p = DECKEL_SCHRAUBE) {
            translate([p[0], p[1], z_top - 1])
                cylinder(d = m3_frei, h = deckel_d + 2);
            translate([p[0], p[1], z_top + deckel_d - 2.2 + 0.01])
                cylinder(d = m3_kopf, h = 2.3);
        }
        if (deckel_art == "luft")
            translate([0, 0, z_top - kragen - 1])
                linear_extrude(deckel_d + kragen + 2)
                    for (x = [12 : 9 : 100]) schlitz_xy(x, BP/2, 70, 4);
        if (deckel_art == "offen")
            translate([0, 0, z_top - kragen - 1])
                linear_extrude(deckel_d + kragen + 2)
                    offset(r = -10) p_innen();
    }
}

// =================================================================== PROBE
// Testteil: ein Fuehrungskanal und ein Dom wie im Boden. Erst drucken,
// Kartenkante und M3 pruefen, dann die grossen Teile starten.
module probe() {
    union() {
        cube([30, wand, 40]);                       // Wandstueck
        translate([0, wand, 0])
            for (s = [-1, 1]) {
                xm = 15 + s * (kanal + steg_b) / 2;
                _steg_abschnitt(xm, 0, +1, 2, 0.01, 4.2, steg_t);
                _steg_abschnitt(xm, 0, +1, 4.2, steg_t, 32, steg_t);
                _steg_abschnitt(xm, 0, +1, 32, steg_t, 40, 0.6);
            }
        translate([30, 0, 0]) cube([14, 14, 4]);    // Sockel
        translate([37, 7, 4]) difference() {        // Dom wie im Boden
            cylinder(d = 7, h = 12);
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
    color("silver")         rahmen();
    color("lightsteelblue") blende();
    color("gainsboro")      deckel();
    if (zeige_hardware) {
        backplane_dummy();
        for (xc = SLOT_X) karte_dummy(xc);
    }
}

// =============================================================== Ausgabe
// Die Druckteile werden so gelegt, dass sie mit z = 0 auf dem Druckbett
// aufliegen und vollstaendig im positiven x/y-Bereich stehen (sonst legen
// Slicer das Teil unter oder neben das Bett).
if (teil == "alle")        assembly();
else if (teil == "boden")  translate([-x0, -y0, -z_bo_bot]) boden();
else if (teil == "rahmen") translate([-x0, -y0, -z_bo_top]) rahmen();
// Blende flach auf die Rueckseite: x' = z, z' = -x
else if (teil == "blende") translate([-(z_bo_top + 0.2), -(yi0 + 0.2), x0 + wand - 0.2])
                               rotate([0, 90, 0]) blende();
// Deckel auf die Aussenseite, der Kragen zeigt nach oben
else if (teil == "deckel") translate([-x0, y1, z_top + deckel_d])
                               rotate([180, 0, 0]) deckel();
else if (teil == "probe")  probe();

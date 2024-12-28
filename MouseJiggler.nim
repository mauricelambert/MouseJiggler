#    This mouse jiggler generates mouse and keyboard events to simulate user activity
#    Copyright (C) 2024  Maurice Lambert

#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.

#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.

#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.

# To compile on windows with nim 2.0.8:
# nim --app:gui c --stackTrace:off  --lineTrace:off --checks:off --assertions:off -d:release -d=mingw --opt:size --passl:"-s" MouseJiggler.nim

import winim/lean, unicode, random, os

proc getScreenBounds(): (int32, int32) =
  let screenWidth = GetSystemMetrics(SM_CXSCREEN)
  let screenHeight = GetSystemMetrics(SM_CYSCREEN)
  (screenWidth, screenHeight)

let (screenWidth, screenHeight) = getScreenBounds()
var originalPos: POINT
let words = @["suspicionful", "myzostomidae", "dirties", "immechanically", "nondynastic", "peritricha", "flowe", "unspeakably", "squeeze", "hedgesmith", "marennin", "rehypothecation", "ninths", "quiddities", "telar", "yerk", "baconweed", "contango", "sidewheel", "unagitatedness", "blastocele", "almight", "bonetta", "lappilli", "thirled", "soothing", "stelai", "hydrogenating", "gravipause", "bayadere", "dartle", "cephalometric", "luteotrophic", "hastier", "cleavers", "pseudonitrole", "fatalist", "epidemiologic", "presettable", "mournfuller", "ancony", "inauthoritative", "demiliterate", "hierurgies", "inspectional", "halituosity", "schoolboydom", "botein", "eventfulness", "estivage", "overeagerness", "cytopharynx", "inadvisable", "limberness", "hepatomegaly", "soubises", "clarabella", "more", "crossly", "experimentor", "prenticing", "resettles", "otolitic", "pamphlets", "overpopular", "pastural", "gigartinales", "intravertebral", "conopid", "climatotherapy", "arachnoidean", "talpiform", "spareable", "quinqueserial", "submaxillae", "reemphasized", "bouchee", "reiteration", "overhelpful", "retroserrate", "beknighted", "numenius", "knackish", "violones", "asymmetranthous", "clamorously", "housefurnishings", "restarted", "yacking", "unpaving", "humphrey", "indictably", "granage", "mammoth", "enwheeling", "nitritoid", "epichondrosis", "tamaricaceous", "edicts", "foresail", "induces", "waldensian", "ashiver", "squelched", "exurge", "reunites", "argilloarenaceous", "pectinibranchiata", "mastoccipital", "sizzlers", "agribusiness", "foretaste", "crave", "scytonematous", "shunpiking", "polyodont", "eloining", "spectate", "phytosaurian", "frutage", "remarch", "zygaenidae", "strychnic", "midshipmite", "thallus", "boehmeria", "procellarian", "nonpolarizing", "operculiform", "circumferent", "pseudolabium", "gabardines", "tilestone", "subeth", "fierabras", "unwoeful", "balladwise", "revamping", "unitistic", "paynimrie", "unadduced", "engle", "dargue", "evoe", "underdriven", "corrive", "quaich", "tidi", "inauspicate", "hydrostatic", "misprinting", "alkyds", "raconteurs", "geminous", "serin", "nutating", "unrepose", "episepalous", "meritory", "proplastid", "nonastronomical", "metered", "democracy", "unfarsighted", "ungroomed", "jipijapas", "wafer", "pint", "unopulence", "fetichize", "mechanotherapeutics", "girouette", "inwritten", "rhetorical", "suasion", "lodger", "ocypodidae", "oxyberberine", "isopleth", "breadthriders", "mauritian", "osteodystrophy", "sportingly", "sirenians", "overpessimistically", "axioms", "bescramble", "clerihew", "nonacutely", "misenunciation", "semiconical", "novelesque", "severation", "limelike", "jatoba", "unseduce", "trantlum", "anorexy", "experimentalism", "nonpropagandist", "overcausticity", "miserly", "svarabhaktic", "dormantly", "corneule", "subgelatinous", "unbreezy", "fingernails", "clubhauling", "endoprocta", "relatedness", "tiniest", "telotrematous", "weisbachite", "deammonation", "semiplumaceous", "woodies", "brekkle", "disgruntlement", "myzostoma", "lidderon", "manequin", "unhallooed", "horripilation", "maculacy", "emeries", "calzoneras", "miniard", "andoroba", "teleobjective", "brome", "needlers", "nonmunicipal", "postfixal", "vanellus", "mylohyoideus", "garrison", "chairmending", "hypophysectomy", "thymin", "axon", "alibies", "chordamesodermal", "footful", "buninahua", "dunlins", "twp", "typewrite", "valkyries", "reweds", "phenomenalist", "phenacaine", "coelenteron", "uncheerfulness", "monobrominated", "theowman", "antifascism", "populus", "thislike", "bottoming", "avicularium", "diadrome", "nitons", "desmopathology", "crabbedness", "fingall", "supercilious", "notist", "infects", "sikinnis", "laureling", "frislet", "huntsmen", "transmaking", "cuter", "killig", "schimmel", "anni", "condititivia", "phyleses", "redecorator", "daphnite", "adoratory", "dichotomization", "inspirited", "putted", "ceroon", "cookee", "cuterebra", "thwacked", "trills", "champagneless", "aestivated", "neostigmine", "pneumograph", "schuit", "laboress", "besetters", "nonintervention", "whemmle", "unwreathed", "estops", "impostrix", "exarchs", "pepsinated", "brere", "indeflectible", "intolerancy", "intramatrically", "diluviate", "perjinkety", "spiraea", "laccase", "arithmometer", "retailed", "serbophobe", "thunderlight", "miterflower", "twixt", "recitatif", "laboratorial", "jingall", "windbibber", "darwinistic", "forevouched", "battalia", "assignments", "mellowing", "asperness", "orientalized", "incredulously", "heptanone", "cooperage", "posthumous", "almice", "hucklebone", "telespectroscope", "glottalization", "laminability", "superlied", "oasean", "hylozoism", "readvertising", "leadier", "reciprocate", "knockoff", "rejuvenator", "annotinous", "unvenerative", "reiteratedness", "ecblastesis", "dyads", "unstirring", "chilblains", "hemotachometer", "ballyhack", "blin", "sortal", "nicknack", "congous", "lasers", "monoacid", "glairin", "intergrade", "brayette", "nonexpiries", "deblocked", "velociously", "bloomkin", "tautness", "tepidness", "memoranda", "colliquate", "democratised", "perilabyrinthitis", "anisopogonous", "roquette", "bibenzyl", "reviewer", "unpendent", "inclinometer", "illoyal", "bainite", "preordainment", "becut", "tanjib", "caricatured", "tiu", "pluviometrical", "ordinands", "komondorok", "jateorhiza", "pacate", "danic", "loricae", "situationally", "octocotyloid", "corvoid", "nonplastic", "saindoux", "authenticity", "leo", "bookmark", "demodicidae", "gangliomata", "metaprescutum", "interparty", "tawses", "filatures", "unsegregatedness", "unmuzzle", "nyctaginaceae", "nightlife", "hypochondric", "repowers", "outswims", "mudstones", "interbody", "scripts", "fie", "unelectrized", "diarrhea", "juniors", "commelinaceous", "unstarred", "dsects", "coordinator", "implies", "madeiran", "ephthianura", "schoenus", "aidant", "adephagia", "crepidula", "acrologue", "beriber", "newspapers", "complying", "unflated", "nonnecessity", "caster", "beast", "bicker", "shitheel", "vilayets", "lungfishes", "panglossian", "sarcosporida", "caressable", "peckishly", "spicular", "decempunctate", "skedaddler", "nymphaline", "dizziness", "indylic", "uncontrolled", "sensualness", "verges", "leafgirl", "corrosionproof", "inreality", "hellicat", "hypoptosis", "mangrove", "babudom", "nixe", "copperheadism", "humored", "ferroglass", "nonblack", "zymoscope", "nonmimetically", "trolleyman", "thonged", "ageists", "helotage", "caddy", "standard", "chessel", "challote", "platitudinarian", "azoxime", "tokonomas", "calvaries", "cutaways", "semimanagerially", "cannibalism", "dendrocalamus", "spado", "crustific", "custodianship", "gristbite", "irrepresentable", "mesodermic", "kitchenette", "adolesced", "vitalistic", "asperities", "overpolemical"]
# from random import choices
# a = open("englishwords.txt").readlines()
# b = ('@["' + ('", "'.join(choices(a, k=500))) + '"]').replace("\n", "")
# print(b)

proc randomSleep(minimum: int = 500, random_value: int = 1500) =
  sleep(rand(random_value).int + minimum)

proc randomPositionWithinBounds(precedentX, precedentY, screenWidth, screenHeight: int32): (int32, int32) =
  var newX = int32(precedentX.int + rand(100).int - 50)
  var newY = int32(precedentY.int + rand(100).int - 50)

  if newX < 0: newX = 0
  if newX >= screenWidth: newX = screenWidth - 1
  if newY < 0: newY = 0
  if newY >= screenHeight: newY = screenHeight - 1

  (newX, newY)

proc clickAt(x: int32, y: int32) =
  SetCursorPos(x, y)
  mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, 0)
  mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, 0)

proc typeString(s: string) =
  var input: INPUT
  var inputs: seq[INPUT] = @[input]
  
  for c in s.toRunes:
    input.type = INPUT_KEYBOARD
    input.ki.wVk = 0
    input.ki.wScan = cast[WORD](c.int32)
    input.ki.dwFlags = KEYEVENTF_UNICODE
    inputs[0] = input
    SendInput(inputs.len.UINT, addr inputs[0], sizeof(INPUT).cint)

    input.ki.dwFlags = KEYEVENTF_UNICODE or KEYEVENTF_KEYUP
    inputs[0] = input
    SendInput(inputs.len.UINT, addr inputs[0], sizeof(INPUT).cint)

    randomSleep(20, 300)

proc jiggleMouse(screenWidth, screenHeight: int32) =
  GetCursorPos(addr originalPos)
  var newX = originalPos.x
  var newY = originalPos.y
  while true:
    if rand(4) == 0:
        clickAt(originalPos.x, originalPos.y)
    else:
      for a in 0 ..< rand(4):
          randomSleep(5000, 1000)
          typeString(sample(words) & " ")

    let (precedentX, precedentY) = (newX, newY)
    (newX, newY) = randomPositionWithinBounds(newX, newY, screenWidth, screenHeight)
    let (diffX, diffY) = ((newX - precedentX), (newY - precedentY))
    for a in 0 ..< rand(7):
        randomSleep(50, 500)
        SetCursorPos(newX, newY)
        (newX, newY) = (newX + diffX, newY + diffY)
    randomSleep()

jiggleMouse(screenWidth, screenHeight)

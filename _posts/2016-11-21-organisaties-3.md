---
layout: post
title:  "Thematische Werkgroep Organisaties 3"
categories: organisatie
permalink: /:categories/:year-:month-:day/
---

* TOC
{:toc}

## Details

* Locatie: AIV, Boudewijngebouw, Brussel - Vergaderzaal 3.E.12
* Gerelateerde documenten: [PDF met uitleg over "Feitelijke Organisatie"]( {{site.github.url}}/assets/organisatie/2016-11-21/Administratie_en_organisatie.pdf )
* Notulen: Dries Beheydt, Dieter De Paepe

### Aanwezigen

| Naam         | Afkorting | Organisatie |
|:-------------|:----------|:------------|
| Suzie Favere                   | SF   | AIV  |
| Thomas D’Haenens               | TD   | AIV  |
| Ward Bemelmans                 | WB   | F&B  |
| Geert Thijs                    | GT   | AIV  |
| Dieter De Paepe                | DDP  | imec |
| Dries Beheydt                  | DB   | AIV  |
| Marie-Kristine Van der Meersch | MVDM | ANB  |
| Ziggy Vanlishout               | ZV   | AIV  |


### Verontschuldigd

Jerry Vertriest, Geert Vermeiren, Raf Vandensande, Mathias Van Compernolle, Raf Buyle, Gijs Martens, Sammy Roos

### Afwezig

Luk Verschooren, Farah Decamps, Peter Vandenneucker, Maarten Vermeyen, Hilde Van Gysel

## Agenda

* Inleiding
* Bespreken draft model organisatie aan de hand van use cases
* Discussie


## Verslag

### Inleiding

DB start de vergadering met een korte toelichting over het doel van de OSLO² co-creatiedag op 9 december aanstaande. Meer in het bijzonder wordt er toegelicht wat het doel is van deze dag en hoe deze zich verhoudt tot de interne thematische werkgroepen die al werden gehouden.

De interne werkgroepen waar het OSLO²-traject mee begonnen is, waren bedoeld om een eerste aanzet van een nieuw model aan te leveren en de workflow te bepalen. We beschouwen dit traject als fase 1. Het is niet de bedoeling om een volledig afgewerkt model te presenteren op de co-creatiedag. De co-creatiedag heeft als belangrijkste doel om externen te informeren en aan te moedigen om zich mee in de discussies te mengen van toekomstige, opengestelde werkgroepen. Dit wordt dan fase 2 die zal starten op 9 december en zal lopen tot eind februari 2017.

Ook de agenda van de co-creatiedag wordt kort toegelicht: in de voormiddag wordt een introductiesessie gegeven over de noodzaak aan open standaarden en dus aan een project zoals OSLO² + het project wordt kort voorgesteld wat organisatie en planning betreft. In de namiddag zal per thema een voorstelling gegeven worden van de huidige status en inhoud. Dit moet de aanwezigen toelaten inhoudelijk zicht te krijgen op elke werkgroep om zodoende goed geïnformeerd te kunnen beslissen aan welke werkgroep deel te nemen.

Daarna geeft DB een korte recap van de vorige sessie van deze werkgroep: sessie 2. Tijdens de vorige sessie presenteerde GT een overzicht van de verschillende bestaande modellen: [org](http://informatievlaanderen.github.io/OSLO/vocabularia/#the-organization-ontology-org---w3c), [regorg](http://informatievlaanderen.github.io/OSLO/vocabularia/#registered-organization-vocabulary-rov---w3c) en [CPOV](http://informatievlaanderen.github.io/OSLO/vocabularia/#core-public-organisation-cpo---isa). Tijdens deze sessie presenteerde hij vervolgens een geconsolideerd model van OSLO1 verrijkt met elementen uit de voornoemde modellen die op één of andere manier niet of niet volledig voorkwamen in het OSLO1-model. Volgens onze ervaring uit de werkgroep dienstverlening, willen we ook hier het model testen door middel van het toepassen van concrete use cases op dit model. GT had hiervoor voorafgaandelijk een template doorgestuurd naar de leden om use cases te mappen op het samengestelde model, maar niemand had tijd gehad om dit reeds in te vullen. GT was zelf al begonnen om Informatie Vlaanderen te modelleren als use case. Daaruit zijn direct wat issues gekomen (zie verder).

GT heeft een nieuwe figuur voorbereid, op deze figuur zijn alle overlappende klassen samengevoegd. Elk vocabularium heeft zijn eigen kleur. Het gebruik van overerving in deze figuur is bedoeld om de structurele verschillen duidelijk te maken (bijvoorbeeld: de `GeregistreerdeOrganisatie` uit OSLO heeft 2 extra velden tegenover de `RegisteredOrganization` uit rov. (Gele en paarse vlakken, onderaan in het midden van de figuur).


{% include img_clickable.html alt="REGORG-model refactored." imgpath="organisatie/2016-11-21/draft-model.jpg" style="height: 200px;" %}


### Bespreken Draft Model Organisatie Aan De Hand Van Use Cases
De figuur stelt het huidige model voor, ontdaan van zogenaamde ‘dubbels’ = zaken die helemaal mappen op elkaar en elkaar dus overlappen. In principe staat elke eigenschap en elke entiteit maar éénmaal op deze voorstelling. Wat nog aan ‘overschot’ gevonden werd OSLO1 en niet in de andere vocabularia voorkwamen, werd tenslotte toegevoegd aan het model en werd aangeduid in het geel. (Een foutje hierbij is dat contact punt nog zowel in `OSLO:Organisatie` als `CPOV:PublicOrganisation` voorkomt.) Hiervan moeten we weten of er nog attributen/relaties ontbreken, wat de kardinaliteit van de relaties is en of de attributen optional, aanraden of verplicht zijn. We overlopen de verschillende onderdelen van de figuur om deze topics in de werkgroep te bespreken. Doel is om alles netjes samen te voegen tot 1 finaal model.


**Vraag WB**: Klopt het dat er, op basis van het voorgestelde model, 3 soorten organisaties zijn?: Public organisation, registered organization en formal organization.   
**Antwoord TD**: Ja, maar deze soorten zijn niet disjunct, een organisatie kan van meerdere soorten tegelijk zijn, waarbij de velden van die soorten dan samengevoegd worden zodat er maar één keer een beschrijving moet worden gemaakt.  
**Antwoord GT**: inderdaad niet disjoint, een geregistreerde organisatie kan ook een publieke organisatie zijn, etc…


Het antwoord op deze topic brengt ook het item ‘Vestiging’ kort naar de oppervlakte: in de oefening die GT gedaan heeft om AIV te mappen op dit model heeft hij AIV teruggevonden in het KBO als een vestiging.

> Discussie: Wat is een “FeitelijkeVereniging” en spreken we niet beter van een “NietFormeleOrganisatie”?

GT heeft deze term uit de documentatie van OSLO gehaald (stond ergens vermeld in één zin). Een voorbeeld van een FeitelijkeOrganisatie zou kunnen zijn: “een voetbalclub die nog geen VZW is” of “een groep buren die een barbecue organiseert”.  Feitelijke organisatie en formele organisatie sluiten elkaar uit.


Feitelijke vereniging kennen we uit OSLO, een organizational collaboration kennen we nu uit ORG, dit zijn organisaties die samenwerken, bijvoorbeeld “een BTW-eenheid”. Leden van deze eenheid moeten geen BTW betalen. De collaboratie wordt in principe niet geregistreerd.
TD stelt hierop de benaming “NietFormeleOrganisatie” voor als alternatief voor feitelijke vereniging. FeitelijkeVereniging is een type niet-formele organisatie. DDP vraagt of dit wel een eigen entiteit op zich moet zijn. Volgens TD wel, op voorwaarde dat er velden bestaan die eigen zijn aan deze entiteit, wat op het eerste zicht niet het geval is.

Blijkbaar is de term “feitelijke vereniging” een juridische term, waar [wikipedia volgende definitie over geeft](https://nl.wikipedia.org/wiki/Feitelijke_vereniging):

> Een feitelijke vereniging ontstaat volgens het Belgische recht zodra twee of meer personen het idee ontwikkelen om gezamenlijk een ideëel doel te verwezenlijken en zich daartoe verenigen. De feitelijke vereniging ontstaat uit een overeenkomst, een akkoord. Doordat de feitelijke vereniging geen juridische grond heeft (geen eigen rechtspersoonlijkheid), kan zij geen verbintenissen aangaan, geen eigendommen bezitten, geen schenkingen of legaten aanvaarden en zijn het de individuele leden die zich persoonlijk verbinden tot de verplichtingen van de vereniging. De leden zijn hoofdelijk en onbeperkt aansprakelijk.

Gezien het om een juridische term gaat, besluiten we om de term te behouden. SF zal nakijken of de term een vaste juridische invulling heeft. We komen op die manier tot 2 types organisatie: FormeleOrganisaties - FeitelijkeVerenigingen. Geregistreerde organisaties zijn een type van formele organisatie.


**Post-meeting antwoord van SF**:
Er bestaat geen reglementair kader voor de “feitelijke vereniging” . Het is ook geen vorm van intergemeentelijke samenwerking noch van verzelfstandiging. De volgende omschrijving is vrij accuraat:

> Een feitelijke vereniging ontstaat van zodra twee of meer personen het idee ontwikkelen om gezamenlijk een ideëel doel te verwezenlijken.
>
> Een feitelijke vereniging kan beschouwd worden als het "clubje".
>
> Doordat de feitelijke vereniging geen juridische grond (geen rechtspersoonlijkheid) heeft, kan zij geen verbintenissen aangaan, geen eigendommen bezitten, geen schenkingen of legaten aanvaarden en zijn het de individuele leden die zich persoonlijk verbinden tot de verplichtingen van de vereniging. Als een vereniging, door de realisatie van haar maatschappelijk doel, aanzienlijke risico's neemt, of onroerende goederen wil verwerven of schenkingen en legaten wenst te aanvaarden, dan doet zij er goed aan om haar structuur van feitelijke vereniging om te vormen naar een vzw.

Omdat feitelijke verenigingen geen rechtspersoonlijkheid hebben worden ze niet geregistreerd. Zie ook [volgend document]({{site.github.url}}/assets/organisatie/2016-11-21/Administratie_en_organisatie.pdf).

**Vraag**: Wat met buitenlandse organisaties?  
**Antwoord**: GT denkt dat we op dit vlak gedekt zijn, zou moeten voorzien zijn in REGORG, bvb door gebruik van een Identifier bij `org:Registration`. Eenzelfde attribuut is voorzien bij `org:Organization#identifier`.

> Discussie: Site/Vestiging

In OSLO1 wordt het onderscheid tussen een vestiging en een organisatie bijgehouden in een boolean veld, terwijl dit in dit model aparte klassen zijn (`Organisation` versus `Site`). OSLO1 was gemodelleerd op basis van het KBO, waar een vestiging en organisatie ook in dezelfde tabel worden bijgehouden. Onze aanpassingen zullen een verbetering zijn tav het oude OSLO1 model. Toen GT bezig was om AIV te modelleren, bleek AIV een vestiging te zijn onder een organisatie : Ministerie van de Vlaamse Gemeenschap (MVG). TD merkt op dat dit verkeerd in het KBO zit. AIV is een organisatie en geen onderneming. Gezien het KBO focust op ondernemingen, hoort AIV er eigenlijk niet in thuis. Hetzelfde fenomeen – organisaties die als site geregistreerd zijn – doet zich voor in de onderwijssector, de zorgsector,… Reden hiervoor is het gebrek aan een grootschalig organisatie register (dat is de bestaansreden van de nieuwe ontwikkeling ‘Wegwijs Organisaties’). We mogen OSLO² niet hierdoor laten leiden. Zulk misbruik mag niet gepersisteerd worden in een uitwisselingsmodel. Voorstel GT: sites voorzien die geregistreerd kunnen worden en ze ook nog apart als organisatie invoeren.

TD ziet deze werkwijze niet zitten. KBO is bedoeld voor het registreren van ondernemingen en hun sites; niet voor het registreren van organisaties die geen onderneming zijn.

Om het correct te doen, mag AIV niet voorkomen in het KBO. Vanuit het Organisatiesregister moet de relatie tussen de Publieke Organisatie AIV en de Publieke Organisatie MVG gelegd worden (`subOrganizationOf` in CPOV). Vanuit de beschrijving van het MVG (niet-disjoint dus zowel public organisation als registered organisation) kan dan verwezen worden naar het Ondernemingsregister (KBO). Enkel het MVG heeft sites, waaronder het VAC Gent en het Boudewijngebouw.
De public Organisation AIV heeft 2 sites, nl. het Boudewijngebouw en het VAC. Door in beide gevallen te verwijzen naar dezelfde site (of gebouw) krijg je toegevoegde interoperabiliteit.

Op de figuur is het niet duidelijk, maar `hasPrimarySite` en `hasRegisteredSite` zijn eigenlijk specialisaties van `hasSite`. Dit volgt hetzelfde principe als bij overerving: als een entiteit E van klasse B is, en klasse B erft over van klasse A, is E ook een entiteit van klasse A. Dus in dit voorbeeld: als een Site een een `primarySite` is van een organisatie, is het ook een gewone `site` van die organisatie.

**Vraag**: Een site kan verschillende types van adres hebben: post, facturatie, ontmoetingspunt, leveringen. Welke horen bij welke entiteit en hoe modelleren we dit? Waar moeten die ondergebracht worden? In OSLO hebben we specifieke adressen gekoppeld aan gebouweenheid: `ontvangtPostOp`, `teFacturerenOp` en `ontvangtLeveringenOp`.  Daarnaast hebben we in dit nieuwe model ook een contactpoint gedefinieerd op organisatie.  
**Antwoord**: Dit is wellicht context afhankelijk: facturatie, leveringen, post zouden functies kunnen zijn die een onderneming heeft los van de site. Sommigen komen wellicht bij de uitvoering op een site neer. Vraag is of het een kenmerk is van een organisatie of van een site? Beide zouden kunnen volgens DDP. Informatie Vlaanderen heeft 2 vestigingen maar heeft maar 1 officieel postadres op Boudewijngebouw. Facturen dienen bovendien naar Phoenixgebouw gestuurd te worden, dus nog een andere site. Ontvangt leveringen op zal bij lokale besturen in de praktijk veel adressen zijn: bvb. De verspreiding van drukwerk. Specialiseren van site op niveau van facturatiesite, leveringssite, … lijkt ons geen goed idee. Voorstel is de drie types van OSLO1 overnemen in OSLO² en nog een relatie bijtekenen: `heeftAdres`.

> Discussie: Wat is de link tussen een Gebouweenheid en een Site? Gebouweenheid zou hierbij adres vervangen.

De twee lijken gelijkaardig op het eerste zicht, maar ze zijn toch verschillend. DDP stelt dat een `Gebouweenheid` een subtype van `Site` zou kunnen zijn. Een site kan meerdere gebouweenheden bevatten. Een gebouweenheid kan verschillende functionele eenheden bevatten. Voor personen gebruiken we het concept domicilie om een gebouweenheid aan te duiden waar een natuurlijke persoon zijn of haar officieel verblijfsadres heeft. Hiermee zou echter het begrip van gebouweenheid gekoppeld worden aan het thema van organisaties, terwijl een gelijkaardig concept ook bruikbaar zou zijn voor het thema adressen. Een oplossing zou zijn om de 2 begrippen gescheiden te houden, maar om bij gebruik beide types aan te nemen. In het diagram zou het om een virtuele klasse gaan die overerft van `Site` en `Gebouweenheid`.

**Opmerking DDP**: We moeten oppassen dat een `Gebouweenheid` in ons model niet enkel toepasbaar is voor organisaties. Moet ook toepasbaar blijven voor natuurlijke personen (Rijksregister). `Gebouweenheid` mag dus niet gemodelleerd staan als subtype van bvb `Site`, wat enkel voor organisaties bestaat, want dan zou een gebouweenheid die betrokken wordt door een natuurlijke persoon de kenmerken van een site overerven.

Een korte toelichting volgt over het feit dat we hier in deze werkgroep enkel over organisatie spreken, als deel van een grote figuur, waar ook andere thema’s in voorkomen met link naar organisatie (persoon, dienstverlening, …) De scope van onze oefening was even onduidelijk voor een aantal deelnemers.


**Vraag ZV**: Waarom hebben we het begrip `Site` nodig? Is er niet nog ‘iets meer algemeen’ (verblijfsobject) nodig dat niet alleen door organisaties kan worden gebruikt, bvb ook personen? Met `Gebouw` en `Gebouweenheid` alleen raken we er niet, wat bvb met standplaats, ligplaats, .... Definitie van `Site` volgens W3C wordt bekeken:

> “A site is an office or other premise at which an organisation is located”. Note: in most cases this will be a physical address but virtual offices cannot be excluded. Een vestiging lijkt meer te zijn dan enkel een locatie. De definitie van een vestiging, volgens KBO: “Een 'vestigingseenheid' wordt gedefinieerd als "een plaats die men, geografisch gezien kan identificeren door een adres, waar ten minste een activiteit van de onderneming wordt uitgeoefend of van waaruit de activiteit wordt uitgeoefend". Het betreft met andere woorden dus elke geografisch afgescheiden exploitatiezetel, afdeling of onderafdeling gesitueerd op een geografisch welbepaalde locatie en identificeerbaar met een adres.“ 

ZV denkt eerder in de richting van het gebruik van een `OrganizationalUnit` - als ruimer begrip - waaraan vestigingen gekoppeld zijn. GT is het daar niet mee eens.

Het concept `Site` lijkt gerelateerd aan verblijfplaats voor natuurlijke personen. Sites zijn geregistreerd in het KBO en hebben een aantal kenmerken. Men lijkt aan de hand hiervan te willen weten waar men u kan vinden (voor personen: om kiesbrief te zenden, voor bedrijven: om te weten waar de organisatie zich bevindt).
Een organisatie kan X aantal activiteiten hebben en die moeten gekoppeld worden aan vestigingseenheden. Deze vestigingseenheden mogen we niet louter als geografische attributen zien.

Merk op: in deze context is een `SubOrganisation` niet hetzelfde als `Site`. Een postbus adres als tweede vestiging is niet mogelijk omdat er geen activiteit kan op worden uitgeoefend ([Bron Unizo](http://www.unizo.be/starters/advies/een-postbusadres-als-tweede-vestigingseenheid-mogelijk)). 

Voor dit discussiepunt is een [issue](https://github.com/Informatievlaanderen/OSLO/issues/40) aangemaakt in GitHub aangezien er tijdens deze werkgroep geen finale consensus wordt gevonden. 


**Vraag GT**: In org::organization lijkt een naam voor een organisatie te ontbreken? Vermoedelijk over te erven via FOAF?  
**Antwoord**: In de subklassen van registered organization vind je wel expliciet een `Name` terug. In CPOV vind je de term label (`preferredLabel` of `alternativeLabel`) welke misschien zou slaan op de naam. Bij de FOAF types (subtype van een `Agent`) verondersteld men wellicht dat er een attribute `rdfs:label` is dat op elke entiteit toepasbaar is en als naam kan gebruikt worden. Als we ons applicatie profiel specifiëren, zullen we een bepaalde term - bijvoorbeeld rdfs:label - moeten verplichten. Aangezien een organisatie meerdere namen kan hebben, zou het mogelijk kunnen zijn dat we iets meer specifiek dan `rdfs:label` nodig hebben, vergelijkbaar met het `preferredLabel` attribuut in 
`cpov:PublicOrganization`. Oplossing zou zijn om in het applicatieprofiel een naam/ label verplicht te maken. Gebruik zal afhangen van de use cases: 1 duidelijke naam nodig of meerdere namen?

**Opmerking GT**: in definitie van formal organization wordt verwezen naar het `FormalFramework`. Deze kan gevonden worden bij de `ChangeEvent`s: daar vind je welke event er geleid heeft tot het oprichten van een formal organization (“foundation event”). Het is dit event dat een organisatie tot een publieke organisatie maakt: ze is opgericht in het kader van een wet/decreet waarin specifiek gesproken wordt over een publieke organisatie, niet een privé organisatie.

Bij `ChangeEvent` voegt OSLO1 nog informatie over de levenscyclus toe(stopgezet, reden van stopzetting, …), dit lijkt nog steeds nodig in het kader van OSLO². TD vindt dat er meer subtypes van `ChangeEvent` nodig zullen zijn, hierover is [een issue](https://github.com/Informatievlaanderen/OSLO/issues/41) aangemaakt. Hoeft niet opengetrokken te worden naar andere types organizations, enkel de `PublicOrganization`. `FormalFramework` wordt best in een aparte namespace ondergebracht, uitgebreid met de velden uit CPSV-AP.


> Discussie: FeitelijkeVereniging.

ZV heeft wat extra informatie opgezocht rond feitelijke verenigingen en besluit dat deze ook een btw-nummer en ondernemingsnummer kunnen hebben, bijvoorbeeld een kinderopvang organiseren met enkele mensen. Om behandeld te worden in een overheidssysteem zal een vereniging zich op een bepaald punt moeten registreren. Is `FeitelijkeVereniging` dan geen subklasse van `FormalOrganisation` of `RegisteredOrganisation`? Het voorkomen van `FeitelijkeVereniging` in OSLO1 is volgens TD geen bewijs van het nut van deze klasse, aangezien OSLO1 sterk op het KBO gebaseerd was. TD stelt voor om “feitelijke vereniging” als type organisatie in te voeren, naast “vzw”, “bvba”... Bestaat er een dergelijk gecontroleerd vocabularium? Hierover is [een issue](https://github.com/Informatievlaanderen/OSLO/issues/42) aangemaakt.  
SF zal ook navragen waar een feitelijke vereniging wordt geregistreerd.

Voor er een aparte subklasse voor `FeitelijkeVereniging` wordt gemaakt moet er een goede reden voor zijn, volgens ZV. GT koppelt hieraan de bedenking wat men wil bereiken met het registreren van feitelijke verenigingen. Eens een feitelijke vereniging geregistreerd is, heeft ze een identifier en kan ze uitgewisseld worden.

Opmerking: in ons huidige verhaal hoeft een `PubliekeOrganisatie` niet noodzakelijk geregistreerd te zijn, cfr specificaties in CPOV. We moeten goede redenen hebben om Europa niet te volgen in deze, mocht dit de bedoeling zijn.

>Discussie: Hoe verschilt Hoedanigheid van org:Post en org:Membership?

Dit is de laatste entiteit uit het model welke we afgedekt willen hebben in de review tijdens deze werkgroep.

Visie van GT: relaties tussen hoedanigheid en `foaf:Agent`: o.a. `Post` (subtype van hoedanigheid bij OSLO1) `Membership` en `HeadOf`. Vraag is of we HeadOf moeten meenemen als apart attribuut of als sutbtype van `Post`.
DDP zoekt de [definitie](https://www.w3.org/TR/vocab-org/#class-post) van `Post` op:

> “A Post represents some position within an organization that exists independently of the person or persons filling it. Posts may be used to represent situations where a person is a member of an organization ex officio (for example the Secretary of State for Scotland is part of UK Cabinet by virtue of being Secretary of State for Scotland, not as an individual person). A post can be held by multiple people and hence can be treated as a organization in its own right.”

We interpreteren de uitleg dat `Post` eigenlijk ruimer is dan de hoedanigheid zoals wij die beschouwen in OSLO1.

**Opmerking MVDM**: mensen dienen een dossier in in een bepaalde rol en kunnen voor iets anders dan een andere rol spelen. GT beantwoordt deze opmerking met verwijzing naar principe dossier in dienstverlening. Hier gaat het over het uitwisselen van alle relevante hoedanigheden van een persoon bij een organisatie.

**Modelleringsvraag**: is een functie gekoppeld aan een persoon of aan een organisatie? Wat met mensen die bijvoorbeeld ontwikkelaar zijn bij organisatie 1 en in het kader van een project tijdelijk de rol van ontwikkelaar gaan opnemen in organisatie 2. Essentie moet zijn dat een persoon bij een bepaalde organisatie werkt in een bepaalde functie. Daarvoor voerde GT een losse mapping uit op hoedanigheid. We zullen Raf Buyle moeten vragen wat de bedoeling indertijd was bij de modellering hiervan in OSLO1.

GT zal nog bekijken welke hoedanigheid types er zijn?

**Vraag**: Wat met `Membership` versus `Post`? Moeten we daar iets mee doen? Als alternatief voor hoedanigheid stelt TD `Capacity` voor. Op wat mappen we dit dan: op `Role` of op `Membership` of op beide? 

Voor dit topic loggen we ook een issue in Github: [Hoe modelleren we Hoedanigheid](https://github.com/Informatievlaanderen/OSLO/issues/43)?


# GitHub Issues

Volgende issues werden aangemaakt op GitHub naar aanleiding van deze werkgroep:

- [Hoe activiteiten per Site bijhouden?](https://github.com/Informatievlaanderen/OSLO/issues/40)
- [Soorten ChangeEvent](https://github.com/Informatievlaanderen/OSLO/issues/41)
- [Hoe modelleren we FeitelijkeVereniging?](https://github.com/Informatievlaanderen/OSLO/issues/42)
- [Hoe modelleren we Hoedanigheid?](https://github.com/Informatievlaanderen/OSLO/issues/43)


## Actiepunten

**Algemene actiepunten**

- GT stuurt een uitgewerkt voorbeeld van een use case door aan de deelnemers van de werkgroep
- Iedereen probeert een of meerdere use cases te vinden en in te vullen in de template van GT
- Iedereen geeft feedback op de issues op GitHub

**Actiepunten uit deze werkgroep**

- GT: verwijderen van dubbel contactpunt uit de figuur.
- GT: toevoegen van een relatie `HeeftAdres`, naast de drie types overgenomen van OSLO1 (`ontvangtPostOp`, `teFacturerenOp`, `ontvangtLeveringenOp`).
- GT: Toevoegen van een virtuele klasse die overerft van `Site` en `GebouwEenhoud` aan het model.
- GT: `Gebouweenheid` mag dus niet gemodelleerd staan als subtype van iets wat enkel voor organisaties staat want dan zou een `Gebouweenheid` die betrokken wordt door een natuurlijke persoon de kenmerken van een site overerven. Te controleren hoe het gemodelleerd zit in het uiteindelijke model. 
- GT `FormalFramework` wordt best in een aparte namespace ondergebracht, uitgebreid met de velden uit CPSV-AP.
- SF vraagt na waar een feitelijke vereniging wordt geregistreerd en wat de precieze definitie is. (Antwoord is reeds opgenomen in dit verslag)
- Raf Buyle moeten we even vragen wat de bedoeling indertijd was bij de modellering  in OSLO1 van een persoon in een werkrelatie met een organisatie.
- GT: Welke hoedanigheid types er zijn?

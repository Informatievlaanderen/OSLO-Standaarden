---
layout: post
title:  "Thematische Werkgroep Organisaties 2"
categories: organisatie
permalink: /:categories/:year-:month-:day/
---

* TOC
{:toc}

## Details

* Locatie: AIV, Elipsgebouw, Brussel - Zaal 2.112
* Gerelateerde documenten: [Bijhorende presentatie]( {{site.github.url}}/assets/organisatie/2016-10-12/Presentatie WG Organisatie2.pdf )
* Notulen: Dries Beheydt, Dieter De Paepe, Mathias Van Compernolle

### Aanwezigen

| Naam         | Afkorting | Organisatie |
|:-------------|:----------|:------------|
| Suzy Favere                    | SF   | AIV  |
| Thomas D’Haenens               | TD   | AIV  |
| Marie-Kristine Van der Meersch | MVDM | ANB  |
| Geert Vermeiren                | GV   | ANB  |
| Geert Thijs                    | GT   | AIV  |
| Dieter De Paepe                | DDP  | imec |
| Dries Beheydt                  | DB   | AIV  |
| Mathias Van Compernolle        | MVC  | imec |



### Verontschuldigd

Luk Verschooren, Hannes Lombaert, Farah Decamps, Peter Vandenneucker, Maarten Vermeyen, Laurens De Vocht, Gijs Martens, Ziggy Vanlishout, Raf Buyle, Raf Vandensande Sammy Roos, Jerry Vertriest,  Ward Bemelmans

## Agenda

* Recap meeting 16/06/2016
* Aanzet nieuw model
* Discussie


## Verslag

### Recap meeting 16/06/2016

DB doet een algemene verwelkoming en verduidelijkt de aanpak van de sessie.
Het voorbereidende werk werd uitgevoerd door GT en DDP. 
TD schetst het algemene doel van de werkgroep ‘organisatie’ en de verdere planning: het globale doel is het komen tot een consensus over een model dat ‘een organisatie’ beschrijft en die bovendien maximaal herbruikbaar is (eerste versie van een conceptueel model) tegen het einde van dit jaar, waarna vervolgens een publiekelijke validatie kan plaatsvinden, met inbegrip van de lokale besturen.

GT licht de vorige meeting toe. Toen werden twee modellen voorgesteld: (i) Domeinmodel Wegwijs en (ii) UML-versie van OSLO1. Uit de verdere analyses van de modellen, werd een vervolgaanpak gedestilleerd voor deze sessie van vandaag. Wegwijs beperkt zich enkel tot publieke organisaties, maar OSLO1 niet. Wegwijs was gebaseerd op ISA, dus wordt naar ISA gekeken voor het generen van verdere inspiratie. We kijken naar [Core Public Organisation Voc](https://joinup.ec.europa.eu/asset/cpov/asset_release/all) [CPOV] (ISA), [Core Business Vocabulary](http://www.gs1.org/epcis/epcis-cbv/1-0) [CBV] (GS1) (ISA, vervangen door REGORG), [The Organization Ontology](https://www.w3.org/TR/vocab-org/) [ORG] (w3c) en [Registered Organization Vocabulary](https://www.w3.org/TR/vocab-regorg/) [REGORG] (w3c) (zie slide 1).

Deze modellen zijn naar UML omgezet, daarbij zijn ze omgezet naar een structuur van samengestelde datatypes ipv "alles is een entiteit" zoals dit bij RDF het geval is. Dit laatste is echter niet de gewoonte bij de Vlaamse Overheid.

### Aanzet nieuw model

Om tot een nieuw model te komen werden, zoals hierboven beschreven, andere modellen bekeken ter inspiratie, geanalyseerd en aangepast om tot een nieuw voorstel van model te komen.


#### OSLO 1

In eerste instantie werd OSLO1 bekeken en geanalyseerd hoe ‘organisatie’ er geconceptualiseerd werd.

{% include img_clickable.html alt="Organisatie binnen OSLO." imgpath="organisatie/2016-10-12/oslo1-organisatie.png" style="height: 200px;" %}

* Een eerste vaststelling is dat OSLO erg generiek gedefinieerd is (zie ook bovenstaande figuur).
* Het object ‘organisatie’ staat centraal, maar veel velden in OSLO1 die in principe terug te brengen zijn tot de velden uit [KBO](https://overheid.vlaanderen.be/de-vlaamse-overheid-kbo#datamodel). 
* Er wringt iets binnen OSLO1: men probeert veel te veel over verschillende types organisatie te zeggen; dit is te merken aan de hoeveelheid attributen.  ISA doet dit niet en heeft dit veel concreter gemaakt door opsplitsingen te maken (formele organisatie, publieke organisatie). Deze laatste aanpak is specifieker en laat toe een onderscheid te maken tussen publieke en private organisatie en vanuit de werkgroep komt het idee dat dit wellicht de te volgen weg is.. 
* ISA beschrijft organisatie als specialisatie van een agent. Er is een link OSLO:Agent en de functie die hij in een organisaties speelt.
* ‘Hoedanigheid’: dit blijkt een moeilijk te definiëren term te zijn en hierop zullen we later op terug moeten komen. 
* Er is een link tussen agent en gebouw(eenheid): ipv met adressen te werken, zal er gewerkt moeten worden met gebouw eenheden (trend om ook personen zo aan te pakken) en zo tot een locatie te komen. Een gebouw eenheid is persistenter dan een adres (= label om op een terrein iets te vinden). Gebouw eenheden kunnen immers veranderen (bv muur uitbreken tussen 2 appartementen), maar dan gaat het om een fysieke verandering.

**Vraag SF**: gebruikt men gebouw eenheden om te kunnen linken met CRAB of gebouwenregister? 
**Antwoord GT**: Het antwoord is paradoxaal gegeven: de authentieke bron van gebouw eenheden zal het gebouwenregister zijn dat, paradoxaal genoeg, opgestart zal worden vanuit CRAB (we gaan afleiden van de adressen als initiële aanzet).

#### ORG-Model Refactored

{% include img_clickable.html alt="ORG-model refactored." imgpath="organisatie/2016-10-12/org-refactored.png" style="height: 200px;" %}

Een eerste bron van inspiratie is ORG, de W3C standaard waaronder elke soort organisatie onder kan gemodelleerd wordt. 
Opvallendheden hierbij zijn:

* ORG begrijpt hetzelfde in haar definitie van organisatie als OSLO1
* Minder properties, maar veel meer entiteiten
* Organization heeft 3 (niet-disjuncte) subtypes (Organization unit, Org collaboration, Formal Organisation) en de publiekeOrganisatie uit CPOV is nog een 4e subtype. Deze opsplitsing laat toe dat organisaties onder meerdere subtypes kunnen benoemd worden. Dit betekent ook dat deze formeel moeten vastgelegd worden (het striktst in een register).
* Organisatie en Site/vestiging zijn van elkaar gescheiden (in OSLO1: deze organisatie is ook een vestiging). Het is voorlopig onduidelijk of Site semantisch hetzelfde betekent in OSLO1 en ORG.  
  * **Vraag DB**: wordt er bedoeld: wij zijn een organisatie met sites of vestigingen? Komt met andere woorden met Site/Organization dan vestigingsnummer en ondernemingsnummer overeen?
  * **Antwoord GT**: dit weten we nog niet goed, want door "hasPrimarySite", "hasSecSite" 	kan je denken aan zetels, vestigingen… Precieze definitie moet bekeken worden.
* ORG maakt ook gebruik van Change event: zegt iets over wanneer organisatie fundamenteel veranderd is (bijvoorbeeld door faillissement, oprichting, stopzetting). Het laat toe om organisaties te benoemen voor en na de Change, maar ook fusies of wijzigingen van rechtsvormen kunnen meegenomen worden. 
* Suborganisation: betekent dit een afdeling van een organisatie / holdingsstructuur? Dit moet een organisatie op zich zijn. Er moet verder onderzocht worden of er 
* geen overlap zit met organisatie.
* Rol tussen Agent en Organsiatie wordt ook gemodelleerd, maar mogelijks past dit in kader van rollen en mandaten? Het woord Rol betekent hier iets anders dan bij OSLO. De relaties van Organisatie naar Agent zou dus ook kunnen zijn van Org naar Org, van Org naar Groep, van Org naar Persoon.
  * Binnen ORG betekent rol: mandaat om membership uit te oefenen; Bij OSLO wordt deze rol anders ingevuld. 
* ORG bouwt verder op FOAF +reportTo (zo worden personen gekoppeld aan een organisatie). 

**Vraag SF**: wat levert ons deze analyse op?  
**Antwoord GT in de vorm van een recapitulatie**: vanuit OSLO werd naar andere modellen gekeken (isa), zo kwam men bij ORG terecht en werden de verschillen gezocht en het model gehermodelleerd: in dit geval is ORG een vocabularium, maar als de facto standaard en laat shoppen toe, maar is net onvolledig/onbruikbaar voor de Vlaamse Overheid zelf, waardoor we verder moeten kijken naar andere modellen. Daarenboven, via RDF en LOD is het moeilijk om mappings te maken, zonder dat alles moet overgenomen moet worden. Mapping naar een ander vocabularium betekent dan ‘ik neem de definitie over’. Men kan echter ook nog ‘overerven’.Het uiteindelijke doel is dan dat OSLO zowel het model wordt en tegelijkertijd zich ook als een vocabularium gedraagt. 

#### REGORG Refactored

{% include img_clickable.html alt="REGORG-model refactored." imgpath="organisatie/2016-10-12/regorg-refactored.png" style="height: 200px;" %}

Vervolgens werd ook inspiratie gehaald uit het REGORG-model, weliswaar in beperkte mate, zie de figuur. 

* Organisatie betekent hier een wettelijk geregistreerde organisatie.
* Subklasse van FormalOrganisation; manier voor een formele organisatie om te zetten en aan te duiden dat eigenlijk ergens anders ook nog geregistreerd is, bijvoorbeeld in het KBO. 
* De attributen zijn typische KBO-velden (dit moet wel nog gevalideerd worden)
  * Er zijn verschillende classificaties en types op te merken: (status, oprichting, faling,...; activity komt erg overeen met de [NACE-BEL codes](http://economie.fgov.be/nl/modules/publications/kbo/codes_nacebel.jsp), officiële identifier (bv kbo nummer) en nog andere identifier (om onderscheid te maken met andere registraties.

**Aanvulling SF**: wij hebben bij ABB ook 2 identifiers (ook nog nis): in OSLO moet het mogelijk zijn om meerdere identifiers op te nemen.

#### CPOV Refactored

{% include img_clickable.html alt="CPOV-model refactored." imgpath="organisatie/2016-10-12/cpov-refactored.png" style="height: 200px;" %}

Vervolgens werd het CPOV (core public organisation vocabularium) bekeken, zie de figuur.

Volgende zaken komen uit de analyse voort:

* Bij de beschrijving van Organisatie zitten een aantal attributen vervat die in de in de richting gaan van een vocabularium ‘dienstverlening’, zoals contactpunt, adres, domein waarin actief,...
* Ook in CPOV zit een ChangeEvent vervat om de veranderingen van organisaties te kunnen bijhouden.
* FormalFramework laat toe om te beschrijven binnen welk kader de organisatie opgericht werd (deze organisatie is opgericht in het kader van wetgeving X), wat door de werkgroep als een nuttige uitbreiding wordt aanzien. 
* Veel ‘zelfrelaties’, die niet allemaal even relevant zijn.

#### Samenhang CPOV, ORG, REGORG en FOAF

De samenhang uit de voorgaande modellen wordt vervolgens weergegeven in een nieuw model (zie figuur). Deze stap werd toegevoegd als een vervolgfase om overzicht te krijgen tot waar het nieuwe OSLO² model heen kan gaan en tegelijkertijd als een soort generiek beeld dat duidt waar we vandaan komen. Sowieso moet dit in een latere fase nog gevalideerd worden. 


{% include img_clickable.html alt="Samenhang CPOV, ORG, REGORG en FOAF." imgpath="organisatie/2016-10-12/samenhang.png" style="height: 200px;" %}


##### Eerste Vaststellingen

Uit de analyse van de samenhang van de verschillende modellen, worden volgende eerste vaststellingen gemaakt:

* CPOV:PublicOrganisation is subklasse van ORG:Organisation in plaats van ORG:FormalOrganisation.
   
Dit betekent dat ook niet-formele organisaties PublicOrganisation kunnen zijn. Dit valt te lezen in de specs en use cases van ORG. In eerste instantie zag men publieke organisatie als formele organisatie, maar er waren tegenargumenten om hieraan vast te blijven houden.

* ORG:FormalOrganisation is superklasse van REGORG:RegisteredOrganisation

Dit wil zeggen: alle geregistreerde organisaties zijn formele organisaties

* ORG:FormalOrganisation,ORG:OrganisationalUnit, ORG:OrganisationalCollaboration & CPOV:PublicOrganisation zijn niet disjoint

Dit betekent dat publieke organisatie tegelijk ook formele (en zelfs geregistreerde) organisatie kan zijn, of OrganisationalUnit, of…

##### Geïdentificeerde issues

Vervolgens werd een eerste inventarisatie van gedetecteerde issues besproken.

[Issue 33](https://github.com/Informatievlaanderen/OSLO/issues/33): Sommige elementen van CPOV:PublicOrganisation zijn al aanwezig bij ORG:Organisation (ChangeEvent, OrganisationalUnit, purpose, classification etc).

* In specs CPOV staat dat ze in RDF gebonden zijn aan dezelfde elementen in ORG
* Hoe modelleren we dit in UML? 
  * Dit laatste blijkt modelmatig een lastige oefening te zijn. DDP en GT zullen dit diepgaander bekijken.

[Issue 31](https://github.com/Informatievlaanderen/OSLO/issues/31): 
CPOV:PublicOrganisation is subklasse van ORG:Organization, in CPSV is het echter een subklasse van FOAF:Agent.

* Is dit een fout in het model? Indien ja: door te geven bij CPOV-review.
* Het probleem situeert zich bij de semantiek (deze klopt) rond ‘overerving van een agent’ (iets dat dingen doet) maar het wordt op een verwarrende manier weergegeven in het model - eronder staat organisation en daaronder public organization; in cpsv agent kan organisation dit doen

[Issue 34](https://github.com/Informatievlaanderen/OSLO/issues/34): FOAF:Agent & FOAF:Person werden binnen ORG uitgebreid met specifieke properties.

* Hoe modelleren in UML? 
  * Dit moet intern verder onderzocht en besproken worden.

Issue: ORG:Organisation is owl:equivalent aan FOAF:Organisation in RDF-specs (`owl:sameAs`).

* Wat betekent dit concreet voor het model?
  * Owl:equivalent moet geïnterpreteerd worden als ‘iets minder overlap’. Owl heeft een eigen definiëring van organisation, maar is eigenlijk volledig hetzelfde als FOAF. 
  * GT geeft aan dat we bij FOAFOrganisation eventueel ook gaan kijken naar andere elementen. DDP stelt voor om FOAF te behouden.

#### Integratie Met OSLO1

Uit de voorgaande analyses wordt vervolgens een geïntegreerde weergave gemaakt met OSLO1.

{% include img_clickable.html alt="Model integratie met OSLO1." imgpath="organisatie/2016-10-12/samenhang-met-oslo1.png" style="height: 200px;" %}

Bij dit geïntegreerde model wordt gewezen op de voordelen van het gebruik van ‘relaties’ in plaats van codelijsten. In het kader van een betere interoperabiliteit wil de werkgroep codelijsten vermijden, gezien die regionaal en territoriaal verankerd zijn en hergebruik bemoeilijken. Relaties laten daarnaast immers toe om internationaal te werken. Daarenboven is het niet meer mogelijk om te specialiseren indien men met codelijsten werkt.
In dit model zijn Site en Vestiging semantisch equivalent.

##### Matching: Informele Screening

Het geïntegreerde model wordt vervolgens aan een eerste informele screening onderworpen, met het oog op het zoeken naar een ideale matching. Volgende redeneerwijzen worden hierbij gehanteerd: 

* Welke concepten komen zowel in OSLO1 als in ORG/ROV/CPOV voor?
* Welke concepten uit ORG/ROV/CPOV komen voor zonder equivalent bij OSLO1?
* Welke concepten uit OSLO1 komen voor zonder equivalent bij ORG/ROV/CPOV?

**Concepten zowel in OSLO1 als in ORG/ROV/CPOV**


1. OSLO1:Organisatie is semantisch identiek aan ORG:Organisation
2. OSLO1:Organisatie:Organisatierelatie vat een aantal self-relaties samen van ORG:Organisatie en van CPOV:PublicOrganisation (linkedTo, subOrganisation, hasUnit, memberOf, Next)
3. Datatype OSLO1:KBO vertegenwoordigt min of meer de properties van ROV:RegisteredOrganisation?
4. OSLO1:Hoedanigheid vat een aantal entiteiten en relaties samen uit ORG (Membership / membership, Role, Post/post, headOf)
5. Relaties van OSLO1:Organisatie met Gebouweenheid lijken sterk op relaties van ORG:Organisatie met ORG:Site
6. Entiteit ORG:Site mapt op property OSLO1:Organisatie:vestiging  
  De vraag wordt geopperd of dit nog wel klopt: eigenlijk betreft het hier enkel de localisatie van een Vestiging. Een mogelijke oplossing is Vestiging als typering van een Gebouweenheid.  
Dit moet verder verfijnd worden.
7. OSLO1:Organisatie:primaire- en secundaireActiviteit lijkt mappen op ORG:Organisation:Classification en CPOV:PublicOrganisation:Classification?  
Dit is ongeveer hetzelfde
8. Maar OSLO1:Organisatie:primaire- en secundaireActiviteit mapt in wezen echt op REGORG:RegisteredOrganisation:orgActivity
9. OSLO1:Organisatie:LegalName mapt op REGORG:PublicOrganisation:maatschappelijkeNaam  
Dit is een veronderstelling en moet verder onderzocht worden
10. CPOV:Organisation:altLabel/REGORG:RegisteredOrganisation:alternativeLabel heeft een brede match met OSLO1:Organisatie:CommerciëleNaam & AfgekorteNaam.  
Dergelijke algemene benamingen bij OSLO1 zoals commerciële naam, afgekorte naam,... moeten we generieker kunnen benoemen, zodat een aantal elementen daaronder kunnen vallen. Moet verder onderzocht worden.
11. REGORG:RegisteredOrganisation:orgType lijkt overeen te komen met OSLO1:Organisatie:type (of eerder KBOrechtsvorm?)
12. Zowel in OSLO1 als bij ORG/CPOV is één en ander te vinden rond oprichting (OSLO1:Organisatie:oprichtingsdatum, ORG:ChangeEvent, CPOV:ChangeVent met subklasse CPOV:FoundationEvent) én link met Formal Framework
13. OSLO1:Organisatie:KBO:status lijkt te mappen op REGORG:RegisteredOrganisation:orgStatus
14. Zowel bij OSLO1:Organisatie als CPOV:PublicOrganisation vinden we contactinfo (isTeBereikenOp, hasContactPoint)
15. REGORG:RegisteredOrganisation:orgRegistration+identifier lijkt te mappen op OSLO1:Organistion:identificator:bron & identificator  
Dit betreft de organisatie die voor de registratie gezorgd heeft.  
Rol heeft ook contactinfo nodig. Bijvoorbeeld iemand die dossiers wil opvolgen vanuit verschillende mailboxen. Dit moet meegenomen worden naar de Thematische Werkgroep Diensten. 

**Concepten in ORG/ROV/CPOV, maar niet in OSLO1**


1. ORG:ChangeEvent en CPOV:ChangeEvent (incl FoundationEvent)
2. Specialisaties van organisatie (CPOV:PublicOrganisation, ORG:OrganisationalUnit en CPOV:OrganisationalUnit, ORG:OrganisationalCollaboration, ORG:FormalOrganisation, REGORG:RegisteredOrganisation)
3. Afzonderlijke entiteit Site voor vestigingen (bij OSLO1 gewoon een boolean)
4. ORG:Organisation:purpose, CPOV:PublicOrganisation:preferredLabel, description, logo, spatial, address, homepage (hoewel deze laatste 2 wellicht aanwezig in isTeBereikenOp)
5. CPOV:PublicOrganisation:spatial

**Concepten in OSLO1, maar niet in ORG/ROV/CPOV**


1. Info over stopzetting, rechtstoestand  
DDP stelt voor om dit onder ChangeEvent te plaatsen
2. KBOsoort: NatuurlijkPersoon, RechtsPersoon  
Dit is typische informatie die ook in het KBO vervat zit. De vraag rijst of dit ook nodig is bij OSLO. Verder te onderzoeken.
3. Info over “machtigingen”: KBOhoedanigheid  
Dit is typische informatie die ook in het KBO vervat zit. De vraag rijst of dit ook nodig is bij OSLO. Verder te onderzoeken.

##### Eerste Conclusies

Op basis van de de informele screening waarbij gezocht werd naar concepten die al dan niet aanwezig zijn in de andere modellen, worden volgende inhoudelijke conclusies getrokken..


1. Concept van not-disjoint subklassen invoeren om verschillende sets van properties te structureren:
  * GeregistreerdeOrganisatie (met allerlei KBO-gerelateerde data)
  * PubliekeOrganisatie
  * OrganisatieEenheid
Hierdoor wordt het mogelijk om combinaties in te voeren zoals bijvoorbeeld: Geregistreerde publieke organisatie
2. Concept van vestiging uit Organisatie halen (of opvoeren als subklasse)
3. Verder onderzoek blijkt nodig onder meer voor
  * formele mapping, 
  * Fijnafstemming
  * ...
4. Issue: Generieke Organisatierelatie versus specifieke bij ORG, generieke Hoedanigheid versus specifieke bij ORG

#### Screening Wegwijs

In een volgende analyse worden vervolgens de eerdere inzichten gemapped ten opzichte van het Wegwijsmodel.

{% include img_clickable.html alt="Model WegWijs." imgpath="organisatie/2016-10-12/model-wegwijs.png" style="height: 200px;" %}

Uit de screening komen volgende vaststellingen:

1. Wegwijs is afgeleid van CPOV, beperkt tot PubliekeOrganisatie
2. Niet aanwezig in CPOV: PubliekeOrganisatie:heeftGebouw
  * Dit zou misschien via Sites verwerkt kunnen worden. Kan mogelijk zijn via gebouweenheden.
3. Niet aanwezig in CPOV: Toepassingsgebied als subklasse van OrganisatieRelaties?
  * Dit is FormalFramework!  
Er blijkt een fout in de begeleidende slide 20 geslopen te zijn, met name een verkeerde interpretatie: het betreft relatie met OrganisatieRelatie en toepassingsgebied. Toepassingsgebied is dan een invulling van een formeel kader.  
Bijvoorbeeld: “onder toepassing van het energiedecreet van alle steden, gemeenten en provincies”
  * TD en GT gaan dit verder analyseren.
4. Niet aanwezig in CPOV: Relatie OrganisatieRelaties-FormeelKader
  * Loketten modelleren als organisaties?  
Dit gaat over de vraag of we het loket als onderdeel van een organisatie zien; ofwel dienstverlening aan loket gebeurt? Immers, "Een adres kan context gebonden zijn, bijvoorbeeld als loket adres of als organisatie adres. Verschillende loketten zouden gemodelleerd worden als verschillende organisaties."  
=> "Een adres kan context gebonden zijn, bijvoorbeeld als loket adres of als organisatie adres. Verschillende loketten zouden gemodelleerd worden als verschillende contactpunten."
5. Niet aanwezig in Wegwijs: Alles wat lijkt op Hoedanigheid: voor apart domein Rollen & Mandaten
  * Er heerst geen eenduidig beeld over hoedanigheid, rollen, mandaten, bezigheden, enz… Rol en mandaten zitten gekoppeld aan organen (rvb) , vandaaruit komen posten, rollen en mandaten;
  * Een idee is om Hoedanigheid te definieren als alles met functies. Een persoon heeft dan een reële rol in Hoedanigheid.
  * Een hoedanigheid kan ook bestaan zonder gekoppeld te zijn aan een persoon (maar een koppeling moet wel mogelijk zijn)
  * Een andere optie is om te werken met Agent
  * Er moet een duidelijk concept gedefinieerd worden, want het is immers nodig, samen met contact informatie. 
  * Het onderwerp wordt hier geparkeerd. Er zal met RB afgesproken worden hoe dit verder kan aangepakt worden. Afstemming moet gezocht worden met betrekking tot  contact informatie, kanaal, mandaten en rollen en hoedanigheid. Dit moet verder onderzocht worden.

### Overlopen Use Caes

In een derde deel van de werksessie werden de voorbereide use cases overlopen die later zullen dienen om het ontwikkelde model te valideren.

We verwijzen hier naar de voorbereiding van SF: 
ABB verzamelt, in samenwerking met 1700: geactualiseerde adressen, aangevuld met KBO-nummers uit BBC-databank van ABB (vroeger KBO);  en NIScodes uit oude adreslijsten ABB.

Het Agentschap Natuur en Bos (ANB) zal wellicht ook een use case kunnen aanleveren: bv Natuurpunt omvat ook nog verschillende kleinere gemeenten; daarnaast nemen sommige verenigingen/entiteiten binnen Natuurpunt ook verschillende rollen op, ook voor andere entiteiten. Daarnaast: Landbouwers - Registers met landbouwers: landbouwbedrijf kan een KBO-nummer hebben, maar elk landbouwbedrijf heeft ook een landbouwnummer: met ander woorden kan dit gebruikt worden om alternatieve id’s te testen.

In verband met samenwerkingsverbanden en diverse publieke en semi-publieke organisaties wordt verwezen naar het onderzoek van Professor De Rynck dat als overzicht dat kan dienen om te mappen op het model.
Meer informatie over dit onderzoek kan gevonden worden via ABB.


## Actiepunten

* Er zal een use case template gemaakt worden en iedereen zal deze proberen in te vullen om te zien waar er nog concepten ontbreken.
* Verdere uitwerking definities
* Discussies op GitHub
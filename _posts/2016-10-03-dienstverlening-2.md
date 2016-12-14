---
layout: post
title:  "Thematische Werkgroep Dienstverlening 2"
categories: dienstverlening
permalink: /:categories/:year-:month-:day/
---

* TOC
{:toc}

## Details

| Datum                   | 2016.10.03                                                                                               |
|-------------------------|----------------------------------------------------------------------------------------------------------|
| Locatie                 | AIV Gent, Koningin Maria Hendrikaplein, Zaal Albert Servaes                                                                |  
| Gerelateerde documenten | [Bijhorende presentatie]( {{site.github.url}}/assets/dienstverlening/2016-10-03/OSLO²_wgDienstverlening2_20161003_v4.pptx.pdf) |  
| Notulen                 | Dieter De Paepe, Dries Beheydt, Mathias Van Compernolle                                                  |

### Aanwezigen

| Naam                    | Afkorting | Organisatie |
|-------------------------|-----------|-------------|
| Dorien Bouwens          | DB        | AIV         |
| Raf Buyle               | RB        | AIV         |
| Katrien De Smet         | KDS       | ABB         |
| Katrien Leire           | KL        | Digipolis Gent |
| Dieter De Paepe         | DPD       | imec        |
| Geert Thijs             | GT        | AIV         |
| Thimo Thoeye            | TT        | Stad Gent   |
| Thomas D'haenens        | TD        | AIV         |
| Dries Beheydt           | DB        | AIV         |
| Mathias Van Compernolle | MVC       | imec        |

### Verontschuldigd
Bart Misseeuw, Sarah Spiessens, Sabine Rotthier

## Agenda
* Recap meeting 27/6/2016
* Aanzet nieuw model
* Discussie aan de hand van representatieve use cases

## Verslag

### 1 Recap meeting 27/06/2016

Deze bijeenkomst is de tweede voor de werkgroep ‘Dienstverlening’; Het voorbereidende werk door Geert Thijs en Dieter De Paepe wordt gepresenteerd op basis van het verslag van de eerste bijeenkomst.
Een eerste discussiepunt betreft de invulling van de concepten ‘publieke dienstverlening’, ‘dienst’ en ‘product’.

> **Voorstel (TD):** Een verandering van de definitie van ‘dienst’ dringt zich op, want de huidige is de definitie van een kernproces. In bedrijfsanalyse willen ze immers proces en dienst uit elkaar trekken.

> **Antwoord (GT):** Dit voorstel wordt gevolgd. Dienst is het verkrijgen van een vergunning, het proces is het interne proces, product is het resultaat. Het woord tastbaar is niet altijd van toepassing. Het mapt op de ISA output, maar dat is geen bruikbare term in Vlaamse context.

Vervolgens wordt het OSLO model toegelicht: In OSLO mapt dienstverlening op dossier/case, product mapt op dienst. Specifieke ‘output’ werd niet ondersteund, waardoor wellicht ‘dienstverlening’ als het ‘dossier’ gezien werd. In de verdere slides is dossier/case wel minder prominent aanwezig. Spreken we over diensten of publieke diensten?
Deze beslissing wordt later gefinaliseerd.

Uit de analyse van GT worden deze thema’s geformuleerd als issues.
Volgende worden geïdentificeerd:

* [OSLO1Issue-01](https://github.com/Informatievlaanderen/OSLO/issues/1): Dienstverlening is eigenlijk Dossier/Case
* [OSLO1Issue-02](https://github.com/Informatievlaanderen/OSLO/issues/2): Product is eigenlijk Dienst/Goed
	* Bijvoorbeeld Afleveren van Rijbewijs = Dienst, Rijbewijs is Goed
	* Oplossing: OSLO:Dienstverlening hernoemen bv naar OSLO:Dossier
	* Ook in DOSIS is de status gemapt op verschillende statussen.
* [OSLO1Issue-03](https://github.com/Informatievlaanderen/OSLO/issues/3): Onduidelijk of OSLO zich beperkt tot publieke dienstverlening: hebben we het over publieke dienstverlening of niet?
	* Elke hoeveelheid werk, waarvan kwaliteit en doorlooptijd bewaakt moet worden.
	* Processen met een welgedefinieerde aanleiding en een welgedefinieerd resultaat, waarvan kwaliteit en doorlooptijd bewaakt moeten worden, bij een transactie tussen persoon en bestuur, tussen ‘organisatie en bestuur’ maar ook interbestuurlijk.
	* Oplossing: OSLO beperkt zich tot publieke dienstverlening
	* **Vraag:** waarin onderscheidt een publieke dienstverlening zich ve andere?  
	* **Antwoord:** relatie met publieke organisatie (zie relatie HasCompetentAuthority in CPSV-AP)
* [OSLO1Issue-04](https://github.com/Informatievlaanderen/OSLO/issues/4) EN [OSLO1Issue-05](https://github.com/Informatievlaanderen/OSLO/issues/5): Geen relatie tussen OSLO:Product (lees OSLO:Dienst) en JuridischKader/Agent.
	* Oplossing: om hier nieuwe ideeën op te doen, worden twee extra modellen er bij gehaald ( zie CPSV en CPSV-AP - Zie titel 2 ‘Aanzet nieuw model’).
	* Nut van relatie JuridischKader met OSLO:Dienstverlening (lees OSLO:Dossier/Case)?
* [OSLO1Issue-06](https://github.com/Informatievlaanderen/OSLO/issues/6): Nut van Machtiging bij OSLO:Dienstverlening (lees OSLO:Dossier/Case)?
	* Is Machtiging geen generieker begrip dat thuishoort bij OSLO:Product (lees OSLO:Dienst)?
	* Is Machtiging geen entiteit in plaats van een datatype?

### 2. Aanzet nieuw model

#### 2.1 Inleidend
Om de bovengenoemde issues te kunnen aanpakken én om ontbrekende concepten toe te kunnen voegen, heeft GT volgende voorbereidingen getroffen als aanzet voor een nieuwe iteratie in het OSLO-model.
Hierbij werd OSLO1 als vertrekpunt genomen met als doel te integreren met CPSV en CPSV-AP. Bij deze twee laatste modellen is het echter zo dat alles een entiteit is, wat niet strookt met de huidige praktijken binnen de Vlaamse Overheid (bijvoorbeeld een kost is geen entiteit, want je zou het niet in een register steken). Dit geeft een breking tussen de OSLO1 view en de ISA views. Sommige zijn in datatypes gestoken, sommige worden pure attributen. Daarom wordt eerst CPSV (zie sectie 2.2) aangepast en vervolgens CPSV- AP (zie sectie 2.3), ten gevolge van de RDF-view.


#### 2.2 Analyse CPSV

{% include img_clickable.html alt="Het CPSV model." imgpath="dienstverlening/2016-10-03/cpsv.png" %}

{% include img_clickable.html alt="Het CPSV model met niet zelfstandige entiteiten als datatypes." imgpath="dienstverlening/2016-10-03/cpsv-refactored.png" %}

##### 2.2.1 Geïnventariseerde issues

Bij de analyse van CPSV worden een aantal eerste issues hieronder opgesomd:

* [CPSVIssue-01](https://github.com/Informatievlaanderen/OSLO/issues/7) : Mogen we CPSV:Channel, Temporal, Spatial opvatten als properties ipv entiteiten?
	* Indien nee worden het apart te onderhouden entiteiten!
* [CPSVIssue-02](https://github.com/Informatievlaanderen/OSLO/issues/8)	: RelatieUses: in de zin van Persoon X gebruikt Dienst Y?
	* Achterpoortje naar Dossier/Case?
	* Oplossing: navragen bij ISA.                
* [CPSVIssue-03](https://github.com/Informatievlaanderen/OSLO/issues/9) : Agent zou abstract moeten zijn.
	* Oplossing: navragen bij ISA           

##### 2.2.2 Introductie nieuwe concepten CPSV

Er worden een aantal nieuwe concepten uit CPSV geïntroduceerd:

* Relaties Requires & Related
* Language
* Temporal (wanneer is de Dienst beschikbaar)
* Produces(Output) =  Er wordt een onderscheid gemaakt  met ‘output’: een public service heeft een output  
	*bijvoorbeeld: Rijbewijs als de dienst ‘Het afleveren van een rijbewijs’ is.
* HasInput(Input): in feite CriterionRequirement (zie CPSV-AP) = vb ‘Geslaagd voor het rijexamen’
	* De opmerking wordt gegeven dat dit geen gepaste redenering is: er moet niet voldaan worden aan een criterium, maar eerder is er een specifiek document nodig (bv een identiteitsbewijs dat staaft dat iemand minimum 18 jaar is.)
* Rule (regels, richtlijnen, procedures etc)
	*CPSV voegt Rule toe: bv als juridisch kader een decreet is, dan rule als uitvoeringsbesluit?*
* HasChannel(Channel)
* Output, Input & Rule KernObject?

De voorgestelde issues en oplossingen worden vervolgens voorgesteld voor feedback aan de werkgroep door de presentatie van het geïntegreerde datamodel (sl 13). Highlights zijn:

* Dienstverlening/dossier tegenover product/dienst
* Relatie agent en public service
* Relatie agent en dossier (in OSLO zat er een rol op), in csvap hadden ze dit verder uitgebreid
Dit wordt gevisualiseerd in een nieuw model:

{% include img_clickable.html alt="Het CPSV model geïntegreerd met het OSLO model." imgpath="dienstverlening/2016-10-03/cpsv-integrated.png" %}

**Opmerking KDS:**  Dienst wordt vaak verkeerd geïnterpreteerd (bvb: beschrijvingen als: wat doet een sportdienst).  Voorgesteld benamingen zijn Dossier en Dienstverlening.
Hieruit volgen nieuwe kwesties:

* Dossier is nog een beladen woord, dus te bekijken. ISA ziet Dossier expliciet als generieke dienstverlening. Lokale besturen vinden de term Dossier te plastisch, te veel documentgericht. Kan ‘Case’ een alternatief zijn?
* Dienst kan gezien worden als de organisatorische eenheid van een organisatie.

**Opmerking Raf Buyle:** de concepten moeten duidelijk gescheiden zijn van een public service in een catalogus vs executiemodel vs partners die er gaan op moeten redeneren.
De werkgroep neemt als tussentijdse conclusie met betrekking tot volgende concepten die van belang zijn:

* Dossier/case: we laten dit even rusten
* Initiatie van de cases zijn belangrijk in het proces
* Dienst/product: nog geen rekening houden met ISA specs
* We kijken naar generieke dienstverlening: door CPSV subtype geplaatst onder dienst

> **Opmerking GT:** Moeten we Output, Input, FormalFramework als kernobjecten zien? Dan hebben we meer registers nodig (bv met alle decreten in )?

> **Suggestie van TD:** dit zou via een tussentabel opgelost kunnen worden.

##### 2.2.4 Ondernomen tussenstappen
Vervolgens worden de issues en oplossingen van OSLO + CPSV gezamenlijk voorgesteld:

* Opgeloste issues OSLO:
	* OSLOIssue-01 en 02: Namen OSLO:Dienstverlening en OSLO:Product aangepast (naar resp OSLO:Dossier en OSLO:Dienst)
* Mappings:
	* OSLO:Agent op CPSV:Agent
	* OSLO:JuridischKader op CPSV:FormalFramework
* Attributen doorgeschoven naar hoger niveau:
	* OSLO:Dienst:Naam=CPSV:PublicService:Name
	* OSLO:Dienst:Inhoud=CPSV:PublicService:Description
	* OSLO:Dienst:Type=CPSV:PublicService:Type
	* OSLO:Dienst:HeeftToepassingsgebied=CPSV:Spatial
* Toegevoegd aan OSLO entiteiten (relaties met CPSV niet meegerekend):
	* JuridischKader:IsRelated komt uit CPSV:FormalFramework
	* Agent-Creator-JuridischKader

Vanuit deze voorstellingen komen opnieuw een aantal issues waarmee rekening gehouden moet worden wanneer we het nieuwe model (OSLO-CPSV) bekijken:

* [OSLO+CPSVissue-01](https://github.com/Informatievlaanderen/OSLO/issues/10) : IsCPSV:FormalFramework een breder begrip dan een OSLO:JuridischKader?
	* Voorbeelden nodig! Bijvoorbeeld bij standaarden is dit ook;  
	* zo breed mogelijk mee nemen
* [OSLO+CPSVissue-02](https://github.com/Informatievlaanderen/OSLO/issues/11) : CPSV:Agent is Individual, Group Organisation, OSLO:Agent is Persoon, Hoedanigheid, Organisatie.
	* Conclusie: ook te checken met ISA want daar moeten ze nog beginnen met de analyse
	* AGENT vanuit Linked Data perspectief: houden we het abstract of niet? Men moet immers kiezen: persoon/hoedanigheid/organisatie: (i) OSLO-agent gaat overerven van een ISA agent. (ii) Juridisch kader/formalframework (iii) Wij stellen binnen dit kader dat OSLO volgt wat ISA voorschrijft.
	* Is Organisation=RegisteredOrganisation en Group=FeitelijkeOrganisatie?
* [OSLO+CPSVissue-03](https://github.com/Informatievlaanderen/OSLO/issues/1)  : Moeten we Ouput, Input en Rule beschouwen als kernobjecten?  
* [OSLO+CPSVissue-04(https://github.com/Informatievlaanderen/OSLO/issues/6)   : Wat te doen met Machtiging (zie ook [OSLOissue-05])
* [OSLO+CPSVissue-05](https://github.com/Informatievlaanderen/OSLO/issues/13) : OSLO:Dienst:Geldigheidsduur

#### 2.3 Analyse CPSV-AP

Een volgende stap is het refactoren van het CPSV-AP model, waarbij opnieuw gezocht wordt naar het integratie met de eerdere oefening (waarvan het OSLO-CPSV een tussenoplossing was).

##### 2.3.1 Eerste vaststelling
Uit een eerste analyse van CPSV-AP komen een aantal eerste opmerkingen naar voren:

* Identifier is overal geschrapt: dit een is een RDF-identifier, geen objectidentifier (geverifieerd bij [ISA](https://joinup.ec.europa.eu/asset/cpsv-ap/issue/all-classes-addition-identifier)). Zoniet zou alles een entiteit zijn.
* Entiteiten uit CPSV werden overgenomen en kregen (extra) attributen/relaties:
	* PublicService
	* Output (had in CPSV geen attributen)
	* Agent (had in CPSV geen attributen)
	* FormalFramework (had in CPSV geen attributen)
	* Rule (had in CPSV geen attributen)
	* Channel (allemaal nieuwe velden, generieker)
* Entiteiten uit andere namespaces werden overgenomen met reductie van attributen/relaties (zie CPSVAPissue-02):
	* CCCEV:CriterionRequirement
	* CCCEV:Evidence (vervangt CPSV:Input)
	* CPOV:PublicOrganisation
* Sommige relaties vallen weg:
	* CPSV:Agent-Creator-FormalFramework
	* CPSV:Agent-Creator-Rule

##### 2.3.2 Geïnventariseerde issues
Vervolgens worden de verschillende issues opgelijst die CPSV-AP met zich meebrengt

* [CPSVAPissue-01](https://github.com/Informatievlaanderen/OSLO/issues/14): CPSVAP:PublicOrganisation heeft 2 identifier’s.
	* Door overerving van CPSVAP:Agent dat nu identifier heeft.
	* Deze opmerking vervalt tegenover de refactoring, wel melden aan ISA.

* [CPSVAPissue-02](https://github.com/Informatievlaanderen/OSLO/issues/15): Reductie attributen/relaties bij overname uit andere ISA VOC’s. Zijnde: CCCEV:CriterionRequirement, CCCEV:Evidence (vervangt CPSV:Input), CPOV:PublicOrganisation
	* Eerder OSLO+CPSVAPissue
	* Reductie mogelijk niet gewenst vanuit OSLO standpunt, wel begrijpelijk vanuit applicatieprofiel

* [CPSVAPissue-03](https://github.com/Informatievlaanderen/OSLO/issues/16) : CPSVIssue-01: Mogen we CPSV:Channel, Temporal, Spatial, ContactPoint, PeriodOfTime opvatten als properties ipv entiteiten?
	* Zie ook CPSVIssue-01
	* Indien nee worden het apart te onderhouden entiteiten!

* [CPSVAPissue-04](https://github.com/Informatievlaanderen/OSLO/issues/17) : CPSVAP:Participation overlapt met CPSVAP:Uses/Provides
	* Oplossing: Uses/Provides opnemen in Participation

* [CPSVAPissue-05](https://github.com/Informatievlaanderen/OSLO/issues/18) : Event is eigenlijk geen event maar een EventType

* [CPSVAPissue-06](https://github.com/Informatievlaanderen/OSLO/issues/19) : Event ook relevant buiten appicatieprofiel (= buiten serviceportal)?


* **Opmerkingen (RB):** Inzake Publieke dienstverlening:
	* Worden hier ook interne en interbestuurlijke processen onder gerekend? Product moet hier zeker aan gekoppeld worden.
Beperken we ons tot publieke diensten of niet? Thomas stelt voor om ons te beperken. Dit houdt echter wel in dat dit te beperkend kan zijn. ISA definieert: diensten die een competente openbare organisatie als hoofdverantwoordelijke hebben.
	* Hoort hier ook outsourced dienstverlening bij? Bijvoorbeeld EPC-certficaten door externen;
=> Vanuit de werkgroep organisatie werd gesteld dat binnen CPSV-AP public organisation een subklasse is van agent, waardoor dit ook private personen/organisaties zijn
	* Public organisation die erft van een private persoon: kan dit?
=> Ja, maar er liggen hier nog meerdere tussenniveaus tussen.


**Opmerking (GT):** Binnen CPSV-AP gaat men echt gaan shoppen bij andere modellen, omdat het applicatie profielen zijn. De evidence klasse bevat dus maar enkele van de attributen die vermeld worden in core evidence vocabularium.


##### 2.3.3 Introductie nieuwe concepten
Aansluitend worden de nieuwe concepten geïntroduceerd die gevalideerd moeten worden en welke concepten dus overgenomen kunnen worden.

* Keyword verwijst naar het typische ‘applicatieprofiel’
* Sector (veiligheid, milieu)
	* handig om use cases te benoemen (komt van EDRL-project), om dienstverleningen te groeperen/benoemen.
* Status (actief/inOntwikkeling/stopgezet)
* Temporal (uitgebreid met openingsuren)
	* zelfs opgesplitst per channel, kunnen ze dit hebben.

* HasContactPoint(ContactPoint): ook opgesplitst per channel
¨* ProcessingTime(PeriodOfTime): (vastgelegde?) verwerkingstijd van een dienstverlening
* HasCost(Cost)
* PlaysRole(Participation)
	* alle mogelijke rollen (meer dan het leveren van een dienst)
* HasCompetentAuthority(PublicOrganisation)
* HasCriterion(CriterionRequirement)
* Evidence (vervangt Input, nu ook bij Channel)
	* onderscheid criteria vs evidence: Iemand heeft de volwassen leeftijd (18 jaar) behaald (criterium); de identiteitskaart is het bewijs (evidence).
* IsGroupedBy(Event)


### 3 Verdere afspraken en discussie
Op basis van de voorbereidingen van (GT) worden discussiepunten weergegeven die in de toekomst mee zullen genomen worden

#### 3.1 Rapportering en communicatie
* De CPSV-AP issues worden door Geert gemeld aan ISA voor de deadline van de publieke review.
* De issues zullen op GitHub komen, zodat de besluitvorming en de argumentatie verder behouden wordt.

#### 3.2 Besluitvorming
Geert vraagt aan de werkgroep om een beslissing te nemen over deze issues.

#### 3.3 Reflectie en uitbreiding
Er bestaan nog modellen die waardevol en inspirerend kunnen zijn voor de verdere verfijning van OSLO. Deze zullen nog in detail later bekeken worden.
De issues zullen op GitHub komen, zodat de besluitvorming en de argumentatie verder behouden wordt;

* [INSPIRE](http://inspire.ec.europa.eu/documents/inspire-data-specification-utility-and-government-services-%E2%80%93-technical-guidelines): Data Specification on Utility and Government Services => Deze draagt echter weinig bij.
* CPSV baseerde zich op nog een aantal andere referenties:
	* [Adaptive Service Model](http://www.theitsmreview.com/2014/01/adaptive-service-model/)
	* [Local Government Business Model](http://standards.esd.org.uk/LGBM.aspx)
	* [Public Sector Concept Model](http://www.pauldcdavidson.com/pscm/index.php?Action=ShowModel&Id=3)
	* [GEA Public Service Model](http://wapps.islab.uom.gr/govml/?q=node/4)

#### 3.4 Use Cases


Om de verdere uitvoering van OSLO te verzekeren zullen we op zoek moeten gaan naar use cases.

* CPSV heeft een aantal eerder specifieke use cases, terwijl CPSV-AP dan weer heel generieke use case weergeeft. Ze zouden echter allemaal hun relevantie kunnen hebben.
* Gent leverde ook een aantal use cases aan, waaronder het aanvragen van een vergunning voor rommelmarkt.
	* Om een vergunning te krijgen, is er een organisatie die een ontwerp van besluit weergeeft; eventueel met advies erbij : sommige moeten erin staan, andere niet (bv juridisch kader)
	* Goed ook om de link te leggen tussen (interne) processen en diensten, maar de vraag wordt gesteld of al deze interne diensten mee gemodelleerd moeten worden.

#### 3.5 Verdere aanpak, besluiten en suggesties

* Ondanks het feit dat er nog enkele issues zijn, besluit de werkgroep om te starten met wat we nu hebben en de huidige issues te laten valideren door externen. Dit zijn data- en domeinexperts binnen de contacten van de leden van de werkgroep.
* Issues worden gepost op GitHub, waarbij mensen nieuwe issues kunnen aan koppelen. Op de volgende zitting van de werkgroep worden de huidige en nieuwe issues besproken en gevalideerd, om op die manier richting een nieuwe versie te werken.
* De werkgroep gaat verder werken op de nieuw gecreëerde modellen (basis ISA en OSLO) door Geert, en indien nodig kan er geshopt worden bij andere modellen. CPSV-AP zal hierbij als de nieuwe basis worden aanzien, met uitzondering van ‘dossiers’.
* **Voorstel (TT)** voor om ook te kijken naar de standaard voor ‘formulieren’.
* Om de toetsing te volbrengen worden volgende afspraken gemaakt:
	* Er is een overzicht nodig zodat we weten welke attributen/ entiteiten/relaties nodig zijn voor welke use cases of welke er nog niet inzitten (Could/should/would).
	* Er is wat begeleiding nodig om de input sowieso overzichtelijk te houden.
	* We voorzien een informele Nederlandstalige versie voor alles, gezien er nog geen definities bij het model zitten. Idealiter zit er ook een voorbeeld bij (DB) . Dit wordt gemaakt door GT, TD en de medewerkers van iMinds. Deadline: begin november.

Er zal breed gerekruteerd worden mbt de issues: via Antwerpen, kenniscentrum, burgerloket, slimme subsidies. Eventueel ook via het facilitair bedrijf.
Issues worden op GitHub geplaatst: (DDP) bereidt dit voor.
Contactpersoon voor vragen: (TD)
Bespreking nieuwe issues: tweede week van november (Doodle door DB)  om in december een nieuwe versie op te leveren.

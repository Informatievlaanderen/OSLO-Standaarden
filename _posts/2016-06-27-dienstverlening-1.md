---
layout: post
title:  "Thematische Werkgroep Dienstverlening 1"
categories: dienstverlening
permalink: /:categories/:year-:month-:day/
---

# Details

* Locatie: AIV Gent, Koningin Maria Hendrikaplein, Zaal Karel Miry
* Gerelateerde documenten: [Evaluatie OSLO tov MAGDA 0819.xlsx]({{site.github.url}}/assets/personen/2016-06-15/{{ "Evaluatie OSLO tov MAGDA 0819.xlsx" | uri_escape}})
* Notulen: Dries Beheydt, Dieter De Paepe

## Aanwezigen

| Naam         | Afkorting | Organisatie |
|:-------------|:----------|:------------|
| Katrien Leire | KL | Digipolis |
| Raf Buyle | RB | AIV |
| Katrien De Smet | KDS | AIV |
| Sarah Spiessens | SS | AIV |
| Hannes Lombaert | HL | AIV |
| Bart Misseeuw | BM | AIV |
| Dieter De Paepe | DDP | iMinds |
| Thimo Thoeye | TT | Stad Gent |
| Thomas D’haenens | TD | AIV |
| Dries Beheydt | DB | AIV |

## Verontschuldigd

Ziggy Vanlishout, Laurens De Vocht

# Agenda

* Intro: over OSLO en OSLO²
  * Historiek OSLO
  * Het OSLO²-traject
  * Wat gaat OSLO² doen?
* Kern vocabularium Dienstverlening
  * Intro
  * ISA Core Vocabulary Public Service
  * Wat is OSLO1: UML-domeinmodel
  * Definitie: Wat is dienstverlening en wat gaan we daar rond doen?

# Verslag

## Intro: over OSLO en OSLO²

Hiervoor verwijzen we naar de [intro pagina over OSLO²]({{site.github.url}}/oslo2/).

> Discussie

**Vraag TT**: Gent beschrijft momenteel al een aantal producten en diensten. Kunnen we evolueren naar een situatie waar een transformatie kan gebruikt worden om de bestaande systemen te koppelen met OSLO²? Kunnen we semantische definities toevoegen die deze koppeling mogelijk maken? Wie zal zich hierover uitspreken?  
**Antwoord**: In praktijk zullen de betrokken partijen dit samen moeten bespreken, dit is ook afhankelijk van de technische expertise van de partners. Theoretisch gezien zullen de mappings best zo dicht mogelijk bij de bron beheerd worden. De vraag blijft echter wie er voor lokale veranderingen aan het model verantwoordelijk is. Heel wat gemeenten zullen velden anders benoemen, waar mee om te gaan is, het is echter ook mogelijk dat velden worden gesplitst, wat heel wat lastiger is om mee om te gaan.

**Vraag BM**: Is OSLO² een praktische oefening? We kunnen niet voor elk nieuw inzicht een nieuwe iteratie van het model starten.  
**Antwoord RB**: Het is nodig vooral toekomstgericht te denken. We willen effectief de bronnen afstellen op dit model, dus als praktische toevoeging van de huidige bronnen. Bronnen die niet onder ons beheer zijn, kunnen getransformeerd worden.

## Kern vocabularium Dienstverlening

> Discussie

### Intro

Enkele use cases die het nut van een kern vocabularium rond organisaties demonstreren:

1. **Informatiedeling** faciliteren met betrekking tot publieke dienstverlening.
2. De **integratie** van organisatie-brede IT-systemen.
3. Het scheppen van de condities om tot een **gefedereerde dienstencatalogus** te evolueren (onder impuls van Europa).
4. Het opvolgen van en **inzicht verstrekken** tot de levenscyclus van publieke dienstverlening.
5. De publieke dienstverlening **doorzoekbaar maken** naar burgers en ondernemingen toe.
6. **Herbruikbaar maken** van publieke dienstverlening (bijvoorbeeld [DoMyMove](http://www.bpost.be/nl/domymove)).

Een kern vocabularium beschrijft een minimale set van context-neutrale termen rond een bepaald thema. Andere partijen kunnen verder bouwen op deze termen voor meer concrete toepassingen. Indien meerdere partijen voortbouwen op dezelfde kern begrippen, vertrekken ze van gelijke definities en is het dus makkelijker om integratie te bekomen.

**Opmerking BM**: DOSIS ([Dossier Status Informatie Systeem](https://dosis.beta.informatievlaanderen.be/home/moreinfo)) zal als product mee de standaard bepalen eenmaal het geïntegreerd is in systemen. Momenteel is DOSIS in lijn met OSLO1.1. Eenmaal uitgerold, zou DOSIS wel een decennia lang kunnen meegaan. Momenteel zit lokale dienstverlening nog niet in het DOSIS-model.

**Opmerking HL**: Mensen zullen actief moeten begeleid worden, waarvoor mankracht moet voorzien worden.

### ISA Core Vocabulary Public Service

[ISA definieert publieke dienstverlening](http://joinup.ec.europa.eu/site/core_vocabularies/registry/corevoc/PublicService/) als volgt: “a set of deeds and acts performed by or on behalf of a public agency for the benefit of a citizen, a business or another public agency”. Deze definitie staat momenteel onder revisie, maar zal wellicht weinig veranderd worden.

Onderstaand schema is een UML voorstelling van het [core public service vocabulary application profile v1.1](https://joinup.ec.europa.eu/asset/cpsv-ap/asset_release/core-public-service-vocabulary-application-profile-v11-2nd-interim-versi#download-links) (CPSV-AP v1.1), een applicatie profiel van [Core Public Service Vocabulary (CPSV) V1.01](https://joinup.ec.europa.eu/catalogue/distribution/core-public-service-v101-rdfhtml) dat momenteel verder ontwikkeld wordt. Een applicatie profiel is een specificatie die termen hergebruikt van basis vocabularia en verdere specificaties toevoegt. Net als bij kern vocabularia is het de bedoeling dat applicaties dit model als basis kunnen gebruiken. De huidige versie van dit applicatie profiel focust zich op dienstverlening naar bedrijven toe. Momenteel is er een oefening bezig om dienstverlening naar personen toe mee te omvatten, hier zijn TD en KDS in betrokken.

{% include img_clickable.html alt="Schematische voorstelling van core public service vocabulary application profile v1.1." imgpath="dienstverlening/2016-06-27/CPSV-AP_v1.1.png" style="height: 400px;" %}

**Vraag DDP**: Gaat het in dit model om de dienstverlening zelf of specifieke instanties ervan? Bijvoorbeeld, voor de dienst waar men een rijbewijs kan aanvragen: gaat het om “personen kunnen een rijbewijs opvragen” of “persoon X vraagt een rijbewijs aan”, of beiden?  
**Post-meeting antwoord (DDP)**: De specificatie gaat over de dienstverlening zelf, hier zijn meerdere aanwijzingen voor:

* In de beschrijving van CPSV: “A public service is the capacity to carry out a procedure and exists whether it is used or not.”
* Sectie 3.5.23 van CPSV-AP V1.1: “[The hasCost relation of the Public Service] indicates the cumulative (or estimated or average) costs for the citizen or business related to the execution of the particular Public Service.”
* Sectie 3.12 van CPSV-AP V1.1: “The Period of Time class represents an interval of time. When linked from the Public Service to the Period of Time (using Temporal, section 3.5.19) it defines the period in which the service as a whole is available. This might just be a start date but with no end date for services that are still active, or information about seasonal availability. ”

**Opmerking BM**: Dienstverlening wordt ergens authentiek geregistreerd en beheerd. Om het model niet te verzwaren gaan we best niet te breed bij het modelleren (bijvoorbeeld door de kost van dienstverlening erbij te nemen).

**Opmerking RB**: We kunnen use cases gebruiken om door het ISA model te lopen. Het model zal je wel kunnen toepassen/mappen, maar het vocabularium kan op verschillende manieren geïnterpreteerd worden.

## Wat is OSLO1: UML-domeinmodel

{% include img_clickable.html alt="UML diagram van OSLO1." imgpath="dienstverlening/2016-06-27/OSLO1-UML.png" style="height: 400px;" %}

Dit is een alternatief vertrekpunt, in plaats van het ISA core vocabularium.

## Definitie: Wat is dienstverlening en wat gaan we daar rond doen?

Volgende definities bestaan reeds over publieke dienstverlening:

* [ISA Core Vocabularium](https://joinup.ec.europa.eu/catalogue/distribution/core-public-service-v101-rdfhtml): “It is a set of deeds and acts performed by or on behalf of a public agency for the benefit of a citizen, a business or another public agency.”
* [Vlaamse producten catalogus](https://overheid.vlaanderen.be/productencatalogus-ipdc) (IPDC): producten/diensten uitgaand van de overheid – binnen een regelgevend kader en ten behoeve van burgers, bedrijven en organisaties (niet de overheid). Er moet bovendien een interactie zijn tussen de overheid en de doelgroep of een derde persoon ten behoeve van de overheid en de doelgroep. Uitgesloten: interne producten en tussenliggende producten.

> Beslissing

Wij zullen volgende definities gebruiken:

* **Dienst**: het kern proces gerealiseerd voor de publieke dienstverlening. (Met uitsluiting van management- en sturing processen).
* **Product**: het tastbare resultaat van een dienst.

**Opmerking bij de totstandkoming van de definitie van dienstverlening en dienst**: We zien de noodzaak van een onderscheid te maken tussen een dienst, een instantie van een dienst en een product. Dit dient afgestemd te worden met ISA.
Voorbeeld van een specifiek dienst en een instantie van een dienst is het voorbeeld van het rijbewijs (dat hierboven vermeld was).

> Actiepunt

**Opmerking HL**: In het OSLO-model moet nog een bijkomende relatie worden gelegd.

> Discussie

Het doel is een model op te stellen dat de kern elementen in verband met dienstverlening bevat, waarop lokale besturen een eigen verrijking kunnen toepassen. Zo hebben verschillende besturen een gemeenschappelijk aanknopingspunt en moet niet elk bestuur het werk opnieuw doen. Zo kan bijvoorbeeld het gebouwenregister dienen als bron van gebouwen en gebouweenheden die vervolgens verrijkt kunnen worden door andere instanties (Vlaams Energieagentschap, Vlaamse Maatschappij voor Sociaal Wonen…).

Het volgen van een gemeenschappelijk model versimpelt ook het afleiden van andere informatie. Een voorbeeld hiervan is de mapping oefening van de statussen voor DOSIS. Hier wil men de verschillende detail statussen modelleren naar een generiek bruikbaar statusmodel. Elke dienstverlening moet naar een generiek model mappen om transparant en betekenisvol te kunnen rapporteren aan de burgers/ondernemers/andere publieke organisaties. Dit ondersteunt beleidsvragen zoals “In hoeveel % van de gevallen overtreden we een gecommuniceerde SLA met de eindgebruiker?”. In DOSIS komen we momenteel tot 6 generiek fases.

Aan het einde van het verhaal moeten we over een zeer concrete DOSIS en een zeer concrete IPDC beschikken die op dezelfde manier begrepen en gebruikt wordt door de meest diverse afnemers (burgers, ondernemingen, overheden). Dit leidt naar een getrapt model: ISA Core (AP) vocabularium – OSLO² datamodel – applicatieprofiel.

# Actiepunten

* Iedereen: opstellen van een kleine use case als procesbeschrijving met input en output. Bijvoorbeeld: identiteitskaart aanvragen, subsidie aanvragen, belastingen innen, ...
* TD: maken van een model voor dienstverlening en dienstverleningdossier op basis van OSLO1.1 en ISA. GT kan vanaf september 2016 hierin ondersteuning bieden.
* RB + DB: terugkomen op de vraag van TT of we semantische definities kunnen toevoegen op reeds bestaande beschrijvingen van dienstverlening bij lokale besturen en de beschrijvingen die onder OSLO² zullen worden opgesteld om ze te kunnen koppelen aan mekaar (bijvoorbeeld identiteitskaart)? Wie zal zich uitspreken over de koppeling?

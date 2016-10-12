---
layout: post
title:  "Thematische Werkgroep Organisaties 1"
categories: organisatie
permalink: /:categories/:year-:month-:day/
---

* TOC
{:toc}

## Details

* Locatie: AIV, Boudewijngebouw, Brussel - D5.01
* Gerelateerde documenten: [Core Public Organisation Vocabulary - Draft 4](https://joinup.ec.europa.eu/asset/cpov/asset_release/core-public-organisation-vocabulary-draft-4)
* Notulen: Dries Beheydt, Dieter De Paepe

### Aanwezigen

| Naam         | Afkorting | Organisatie |
|:-------------|:----------|:------------|
| Gijs Martens | GM        | AIV         |
| Sammy Roos   | SR        | AIV         |
| Jerry Vertriest|JV|AIV|
| Suzy Favere|SF|AIV|
| Thomas D’Haenens|TD|AIV|
| Ward Bemelmans|WB|AIV|
| Ziggy Vanlishout|ZV|AIV|
| Raf Buyle|RB|AIV|
| Raf Vandensande|RV|AIV|
| Geert Thijs|GT|AIV|
| Dieter De Paepe|DDP|iMinds|
| Dries Beheydt|DB|AIV|
| Marie-Kristine Van der Meersch|MVDM||




### Verontschuldigd

Luk Verschooren, Hannes Lombaert, Farah Decamps, Peter Vandenneucker, Maarten Vermeyen, Laurens De Vocht

## Agenda

* Intro: over OSLO en OSLO²
    * Historiek OSLO
    * Het OSLO²-traject
    * Wat gaat OSLO² doen?
    * Scope van OSLO² - schematische voorstelling
* Wat is een kern vocabularium
* Use cases & (kern) vocabularium
* Domeinmodel Wegwijs

## Verslag

### Intro: Over OSLO en OSLO²

Hiervoor verwijzen we naar de [intro pagina over OSLO²]({{site.github.url}}/oslo2/).

### Organisaties

> Discussie

Organisaties worden momenteel zowel federaal (Kruispuntbank van Ondernemingen - KBO) als op Vlaams niveau bijgehouden, waarbij beiden contactinformatie bevatten. Op federaal niveau wordt vooral formele contactinformatie bijgehouden, op het Vlaams niveau worden vooral rollen, locaties en werkelijke contactinformatie bijgehouden.

> Beslissing

In 2016 wil AIV de eerste stappen zetten om een basisregister te maken voor organisaties. In 2017 wordt vervolgens een samenwerking in verband met organisaties gepland met andere overheden.

### Wat is een kern vocabularium

> Discussie

Een kern vocabularium beschrijft een minimale set van context-neutrale termen rond een bepaald thema. Andere partijen kunnen verder bouwen op deze termen voor meer concrete toepassingen. Indien meerdere partijen voortbouwen op dezelfde kern begrippen, vertrekken ze van gelijke definities en is het dus makkelijker om integratie te bekomen.

> Actiepunten

Binnen OSLO² hebben we meerdere groepen die elk een kern vocabularium opstellen rond een bepaald thema. Het is de bedoeling dat deze groepen een permanent karakter krijgen onder aanvoering van een governance orgaan. Binnen deze werkgroepen wordt nagegaan of het voorgestelde kern vocabularium voldoet aan gemeenschappelijke noden.

In eerste instantie is het de bedoeling om de oefening eerst intern te doen (binnen de Vlaamse Overheid), vertrekkend van de behoeftenanalyse die destijds bij de lokale overheden ten tijde van OSLO1 werd opgemaakt. De wereld is immers geëvolueerd sinds 2012.

Wat met andere agentschappen die momenteel niet mee aan tafel zitten? Hoe worden ze erin betrokken en wat zal de impact zijn van hun respons op wat binnen het OSLO²-traject afgesproken werd? Het antwoord op deze vraag, bestaat uit 3 delen die ook terugkomen in de aanpak:

* We starten met de “coalition of the willing” met brede communicatie naar geïnteresseerden en belanghebbenden.
* We mikken op internationaal draagvlak voor onze oefening door de nauwe banden van Informatie Vlaanderen met o.a. ISA(²) en INSPIRE.
* Er wordt een (permanente) governance voorbereid die wordt neergelegd bij het nieuwe stuurorgaan (Vlaamse Dienstenintegrator (VDI) en samenwerkingsverband GDI-Vlaanderen).

Belangrijk is dat het OSLO²-initiatief duidelijk gecommuniceerd wordt richting VDI en GDI zodat er geen initiatief op 2 sporen wordt genomen.

### Use cases & (kern) vocabularium

> Discussie

Enkele use cases die het nut van een kern vocabularium rond organisaties demonstreren:

1. *Informatiedeling* faciliteren met betrekking tot organisaties in de publieke sector.
2. De *integratie* van organisatie-brede IT-systemen.
3. Het scheppen van de condities om tot een *gefedereerde dienstencatalogus* te evolueren (onder impuls van Europa).
4. Het opvolgen van en *inzicht verstrekken* tot de levenscyclus van publieke organisaties. (Het is bijvoorbeeld nodig om te voorzien dat een organisatie met terugwerkende kracht kan worden opgestart. Het onderliggend model moet dit mogelijk maken.)
5. De publieke organisaties *doorzoekbaar maken* naar burgers en ondernemingen toe.

Om te kunnen evolueren naar een basisregister is datakwaliteit en herkomst ook belangrijk. Zo telt KBO bijvoorbeeld organisaties die niet langer bestaan, die omwille van de betalende afsluitprocedure niet up to date zijn.


{% include img_clickable.html alt="Verschillende lagen van een model: kern, domein, informatie uitwisseling." imgpath="organisatie/2016-06-16/model-layers.png" style="height: 200px;" %}

Bij een kern vocabularium is de essentie niet om zo weinig mogelijk velden te hebben, maar juist om zoveel mogelijk velden te hebben waaronder we hetzelfde begrijpen. Rond deze kern staat dan een schil waar je contextuele uitbreidingen voorziet (bijvoorbeeld voor rijksregister, bijvoorbeeld voor onderwijs…). In de derde schil daarrond wordt de (praktische) implementatie gedekt, waarin bepaalde restricties worden ingebouwd. In deze derde laag hoort volgens onze recente inzichten ook het concept “applicatieprofiel” thuis.

Updates aan het kern vocabularium zullen geleid worden door de behoeften van de gebruikers. Het is de bedoeling dat het model stabiel is maar wel, na discussie, kan evolueren in de toekomst. Uitbreidingen kunnen uiteraard toegepast worden zonder problemen te vormen voor bestaande applicaties (wanneer de uitbreidingen niet relevant zijn voor de toepassing in kwestie).

### Domeinmodel Wegwijs

> Discussie

Het overkoepelende project “Wegwijs Vlaamse overheid” wenst de Vlaamse overheid in kaart brengen door kwaliteitsvolle data ter beschikking stellen over organisatiegegevens, informatie en processen. Het luik Wegwijs Organisatie is alvast uitgerold, met het volgende datamodel:

{% include img_clickable.html alt="UML van datamodel Wegwijs Organisatie." imgpath="organisatie/2016-06-16/domeinmodel-wegwijs.jpg" style="height: 500px;" %}

We geven volgende verduidelijkingen bij het model:

* Publieke organisatie: bevat alle kerngegevens met betrekking tot een publieke organisatie.
* Organisatierelaties: organisaties hebben relaties met elkaar (bijvoorbeeld aandeelhouderschap). Op zich hoort dit minder thuis tot de kern van de gegevens van een organisatie.
* Toepassingsgebied: specifiek type van organisatierelatie.
* Gebeurtenis: een onderdeel van de levenscyclus van een organisatie, kaderend binnen een formeel kader. Bijvoorbeeld: een fusie van twee bedrijven. Een erkenning wordt momenteel niet gezien als gebeurtenis. Het valt nog te bekijken of dit hoort in het kern vocabularium.
* Oprichting: de oprichting van een organisatie is zodanig kenmerkend dat het als een subklasse wordt voorzien. De opheffing van een organisatie wordt nog gezien als gebeurtenis.
* Is moederorganisatie van: wordt als aparte relatie opgevat omdat ze vaak voorkomt.
* Contactpunt: slaat niet op een persoon, maar louter contactgegevens zoals e-mail, telefoon, website URL. Openingsuren zijn momenteel niet vervat in contactpunt.
* Geografisch toepassingsgebied: het gebied waar een bevoegdheid over geldt.
* Er komen in dit model geen rollen, mandaten, organen,... voor, deze komen in een apart vocabularium terecht. Ook overgeërfde attributen staan niet in dit model.

Verder stellen we ook nog enkele open vragen:

* Gebeurtenis: hoort een gebeurtenis een aparte entiteit te zijn, of eerder als onderdeel van een organisatie? Of algemener: wanneer moet iets als aparte entiteit gezien worden?
* Publieke organisatie: hoort de keuze van activiteit en bijhorende codes (bijvoorbeeld de NACE-codes) thuis in het vocabularium?
* Wat is de precieze definitie van een publieke organisatie? De ISA core public organisation draft heeft een brede definitie: “it is defined as part of the public sector by a legal framework”.
* Geografisch toepassingsgebied: is dit ook geen soort relatie? Dit heeft immers ook een formeel kader.
* Gebeurtenis: kan een gebeurtenis bij meerdere organisaties horen? Bijvoorbeeld: een fusie heeft betrekking op 2 of meer organisaties.
* Contactpunt en adres worden apart gemodelleerd, wat zijn de concrete gevolgen hiervan? Een adres kan context gebonden zijn, bijvoorbeeld als loket adres of als organisatie adres. Verschillende loketten zouden gemodelleerd worden als verschillende contactpunten. De burgerlijke diensten bus van stad Gent rijdt rond, dus deze heeft wel een e-mail en telefoon, maar geen vast adres.

### Weergave van model OSLO1 in UML

> Discussie

Het OSLO² model zal de blauwdruk worden voor het onderliggende datamodel  van Wegwijs. Binnen deze thematische werkgroep zullen we ons wellicht het best beperken tot het definiëren van het vocabularium.

Binnen OSLO1 heeft een persoon een contact (e-mail, telefoon, fax…). Een persoon is gelinkt met een organisatie via een hoedanigheid (een rol) die zijn eigen contact heeft. Net als bij Wegwijs worden adressen apart beschouwd van contactinformatie. De gebouweenheid was ingevoerd in OSLO1 omdat een adres niet stabiel genoeg beschouwd werd.

{% include img_clickable.html alt="UML van datamodel OSLO1." imgpath="organisatie/2016-06-16/oslo-uml.png" style="height: 500px;" %}

## Actiepunten

1. RB: Paper opstellen met verslag over dynamiek en belang van OSLO²-oefening en de uitwerking van de governance in samenwerking met informatiebeleid.

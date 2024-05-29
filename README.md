# OSLO-Standaarden

This branch should be used to make the data standard available on the [standards registry of Flanders](https://data.vlaanderen.be/standaarden/).

## Structure of this repository

This repository contains four folders to store data standard related information.

### Charter

This folder should contain the OSLO charter. Accepted file formats are Word (`.docx`) or PDF (`.pdf`).

### Descriptions

For each data standard a short description is required that will be displayed on the detail page on the standards registry. Multiple files (descriptions) are allowed, e.g. one for the application profile and one for the vocabulary. The file format must be Markdown (`.md`).

### Presentations

Presentations given by the OSLO Editors during one of the workshop can be stored in this folder. Accepted file format are Powerpoint (`.pptx`) and PDF (`.pdf`).

### Reports

After each workshop a report of that workshop is made by the OSLO Editors, which can be stored in this folder. Accepted file format are Word (`.docx`) and PDF (`.pdf`).

### ap-or-voc-config.json

This is the file that must be used to configure the standard for publication on the standards registry. If the OSLO Editor wants to publish the application profile and vocabulary on the standards registry separately, then **two** configuration files must be created.

## Content of the configuration file

### `title`

This is the name of the data standard, e.g. *Applicatieprofiel LDES* or *Vocabularium Persoon*.

### `category`

The category of the data standard. Allowed values are:
- Applicatieprofiel
- Vocabularium
- Implementatiemodel
- Technische standaard
- Organisatorische interoperabiliteit

### `usage`

Is the usage of the data standard mandatory or recommended? Allowed values are:
- Aanbevolen (vrijwillig)
- Verplicht
- Pas toe of leg uit

### `status`

Different stages of the data standard lifecycle:
- standaard-in-ontwikkeling
- kandidaat-standaard
- erkende-standaard

### `responsibleOrganisation`

The name of the organisation that is responsible for the data standard.

#### `name`

The name of the organisation that is responsible for the data standard

#### `uri`

The uri of the organisation that is responsible for the data standard.

To construct the URI of the organisation, the [Wegwijs application](https://wegwijs.vlaanderen.be/#/organisations) can be used to find the OVO-code (identifier of an organisation). The URI has the following structure `https://data.vlaanderen.be/id/organisatie/{OVO-code}`.

### `publicationDate`

Date on which the most recent version of the standard was published

### `descriptionFileName`

The name of the Markdown file (stored in the `descriptions` folder) that contains the description to be displayed on the standards registry.

### `specificationDocuments`

Links to the application profile(s) or vocabulary. This **must** always be an array of objects with the properties `name` and `uri`.

#### Example
```json
"specificationDocuments": [
    {
        "name": "Applicatieprofiel LDES",
        "uri": "https://data.vlaanderen.be/doc/applicatieprofiel/ldes"
    }
]
```

### `documentation`

Additional documentation to be displayed on the detail page of the data standard, e.g. a mapping described in an Excel file or link to external specification.

This **must** always be an array of objects containing the properties `name` and `resourceReference`. The `resourceReference`property can be used to reference a URI such as `https://example.org/externalSpec` but it can also be a document that was stored in the `documentation` folder. In that case you can write the name of the file.

#### Example
```json
"documentation": [
    {
        "name": "Voorbeeld van een mapping",
        "resourceReference": "mapping-voorbeeld.xlsx"
    },
    {
        "name": "Link naar externe spec",
        "resourceReference": "https://example.org/externalSpec"
    }
]
```

### `charter`

The OSLO charter that will be displayed on the detail page of the data standard. This **must** always be an object containing the properties `name` and `resourceReference`. The `resourceReference`property can be used to reference a URI such as `https://example.org/externalSpec` but it can also be a document that was stored in the `charter` folder. In that case you can write the name of the file.

#### Example
```json
"charter": {
    "name": "OSLO Charter",
    "resourceReference": "oslo-charter.docx"
}
```

### `reports`

Reports made of the workshop to be displayed on the detail page of the data standard.

This **must** always be an array of objects containing the properties `name` and `resourceReference`. The `resourceReference`property can be used to reference a URI such as `https://example.org/externalSpec` but it can also be a document that was stored in the `reports` folder. In that case you can write the name of the file.

#### Example
```json
"reports": [
    {
        "name": "Verslag workshop 1",
        "resourceReference": "verslag-workshop-1.docx"
    }
]
```

### `presentations`

Presentations that were used during the workshop and must be displayed on the detail page of the data standard.

This **must** always be an array of objects containing the properties `name` and `resourceReference`. The `resourceReference`property can be used to reference a URI such as `https://example.org/externalSpec` but it can also be a document that was stored in the `presentations` folder. In that case you can write the name of the file

#### Example
```json
"presentations": [
    {
        "name": "Presentatie workshop 1",
        "resourceReference": "presentatie-workshop-1.pptx"
    },
    {
        "name": "Presentatie workshop 2",
        "resourceReference": "presentatie-workshop-2.pptx"
    }
]
```

### `dateOfRegistration`

The date on which the data standard was announced on the working group 'Data Standards'.

### `dateRecognitionWorkgroup`

The date on which the data standard was accepted as an acknowledged standard by the working group 'Data standards'.

### `dateRecognitionSteeringCommittee`

The date on which the data standard was accepted as an acknowledged standard by the steering committee 'Flemish Information and ICT policy'.


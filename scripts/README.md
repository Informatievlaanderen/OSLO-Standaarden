# Scripts

This directory contains scripts that are used to automate various tasks. The scripts are written in Bash. There are both unused scripts in there that are kept for reference and scripts that are used in the CI/CD pipeline.

## Operational scripts

- checkout.sh
- contributors-and-terms.sh
- copy-to-nuxt.sh
- extract-info.sh
- statistics.sh
- cronjob

### checkout.sh

This script is used to get the information from the OSLO-standards repository. It fetches content from the [standaardenregister.json](https://github.com/Informatievlaanderen/OSLO-Standaarden/blob/configuratie-clean/standaardenregister.json) file to see which standards need to be updated. The script then checks out the repository of the standard, goes to the `standaardenregister` branch and fetches all the required information from that thema-repository.

### contributors-and-terms.sh

This script is an addition to the `statistics.sh` script. It fetches all the contributors and terms from the [data.vlaanderen.be-statistics](https://github.com/Informatievlaanderen/data.vlaanderen.be-statistics) repository and adds them to the statistics.

### copy-to-nuxt.sh

The copy-to-nuxt.sh script is used to copy the generated content to the Nuxt/ webuniversum application [here](https://github.com/Informatievlaanderen/OSLO-Standaardenregister/tree/standaarden). The generated content includes `configuration.json` files, `description.md` files and the `statistics.json` file.

- [] TODO: The current script copies the files to one specific directory. Now that we're planning on supporting i18n, the script should also copy the content to the different language directories in the Nuxt/webuniversum application.

### extract-info.sh

This script is used to extract all the information for all the standards that need to be updated. For each standard, it extracts information from the `standaardenregister` branch inside the thema-repository itself. These files are required later down the line to be sent to the Nuxt/ webuniversum application.

### statistics.sh

This script is used to generate the statistics for the OSLO-standards. It uses a docker image to generate the required statistics.

- [] TODO: This script still uses an older version of a script that is used in the CI/CD pipeline. This script should be updated to use the data coming from the [data.vlaanderen.be-statistics](https://github.com/Informatievlaanderen/data.vlaanderen.be-statistics) repository.

### cronjob

This cronjob is used on the server to update the OSLO-standards every hour. It checks if there is a newer Docker image available and updates the service if needed.

## Deprecated scripts

- markdown-transformer.sh
- sanitize-configurations.sh
- template-renderer.sh

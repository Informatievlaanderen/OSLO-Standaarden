"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const fs_1 = __importDefault(require("fs"));
const path_1 = __importDefault(require("path"));
const GITHUB_BASE_URL = "https://raw.githubusercontent.com/Informatievlaanderen";
const STANDAARDENREGISTER_BRANCH = "standaardenregister";
const DOCUMENTS = "documents";
const REPORTS = "reports";
const PRESENTATIONS = "presentations";
const CHARTER = "charter";
const sanitizeDocument = (document) => {
    try {
        const sanitizedDocument = {};
        sanitizedDocument.name = document === null || document === void 0 ? void 0 : document.naam;
        sanitizedDocument.resourceReference = document === null || document === void 0 ? void 0 : document.waarde;
        return sanitizedDocument;
    }
    catch (error) {
        console.error("Error: unable to sanitize the document", error);
        throw error;
    }
};
const cleanupConfig = (config) => {
    delete config.fileName;
    delete config.status;
    return config;
};
const convertFileToUri = (resourceReference, folder, path) => {
    let uri = `${GITHUB_BASE_URL}/${path}/${STANDAARDENREGISTER_BRANCH}/${folder}/${resourceReference}`;
    return uri;
};
const isUrl = (str) => {
    try {
        if (!str)
            return false;
        const regex = /^https?:\/\/([a-z\d-]+(\.[a-z\d-]+)*\.[a-z]{2,}|(\d{1,3}\.){3}\d{1,3})(:\d+)?(\/\S*)?$/i;
        return regex.test(str);
    }
    catch (error) {
        console.error("Error: unable to validate the url", error);
        throw error;
    }
};
const convertResourceReferenceToUri = (document, folder, path) => {
    var _a;
    const navigationLink = {
        name: document === null || document === void 0 ? void 0 : document.name,
        resourceReference: isUrl(document === null || document === void 0 ? void 0 : document.resourceReference)
            ? document === null || document === void 0 ? void 0 : document.resourceReference
            : convertFileToUri((_a = document.resourceReference) !== null && _a !== void 0 ? _a : "", folder, path),
    };
    return navigationLink;
};
const convertToStandard = (configuration) => {
    var _a, _b, _c, _d, _e;
    const standard = {
        title: configuration === null || configuration === void 0 ? void 0 : configuration.title,
        category: configuration === null || configuration === void 0 ? void 0 : configuration.category,
        usage: configuration === null || configuration === void 0 ? void 0 : configuration.usage,
        status: (_a = configuration.status) !== null && _a !== void 0 ? _a : "TBD",
        descriptionFileName: configuration === null || configuration === void 0 ? void 0 : configuration.descriptionFileName,
        responsibleOrganisation: configuration === null || configuration === void 0 ? void 0 : configuration.responsibleOrganisation,
        publicationDate: configuration === null || configuration === void 0 ? void 0 : configuration.publicationDate,
        specificationDocuments: ((_b = configuration === null || configuration === void 0 ? void 0 : configuration.specificationDocuments) === null || _b === void 0 ? void 0 : _b.map((document) => convertResourceReferenceToUri(document, DOCUMENTS, configuration.repository))) || [],
        documentation: ((_c = configuration === null || configuration === void 0 ? void 0 : configuration.documentation) === null || _c === void 0 ? void 0 : _c.map((document) => convertResourceReferenceToUri(document, DOCUMENTS, configuration.repository))) || [],
        reports: ((_d = configuration === null || configuration === void 0 ? void 0 : configuration.reports) === null || _d === void 0 ? void 0 : _d.map((document) => convertResourceReferenceToUri(document, REPORTS, configuration.repository))) || [],
        charter: convertResourceReferenceToUri(configuration === null || configuration === void 0 ? void 0 : configuration.charter, CHARTER, configuration.repository),
        presentations: ((_e = configuration === null || configuration === void 0 ? void 0 : configuration.presentations) === null || _e === void 0 ? void 0 : _e.map((document) => convertResourceReferenceToUri(document, PRESENTATIONS, configuration.repository))) || [],
        dateOfRegistration: configuration === null || configuration === void 0 ? void 0 : configuration.dateOfRegistration,
        dateOfAcknowledgementByWorkingGroup: configuration === null || configuration === void 0 ? void 0 : configuration.dateOfAcknowledgementByWorkingGroup,
        dateOfAcknowledgementBySteeringCommittee: configuration === null || configuration === void 0 ? void 0 : configuration.dateOfAcknowledgementBySteeringCommittee,
        repository: configuration.repository,
    };
    return standard;
};
const sanitizeOrganisation = (organisatie, identificator) => {
    let sanitized = [];
    if (Array.isArray(organisatie) && Array.isArray(identificator)) {
        for (let i = 0; i < organisatie.length; i++) {
            sanitized.push({
                name: organisatie[i],
                resourceReference: identificator[i],
            });
        }
    }
    else {
        sanitized.push({
            name: organisatie,
            resourceReference: identificator,
        });
    }
    return sanitized;
};
// Convert values into TRUE/FALSE statements for validation of the fields
// TODO: Can this be done cleaner?
const sanitizeConfiguration = (configuration) => {
    var _a, _b, _c, _d, _e;
    const sanitizedConfiguration = {
        title: configuration === null || configuration === void 0 ? void 0 : configuration.naam,
        category: configuration === null || configuration === void 0 ? void 0 : configuration.categorie,
        usage: configuration === null || configuration === void 0 ? void 0 : configuration.type_toepassing,
        responsibleOrganisation: sanitizeOrganisation(configuration.verantwoordelijke_organisatie, configuration.identificator_organisatie),
        publicationDate: configuration === null || configuration === void 0 ? void 0 : configuration.publicatiedatum,
        descriptionFileName: configuration === null || configuration === void 0 ? void 0 : configuration.beschrijving,
        specificationDocuments: ((_a = configuration === null || configuration === void 0 ? void 0 : configuration.specificatiedocument) === null || _a === void 0 ? void 0 : _a.map((document) => sanitizeDocument(document))) || [],
        documentation: ((_b = configuration === null || configuration === void 0 ? void 0 : configuration.documentatie) === null || _b === void 0 ? void 0 : _b.map((document) => sanitizeDocument(document))) || [],
        charter: !!((_c = configuration === null || configuration === void 0 ? void 0 : configuration.charter) === null || _c === void 0 ? void 0 : _c.length)
            ? sanitizeDocument(configuration === null || configuration === void 0 ? void 0 : configuration.charter[0])
            : {},
        reports: ((_d = configuration === null || configuration === void 0 ? void 0 : configuration.verslagen) === null || _d === void 0 ? void 0 : _d.map((document) => sanitizeDocument(document))) || [],
        presentations: ((_e = configuration === null || configuration === void 0 ? void 0 : configuration.presentaties) === null || _e === void 0 ? void 0 : _e.map((document) => sanitizeDocument(document))) || [],
        dateOfRegistration: configuration === null || configuration === void 0 ? void 0 : configuration.datum_van_aanmelding,
        dateOfAcknowledgementByWorkingGroup: configuration === null || configuration === void 0 ? void 0 : configuration.erkenning_werkgroep_datastandaarden,
        dateOfAcknowledgementBySteeringCommittee: configuration === null || configuration === void 0 ? void 0 : configuration.erkenning_stuurgroep,
        fileName: configuration === null || configuration === void 0 ? void 0 : configuration.fileName,
        status: configuration.status,
        repository: configuration.repository,
    };
    return sanitizedConfiguration;
};
const writeStandard = (standard, dir, innerFile) => __awaiter(void 0, void 0, void 0, function* () {
    const directoryPath = path_1.default.join("/tmp/workspace/nuxt-sanitized", dir);
    try {
        // Ensure the directory exists
        yield fs_1.default.promises.mkdir(directoryPath, { recursive: true });
        // Convert the object to a JSON string with indentation
        const data = JSON.stringify(standard, null, 2);
        // Write the data to a file in the new directory
        yield fs_1.default.promises.writeFile(path_1.default.join(directoryPath, innerFile), data, "utf8");
    }
    catch (err) {
        console.error("An error occurred:", err);
    }
});
const sanitizeAndReadConfigurations = () => __awaiter(void 0, void 0, void 0, function* () {
    try {
        console.log("Sanitizing configurations...");
        let standards = [];
        const directoryPath = "/tmp/workspace/nuxt";
        const dirs = yield fs_1.default.promises.readdir(directoryPath);
        const promises = dirs.map((dir) => __awaiter(void 0, void 0, void 0, function* () {
            const fullPath = path_1.default.join(directoryPath, dir);
            const stats = yield fs_1.default.promises.stat(fullPath);
            if (stats.isDirectory()) {
                const innerFiles = yield fs_1.default.promises.readdir(fullPath);
                for (const innerFile of innerFiles) {
                    const fullPathToFile = path_1.default.join(fullPath, innerFile);
                    console.log(innerFile, "innerFile");
                    const destinationPath = path_1.default.join("/tmp/workspace/nuxt-sanitized", dir, innerFile);
                    console.log(destinationPath, "destinationPath");
                    if (path_1.default.extname(innerFile) === ".json") {
                        const data = yield fs_1.default.promises.readFile(fullPathToFile, "utf8");
                        try {
                            const configuration = JSON.parse(data);
                            const standard = convertToStandard(cleanupConfig(sanitizeConfiguration(configuration)));
                            console.log(standard, "standard");
                            standards.push(standard);
                            yield writeStandard(standard, dir, innerFile);
                        }
                        catch (err) {
                            console.error("Error parsing JSON:", err);
                        }
                    }
                    else if (path_1.default.extname(innerFile) === ".md") {
                        try {
                            yield fs_1.default.promises.copyFile(fullPathToFile, destinationPath);
                        }
                        catch (err) {
                            console.error("Error copying .md file:", err);
                        }
                    }
                }
            }
        }));
        yield Promise.all(promises);
    }
    catch (err) {
        console.error("An error occurred:", err);
    }
});
sanitizeAndReadConfigurations();

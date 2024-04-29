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
// Convert values into TRUE/FALSE statements for validation of the fields
// TODO: Can this be done cleaner?
const sanitizeConfiguration = (configuration) => {
    var _a, _b, _c, _d, _e;
    const sanitizedConfiguration = {
        title: configuration === null || configuration === void 0 ? void 0 : configuration.naam,
        category: configuration === null || configuration === void 0 ? void 0 : configuration.categorie,
        usage: configuration === null || configuration === void 0 ? void 0 : configuration.type_toepassing,
        responsibleOrganisation: {
            name: configuration === null || configuration === void 0 ? void 0 : configuration.verantwoordelijke_organisatie,
            uri: configuration === null || configuration === void 0 ? void 0 : configuration.identificator_organisatie,
        },
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
    };
    return sanitizedConfiguration;
};
const writeSanitizedConfiguration = (sanitizedConfiguration, dir, innerFile) => __awaiter(void 0, void 0, void 0, function* () {
    const directoryPath = path_1.default.join(__dirname, 'nuxt-sanitized/standaarden', dir);
    try {
        // Ensure the directory exists
        yield fs_1.default.promises.mkdir(directoryPath, { recursive: true });
        // Convert the object to a JSON string with indentation
        const data = JSON.stringify(sanitizedConfiguration, null, 2);
        // Write the data to a file in the new directory
        yield fs_1.default.promises.writeFile(path_1.default.join(directoryPath, innerFile), data, 'utf8');
    }
    catch (err) {
        console.error('An error occurred:', err);
    }
});
const sanitizeAndReadConfigurations = () => __awaiter(void 0, void 0, void 0, function* () {
    try {
        console.log('Sanitizing configurations...');
        let sanitizedConfigurations = [];
        const directoryPath = path_1.default.join(__dirname, 'nuxt/');
        const dirs = yield fs_1.default.promises.readdir(directoryPath);
        const promises = dirs.map((dir) => __awaiter(void 0, void 0, void 0, function* () {
            const fullPath = path_1.default.join(directoryPath, dir);
            const stats = yield fs_1.default.promises.stat(fullPath);
            if (stats.isDirectory()) {
                const innerFiles = yield fs_1.default.promises.readdir(fullPath);
                for (const innerFile of innerFiles) {
                    const fullPathToFile = path_1.default.join(fullPath, innerFile);
                    const destinationPath = path_1.default.join(__dirname, 'nuxt-sanitized/standaarden', dir, innerFile);
                    if (path_1.default.extname(innerFile) === '.json') {
                        const data = yield fs_1.default.promises.readFile(fullPathToFile, 'utf8');
                        try {
                            const configuration = JSON.parse(data);
                            const sanitizedConfiguration = cleanupConfig(sanitizeConfiguration(configuration));
                            sanitizedConfigurations.push(sanitizedConfiguration);
                            yield writeSanitizedConfiguration(sanitizedConfiguration, dir, innerFile);
                        }
                        catch (err) {
                            console.error('Error parsing JSON:', err);
                        }
                    }
                    else if (path_1.default.extname(innerFile) === '.md') {
                        try {
                            yield fs_1.default.promises.copyFile(fullPathToFile, destinationPath);
                        }
                        catch (err) {
                            console.error('Error copying .md file:', err);
                        }
                    }
                }
            }
        }));
        yield Promise.all(promises);
        console.log(sanitizedConfigurations);
    }
    catch (err) {
        console.error('An error occurred:', err);
    }
});
sanitizeAndReadConfigurations();

import type {Config} from 'jest';

const config: Config = {
    preset: "ts-jest",
    testRegex: "\\.(test|e2e)\\.ts$",
    moduleFileExtensions: ["ts", "js", "json"],
    transform: {
        "^.+\\.(ts|tsx)$": "ts-jest"
    },
    setupFilesAfterEnv: [],
    collectCoverageFrom: ["src/**/*.ts", "!src/index.ts"],
    coveragePathIgnorePatterns: [],
    coverageReporters: ["text", "text-summary", "lcov"],
    coverageThreshold: {
        "global": {
            "branches": 85,
            "lines": 85
        }
    },
};

export default config;
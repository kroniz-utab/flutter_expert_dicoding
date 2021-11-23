# Ditonton Apps

[![Codemagic build status](https://api.codemagic.io/apps/61976348e2c8da10e24cf4b6/61976348e2c8da10e24cf4b5/status_badge.svg)](https://codemagic.io/apps/61976348e2c8da10e24cf4b6/61976348e2c8da10e24cf4b5/latest_build)
[![codecov](https://codecov.io/gh/kroniz-utab/flutter_expert_dicoding/branch/main/graph/badge.svg?token=DSE65DEOM8)](https://codecov.io/gh/kroniz-utab/flutter_expert_dicoding)

## Submission Requirements

- [x] Implements Continous Integration on project (Using [CodeMagic](https://codemagic.io/apps/61976348e2c8da10e24cf4b6/61976348e2c8da10e24cf4b5/latest_build))
- [x] Using Bloc Library
- [x] Implements SSL Pinning
- [x] Integration with Firebase [Analytics](https://github.com/kroniz-utab/flutter_expert_dicoding/blob/main/submission/firebase/firebase_analytics.png) & [Crashlytics](https://github.com/kroniz-utab/flutter_expert_dicoding/blob/main/submission/firebase/firebase_crashlytics.png)

## Submission Optional

- [x] Modularization (at least 2 feature)
- [x] Add Season feature
- [x] > 95% test coverage (can see through [local test](https://github.com/kroniz-utab/flutter_expert_dicoding/blob/main/submission/local_coverage/local_coverage_result.png) or via [Codecov](https://codecov.io/gh/kroniz-utab/flutter_expert_dicoding))

## How to Run Local Test

- **For Linux/MacOS**

  - Coverage test for all feature local

    ```bash
    sudo chmod +x combine-test-coverage.sh
    ./combine-test-coverage.sh
    ```

  - Generate Html Report

    ```bash
    genhtml coverage/lcov.info -o coverage/html
    ```

  you must install `genhtml` first, if you not installed yet, you can follow this [step](https://stackoverflow.com/questions/50789578/how-can-the-code-coverage-data-from-flutter-tests-be-displayed)

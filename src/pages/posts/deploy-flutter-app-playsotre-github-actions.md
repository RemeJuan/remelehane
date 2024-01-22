---
stackbit_url_path: posts/deploy-flutter-app-playsotre-github-actions
title: "Deploying Flutter Application with Github Actions (PlayStore)"
date: '2023-06-19T09:00:00.000Z'
excerpt: >-
tags:
  - flutter
  - github
  - cicd
  - flutterdevelopment
template: post
thumb_img_path: https://img.freepik.com/free-vector/mobile-app-development-composition-with-flowchart-isometric-platforms-application-icons-human-characters-text-captions-vector-illustration_1284-77306.jpg?size=626&ext=jpg&ga=GA1.1.2116175301.1701561600&semt=ais
cover_image: https://img.freepik.com/free-vector/mobile-app-development-composition-with-flowchart-isometric-platforms-application-icons-human-characters-text-captions-vector-illustration_1284-77306.jpg?size=626&ext=jpg&ga=GA1.1.2116175301.1701561600&semt=ais
published_at: '2023-06-19T09:00:00.000Z'
canonical_url: https://remelehane.dev/posts/deploy-flutter-app-playsotre-github-actions/
---

![](https://img.freepik.com/free-vector/mobile-app-development-composition-with-flowchart-isometric-platforms-application-icons-human-characters-text-captions-vector-illustration_1284-77306.jpg?size=626&ext=jpg&ga=GA1.1.2116175301.1701561600&semt=ais)

‍

Image Source: FreeImages

Introduction
------------

As Flutter continues to gain popularity among developers, the need for efficient and streamlined deployment processes has become paramount. One powerful tool that can help in this regard is Github Actions, a continuous integration and continuous delivery (CI/CD) platform provided by GitHub. In this guide, we will explore how to deploy a Flutter application using Github Actions, step by step. We will cover everything from setting up the workflow to signing and deploying the app on the Play Store.

Enabling Github Actions and Setting up the Workflow
---------------------------------------------------

To start leveraging the power of Github Actions for deploying your Flutter application, you need to enable it for your repository. Once enabled, you can add a workflow file that defines the steps and actions to be performed during the deployment process.

1.  Create a `.github/workflows` directory at the root of your project.
2.  In the `.github/workflows` directory, create a file named `build.yml`.
3.  Copy the following instructions into the `build.yml` file:

```yaml
# Name of the workflow
name: Build

# Controls what will trigger the workflow. Change it to your needs.
on:
  # A new push to the "main" branch.
  push:
    branches: [ "main" ]
  # A new pull request to the "main" branch.
  pull_request:
    branches: [ "main" ]
  # Allows to trigger the workflow from GitHub interfaces.
  workflow_dispatch:

# A single workflow can have multiple jobs.
jobs:
  # 'A new job is defined with the name: "build_android"
  build_android:
    # Defines what operating system will be used for the actions.
    # For android, we will use Linux GitHub-Hosted Runner.
    runs-on: ubuntu-22.04

    # Defines what step should be passed for successful run
    steps:
      # Checkout to the selected branch
      - name: Checkout
        uses: actions/checkout@v3

      # Download and install flutter packages
      - name: Install Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: "3.10.0" # Change to the version you use in your project

```

Make sure to customize the workflow file according to your project's specific needs, such as branch names and Flutter versions.

Building the App and Generating an Unsigned App Bundle
------------------------------------------------------

Once you have set up the workflow, the next step is to build your Flutter application and generate an unsigned App Bundle. The App Bundle is a publishing format that contains all the compiled code and resources of your app, optimized for distribution on the Google Play Store.

To build the app and generate the unsigned App Bundle, follow these steps:

1.  Remove the release build type 'signingConfig signingConfigs.debug' from `./android/app/build.gradle`.
2.  Add the following code to your workflow file:

```yaml
# Build release app bundle
- name: Build release app bundle
  run: flutter build appbundle
```

This command will build the app and generate an unsigned App Bundle in the output directory of your project. This step ensures that every time you push a new commit, a new unsigned App Bundle is generated.

Signing the App Bundle
----------------------

Before you can deploy your app to the Play Store, you need to sign the App Bundle with a signing key. Signing the app bundle ensures the integrity and authenticity of your app.

To sign the App Bundle, follow these steps:

1.  Generate a signing key using the `keytool` command. This key will be used to sign the App Bundle. For example:

`keytool -genkey -v -keystore mykey.keystore -alias mykey -keyalg RSA -keysize 2048 -validity 10000`  

2.  Encode the keystore file as base64. You can use the following command:

`base64 -i ./mykey.keystore -o ./keystore-base64.txt  `

3.  Add the base64 encoded keystore file, along with other necessary information, as secrets in your GitHub repository. Make sure to remove any spaces when adding the secrets.
4.  In your workflow file, add the following code to sign the App Bundle:

```yaml
# Sign App Bundle
- name: Sign App Bundle
  uses: r0adkll/sign-android-release@v1
  id: sign_app
  with:
    releaseDirectory: build/app/outputs/bundle/release/
    signingKeyBase64: ${{ secrets.KEYSTORE_BASE64 }}
    alias: ${{ secrets.KEY_ALIAS }}
    keyStorePassword: ${{ secrets.KEYSTORE_PASSWORD }}
    keyPassword: ${{ secrets.KEY_PASSWORD }}
```

Replace the secret names (`KEYSTORE_BASE64`, `KEY_ALIAS`, `KEYSTORE_PASSWORD`, `KEY_PASSWORD`) with the respective secrets you added to your repository.

Deploying the App to the Play Store
-----------------------------------

Now that you have a signed App Bundle, you can proceed with deploying your Flutter app to the Play Store. The Play Store is the primary distribution platform for Android apps.

To deploy the app to the Play Store, follow these steps:

1.  Create a service account on Google Cloud Console and download the service account JSON file.
2.  Add the service account JSON as a secret in your GitHub repository.
3.  Enable the Google Play Android Developer API.
4.  In your workflow file, add the following code to upload the signed App Bundle to the Play Store:

```yaml
# Upload to Play Store (Internal Testing)
- name: Upload to Play Store (Internal Testing)
  uses: r0adkll/upload-google-play@v1.0.18
  with:
    serviceAccountJsonPlainText: ${{ secrets.SERVICE_ACCOUNT_JSON }}
    packageName: com.example.app
    releaseFiles: ${{ steps.sign_app.outputs.signedReleaseFile }}
    mappingFile: ./build/app/outputs/mapping/release/mapping.txt
    track: internal
```

Replace `com.example.app` with your app's package name and `SERVICE_ACCOUNT_JSON` with the name of the secret containing the service account JSON.

Conclusion
----------

In this comprehensive guide, we have covered the process of deploying a Flutter application using Github Actions. From enabling Github Actions and setting up the workflow to signing the app bundle and deploying it to the Play Store and App Store, we have explored the entire deployment pipeline. By leveraging the power of Github Actions, you can automate and streamline your deployment process, saving time and effort. We hope this guide has provided you with the knowledge and tools to successfully deploy your Flutter app with ease. Happy deploying!

---

*  [Deploying a Flutter Application on Azure Pipelines: A Comprehensive Guide](https://remelehane.dev/posts/deplying-flutter-application-azure/)
*  [The Power of Flutter: Creating Cross-Platform Applications](https://remelehane.dev/posts/the-power-of-flutter/)
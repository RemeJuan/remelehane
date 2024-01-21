---
stackbit_url_path: posts/automated-flutter-unit-testing-with-github-actions
title: "Automating Unit Testing for Your Flutter Project with GitHub Actions"
date: '2023-02-20T09:00:00.000Z'
excerpt: >-
tags:
  - flutter
  - flutterweb
  - unittesting
  - githubactions
template: post
thumb_img_path: https://images.unsplash.com/photo-1556075798-4825dfaaf498?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8bG9naWN8ZW58MHx8MHx8fDA%3D
Cover_image: https://images.unsplash.com/photo-1556075798-4825dfaaf498?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8bG9naWN8ZW58MHx8MHx8fDA%3D
published_at: '2023-02-20T09:00:00.000Z'
canonical_url: https://remelehane.dev/posts/automated-flutter-unit-testing-with-github-actions/
---

![](https://images.unsplash.com/photo-1556075798-4825dfaaf498?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8bG9naWN8ZW58MHx8MHx8fDA%3D)

Image Source: Unsplash

In the world of software development, ensuring the quality and reliability of your code is paramount. One way to achieve this is through automated unit testing. By automating the process of running tests on your code, you can catch issues early, prevent broken code from going into production, and improve overall code quality. In this article, we will explore how you can use GitHub Actions to automate unit testing for your Flutter project.

What is GitHub Actions?
-----------------------

GitHub Actions is a powerful workflow automation tool provided by GitHub. It allows you to define custom workflows that can be triggered by various events, such as code pushes, pull requests, or manual triggers. With GitHub Actions, you can automate tasks and processes within your software development workflow, including building, testing, and deploying your code.

Setting Up the Workflow
-----------------------

To get started with automating unit testing for your Flutter project, you'll need to define a workflow in your GitHub repository. The workflow is written in YAML format and consists of a series of steps to be executed. Let's take a look at an example workflow:

```yaml
name: Flutter Testing
on:
  workflow_dispatch:
  pull_request:
    branches: [main]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2.3.4
      - uses: subosito/flutter-action@v1.5.3
      - name: Install packages
        run: flutter pub get
      - name: Run generator
        run: flutter pub run build_runner build
      - name: Run test
        run: flutter test test
```

In this example, we define a workflow called "Flutter Testing" that will be triggered on both `workflow_dispatch` (manual trigger) and when a pull request is made against the `main` branch. The workflow consists of a single job called "test" that runs on the `ubuntu-latest` environment.

Understanding the Workflow
--------------------------

Now let's take a closer look at each step in the workflow and understand what it does.

### Step 1: Checkout the Code

The first step in the workflow is to check out the code into the instance of the action. This is done using the `actions/checkout` action:

```yaml
- uses: actions/checkout@v2.3.4
```

By checking out the code, we ensure that the subsequent steps have access to the latest version of the codebase.

### Step 2: Installing Flutter

Since we are working with a Flutter project, we need to install Flutter into the instance. This is done using the `subosito/flutter-action` action:

```yaml 
- uses: subosito/flutter-action@v1.5.3
```

By default, this action installs the latest stable release of Flutter. However, you can configure it to use a different release or even pin it to a specific version.

### Step 3: Installing Packages

Next, we need to install all the required packages for our Flutter project. This is done by running the following command:

```yaml
- name: Install packages
  run: flutter pub get
```

This step ensures that all the necessary dependencies are installed and ready for testing.

### Step 4: Running Code Generation (Optional)

If your project makes use of code generation, you can include a step to run the code generator. This step is optional and can be skipped if your project doesn't require code generation. Here's an example:

```yaml
- name: Run generator
  run: flutter pub run build_runner build
```

Running the code generator will generate code based on annotations in your project, such as serializers, routes, or database models.

### Step 5: Running Unit Tests

Finally, we come to the most important step—running the unit tests for your Flutter project. This is done using the following command:

```yaml
- name: Run test
  run: flutter test test
```

 This command runs all the tests located in the `test` directory of your project. You can customize the path if your tests are located in a different directory.

Running the Workflow
--------------------

Once you have defined your workflow, it will be automatically triggered whenever a pull request is made against the `main` branch or manually triggered using the GitHub Actions interface. The workflow will run on the specified environment (in this case, `ubuntu-latest`) and execute each step in the defined order.

The time it takes to run the automated tests will depend on the size and complexity of your project. Smaller projects with a handful of files may complete in just over a minute, while larger projects with thousands of files and extensive test coverage may take several minutes to complete.

Conclusion
----------

Automating unit testing for your Flutter project using GitHub Actions is a simple yet powerful way to ensure code quality and prevent issues from reaching production. By defining a workflow and specifying the necessary steps, you can easily run tests on your code with every push or pull request. This helps catch bugs early, improves overall code quality, and gives you confidence in the reliability of your codebase.

If you have any questions, comments, or improvements, feel free to drop a comment below. Happy testing and enjoy your Flutter development journey!

****

-  [Getting creative with Shorebird](https://remelehane.dev/posts/getting-creative-with-shorebird/)
-  [Essential Tools for Flutter Developers: Boosting Productivity and Efficiency](https://remelehane.dev/posts/essential-tools-for-a-flutter-developer/)

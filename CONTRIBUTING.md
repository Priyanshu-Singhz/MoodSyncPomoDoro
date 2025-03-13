# Contributing to MoodSync

Thank you for your interest in contributing to MoodSync! This document provides guidelines and instructions to help you contribute effectively to this project.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [How to Contribute](#how-to-contribute)
  - [Reporting Bugs](#reporting-bugs)
  - [Suggesting Features](#suggesting-features)
  - [Pull Requests](#pull-requests)
- [Development Setup](#development-setup)
- [Coding Standards](#coding-standards)
- [Commit Guidelines](#commit-guidelines)
- [Testing](#testing)
- [Documentation](#documentation)
- [Community](#community)

## Code of Conduct

By participating in this project, you are expected to uphold our Code of Conduct. Please report unacceptable behavior to the project maintainers.

## Getting Started

1. Fork the repository on GitHub
2. Clone your fork locally:
   ```bash
   git clone https://github.com/yourusername/MoodSync.git
   cd MoodSync
   ```
3. Add the original repository as an upstream remote:
   ```bash
   git remote add upstream https://github.com/originalusername/MoodSync.git
   ```
4. Create a branch for your work:
   ```bash
   git checkout -b feature/your-feature-name
   ```

## How to Contribute

### Reporting Bugs

If you find a bug in the application, please submit a detailed bug report by creating an issue in the GitHub repository. Please include:

- A clear and descriptive title
- Steps to reproduce the issue
- Expected behavior
- Actual behavior
- Screenshots if applicable
- Device information (iOS and watchOS version, device model)
- Any additional context that might be helpful

### Suggesting Features

We welcome feature suggestions! To suggest a new feature:

1. Check existing issues to ensure your suggestion hasn't already been proposed
2. Create a new issue with the "feature request" label
3. Clearly describe the feature and its potential benefits
4. Include any mockups or examples if possible

### Pull Requests

1. Ensure your code adheres to the project's coding standards
2. Update documentation as needed
3. Add tests for new features
4. Make sure all tests pass
5. Submit a pull request to the `develop` branch
6. Reference any related issues in your pull request description

## Development Setup

To set up your development environment:

1. Ensure you have Xcode 13.0 or later installed
2. Install required dependencies:
   ```bash
   # If using CocoaPods
   pod install
   ```
3. Open the project:
   ```bash
   open MoodSync.xcworkspace # If using CocoaPods
   # or
   open MoodSync.xcodeproj
   ```

## Coding Standards

- Follow Swift style guidelines
- Use SwiftUI best practices
- Maintain proper code organization
- Write clear, descriptive comments
- Use meaningful variable and function names
- Keep functions focused and concise

## Commit Guidelines

- Use clear, descriptive commit messages
- Begin commit messages with a short summary (50 chars or less)
- Reference issue numbers in commit messages when applicable
- Separate subject from body with a blank line
- Use the body to explain what and why vs. how

Example:
```
Add mood transition animations (#42)

Implemented smooth transitions between mood states with appropriate
color changes and UI feedback. This enhances the user experience
when switching between different emotional states.
```

## Testing

- Write unit tests for new functionality
- Ensure existing tests pass before submitting pull requests
- Test on multiple device sizes when implementing UI changes
- Test Apple Watch connectivity features on actual devices when possible

## Documentation

- Document all public APIs and complex functions
- Update README.md when adding significant features
- Add comments explaining complex logic
- Keep documentation up to date with code changes

## Community

- Be respectful and inclusive in discussions
- Help others who have questions
- Share your knowledge and insights
- Provide constructive feedback on issues and pull requests

Thank you for contributing to MoodSync!

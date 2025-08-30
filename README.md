# kata_calculator

# 🧮 String Calculator - Flutter

A Flutter implementation of the classic **String Calculator Kata**, built with **Test-Driven Development (TDD)** principles and full testing coverage.

---

## 📌 Features

- Add numbers from a string input.
- Supports **multiple delimiters** (comma-separated) of any length.
- Handles negative numbers with exceptions listing all negatives.
- Ignores numbers larger than 1000.
- Tracks how many times `Add()` has been called.
- Custom input via UI with on-screen numeric and delimiter buttons.
- Fully tested: unit tests, widget tests, and integration tests.

---

## 💻 How It Works

- Enter numbers in a `TextField`, separated by delimiters.
- Optionally, enter custom delimiters in a comma-separated format, e.g., `;,%`.
- Press **Calculate** to get the sum.
- Negative numbers throw an exception listing all negatives.
- Numbers larger than 1000 are ignored.

---

## 🖼️ Demo

![Calculator Demo](assets/Screen%20Recording%202025-08-30%20at%2002.24.37.gif)  
*GIF showing adding numbers, using custom delimiters, and displaying results.*

---

## 🧩 Installation

```bash
git clone https://github.com/obiech/string_calculator_flutter.git
flutter pub get
flutter run

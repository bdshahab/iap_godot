## In-App Purchasing with Cryptocurrency
## ⚠️ Project Status: Discontinued

This project has been officially discontinued and is no longer under active development.

## Reasons for Discontinuation

Many websites restrict or block automated data access, limiting the reliability of this system.

Free API (Application Programming Interface) tiers often have strict rate limits and usage constraints.

Independent developers without a large market face limited monetization opportunities.

From a practical business perspective, advertisement-based models are generally more sustainable than cryptocurrency-based in-app purchases for small-scale projects.

## 📌 About This Project

This project introduced a simple method for enabling in-app purchases using cryptocurrencies, without relying on traditional banking systems or app store payment processors.

The goal was to provide an alternative payment solution for developers who may face restrictions with conventional financial systems.

## 🗂 Previous Implementations

Older versions and related implementations are still available for reference:

Python (PySide6): https://github.com/bdshahab/iap_qt

Python (tkinter): https://github.com/bdshahab/iap_tkinter

Defold Asset: https://defold.com/assets/crypto_iap

Godot Asset: https://godotengine.org/asset-library/asset/3158

## 🎥 Demonstration Video

A video explaining this method:
https://youtu.be/SaU_2sguvbk

## ⚙️ How the Method Worked

The developer sets a base price in USD inside the application.

When the app runs, it converts the price to the selected cryptocurrency using current exchange rates.

The user selects a payment method (cryptocurrency).

The app displays:

The exact payment amount

The wallet address

A limited time window for payment

The user sends the exact amount to the provided wallet address.

The user copies and submits the transaction ID (TXID / Transaction Hash).

The application verifies the transaction using public blockchain tracking services.

If validated within the time limit, the purchase is accepted.

## 🌍 Concept and Motivation

This system was designed to:

Provide an alternative payment method independent of traditional financial institutions.

Allow global accessibility without geographic restrictions.

Reduce dependency on intermediaries such as banks and app stores.

Avoid commission fees charged by third-party platforms.

Enable developers to receive payments directly.

## 🔄 Price Handling

Cryptocurrency prices were retrieved from public price-tracking websites.

If the price source was unavailable, a default price list was included in this repository.

Default price files were stored in the default_prices directory.

## 🔑 Remote Configuration

Key operational data could be updated through a special configuration file:

key_data.txt

This allowed quick updates and issue resolution without requiring users to download a new version of the application.

## 📖 Final Note

Although this project is no longer maintained, the repository remains available for educational and reference purposes.


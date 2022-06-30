---
title: Currency in Optima
layout: optima_layout
description: Describes how Optima handles currency in billing data
---

## Overview

This page describes how currency is handled in Optima billing information.

At a high-level, Optima currently **does not support** currency conversion in the product. Every data point consumed from billing data is consumed as a **number**, with no regard for the currency information in the data. Although the USD `$` is shown in the UI by default, that does not indicate that the source data was in USD nor that any currency conversion was applied.

## Non-USD bills

If a non-USD bill is encountered by Optima, the "numbers" from the bill are read, stored, and processed with no conversion. By default, the UI will show these numbers with a USD `$` sign, but it is only processing the data as "numbers", not as the source bill currency.

If multiple bill sources are provided to Optima in different currencies, the numbers are added together with no conversion occurring. This can lead to inaccurate numbers in Optima as two different currencies are being summed as if the conversion between them was 1:1.

If you have multiple bills with different currencies, please contact your account manager to discuss options that can provide cost reporting without mixing numbers of two different currencies.

## Currency symbols in Optima

As discussed above, Optima processes all data as simple numbers, with no regard for the currency. When displaying these numbers back to users, Optima defaults to using the USD `$` standard, regardless of the actual source data currency.

The default currency symbol (and decimal formatting) can be modified to any standard currency. Note that this does not do any kind of conversion, it simply changes the currency symbol shown in the UI. This option is ideal when an organization's bills are all of the same currency and that currency is not USD.

To change the default currency symbol, please [contact support](mailto:support@rightscale.com) and provide the RightScale organization ID/name and the [3-letter currency code](https://www.iban.com/currency-codes.html) that you would like to see in Optima for that organization.

!!warning*Note*Changing the currency symbol does NOT convert currencies, it only changes the symbol and decimal format displayed in the UI.

## Currency situations and use cases

If you are wondering what your options are with Optima if you use non-USD currencies, please consult the table below:

Situation | Solution
--------- | --------
All cloud provider bills are provided in USD | No action needed. Optima shows USD `$` as the default currency symbol
All cloud provider bills are provided in non-USD currency and are all the same currency | [Contact support](mailto:support@rightscale.com) to request a change to your default currency symbol in Optima
Cloud provider bills are provided in differing currencies | Consider using Optima [Bill Adjustments](./bill_adjustments.html) to convert to a single currency

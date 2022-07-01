---
title: Compatibility Release - 11H1
layout: cm_layout
description: RightScale's Compatibility Release combines stringent internal processes and a simple naming convention to help our customers and partners understand compatibility and dependency information surrounding RightScale components.
---

## Overview

RightScale's Compatibility Release combines stringent internal processes and a simple naming convention to help our customers and partners understand compatibility and dependency information surrounding RightScale components (e.g. ServerTemplates, RightScripts and MultiCloud Images). There are two General Availability (GA) Compatibility Releases per year that include fully tested RightScale components. Individual RightScale components may be released on a more frequent basis.

## Benefits

* Less confusion on compatibilities and dependencies between ServerTemplates, RightScripts / Chef Recipies, and MultiCloud Images. All ServerTemplates include the same MultiCloud Image options, as well as the same Frozen Repository date. This makes it easier to move scripts around ServerTemplates within a compatibility release without risking errors from package discrepancies and other broken dependencies.

* A naming convention that applies to all published components of a Compatibility Release. A simple glance will indicate which other ServerTemplates, scripts, and MultiCloud Images may be compatible.

* A base ServerTemplate that can be used as a starting point for new template development. It contains the RightScripts that are part of every RightScale ServerTemplate to enable monitoring, logging and other basic system setup.

* Improved compatibility for our customers and with our partners who adopt the base ServerTemplate for their own development and publications.

## Naming Convention

### Labels

Labels are included in the naming convention. ServerTemplates go through individual alpha and beta phases before being added to the Compatibility Release. *Only GA components can be added to a Compatibility Release*.

* a - alpha
* b - beta
* rc - Release Candidate

### Compatibility Release

Compatibility Releases are issued twice per year. The naming convention uses the year, and which half of the year.

* YY - Last two digits of the year. (For example, 10 for 2010, 11 for 2011, etc.)
* H1 - First half of the year
* H2 - Second half of the year

Examples:

* 11H1 - Compatibility Release for 1st half of 2011.
* 11H2 - Compatibility Release for 2nd half of 2011.

### Intra-Compatibility Release

Individual RightScale components often have additional independent releases within the larger 6 month span of the full Compatibility Release. For example, various ServerTemplates, RightScripts and MCI's could contain the following within their name:

* 11H1.a1 - Indicates 1st alpha for Compatibility Release 11H1
* 11H1.b2 - Indicates 2nd beta for Compatibility Release 11H1
* 11H2.rc - Indicates release candidate for Compatibility Release 11H2

### Example Progression

* Finish and release 10H2 at the end of 2010
* Start 11H1 sometime during winter 2010
* 11H1.b1 - Work on several beta releases... (four shown below)
* 11H1.b2
* 11H1.b3
* 11H1.b4
* 11H1.rc - Release candidate, only bug fixes expected
* 11H1 - Compatibility Release 11H1 is packaged and released as Generally Available (GA)

**Important!** MCIs are often built on top of production ready GA images. The "b" (for beta) is only in the MCI name due to its inclusion in the Compatibility Release beta. If images are not marked as "\_BETA", you may use these MCIs in production outside of the Compatibility Release.

## See also

- [Release notes for ServerTemplates](/release-notes/server-templates.html)

# Changelog

Home Assistant shows this file when an update is offered. Each version names the Open Parcels
commit it runs; the upstream history between two versions is on GitHub
(`https://github.com/open-parcels/open-parcels/compare/<old>...<new>`).

## 2.0.0-dev.20261125.5

Open Parcels `34a60c0` (compare `542ed61...34a60c0`).

- Added: returns of other shops, PayPal refunds matched to orders (rules 2.0.0-dev.17)
- Added: "Read old emails again" on inboxes
- Added: fallback services on your own network
- Added: consumers and notification rules
- Changed: Home Assistant import markers with an unkeyed fingerprint become adopted
- Changed: themes, and the light/dark setting becomes the mode
- Changed: DPD Germany, UPS, FedEx, USPS, Evri and Canada Post read their own emails (rules 2.0.0-dev.16)
- Changed: Amazon, DHL and Hermes read their own emails (rules 2.0.0-dev.15)
- Added: per-inbox sender check switch
- Added: email routing to providers
- Added: Amazon "Import history"; imported history is flagged, quiet and kept
- Changed: cancelling a job drops its request in flight
- Added: connection actions and jobs
- Changed: the pool checks a finished sign-in's secret itself
- Added: `OPENPARCELS_PROVIDER_ISOLATION` runs the built-in providers in a sandbox
- Added: provider manifests; providers reach only the hosts they declare
- Added: live events `token.used` and `health.changed`
- Added: the inbox forms come from the server
- Changed: faster lists at 10,000 parcels
- Fixed: the v1 import's dry run on a fresh installation

## 2.0.0-dev.20261125.4

Open Parcels `542ed61` (compare `98694fe...542ed61`).

- Smaller image: the server is bundled and npm is gone (about 347 MB → 283 MB on amd64).
- "Add a connection" is a searchable picker with logos, like Home Assistant's "Add integration".
- Token logins for clients without cookies, an allow-list for other web addresses (CORS), and a
  sync API that also reports deletions (for the coming Android app and client libraries).

## 2.0.0-dev.20261125.3

Open Parcels `98694fe` (compare `3f1cffa...98694fe`). Pair with the Open Parcels integration 0.8.0.

- **Breaking for API clients:** errors carry codes and values; connection states carry a reason
  code instead of an English text; the setting source `app` is now `ha_app`; calendar entries carry
  drop-off and cost instead of English detail lines (see the server's CHANGELOG.md).
- More of the web UI in German: settings, carrier sign-in steps and forms, map layers, errors.
- Accessibility checks on every page and better contrast; phone layout from 360 px.
- The calendar feed follows `?lang=de` or the browser language.

## 2.0.0-dev.20261125.2

Open Parcels `3f1cffa` (compare `e7d158f...3f1cffa`). Pair with the Open Parcels integration 0.7.0.

- Automatic database backups (daily, newest 7 kept, private files) with a Backups card and
  "Back up now"; a restore tool.
- A rebuilt Status page and a health API; the version shown includes the commit.
- The web UI in English and German (follows the browser, or Settings → Language).
- Emails naming several tracking numbers in one sentence now give every parcel.
- A carrier that asks to slow down is paused for every connection.

## 2.0.0-dev.20261125.1

Open Parcels `e7d158f` (compare `fdb60e5...e7d158f`).

- Automatic place lookup of scan names is opt-in for new installs (existing installs keep their
  setting); the place search server, contact email and map tile servers can be changed in settings.
- The map tile cache follows the tile servers' caching rules; "Report a map issue" link; the
  satellite layer is marked non-commercial use only.
- The web UI refreshes when a parcel is archived or an email starts a new order.
- Many tests and clean-ups; three unused API endpoints removed (see the server's CHANGELOG.md).

## 2.0.0-dev.20261124.5

Open Parcels `fdb60e5` (compare `5ca291c...fdb60e5`).

- **Breaking:** names follow the glossary (connections, tracking number, expected delivery,
  receiving/sending). Update the Open Parcels integration to 0.6.0 together with this version; see
  the server's CHANGELOG.md for API clients.
- Orders from order emails (AliExpress, Temu, eBay, Steam, GOG, PayPal receipts and more), with
  totals; digital orders shown without a parcel.
- Optional fallback tracking through a universal-lookup service or 17TRACK.

## 2.0.0-dev.20261124.4

Open Parcels `5ca291c` (compare `10d7e31...5ca291c`).

- The app's log level option now takes effect, and settings set by the app are labelled as such.
- The unused time zone, archive days and delete days options are gone; the app passes `TZ`.
- Web fixes: every parcel and order page is loaded (no stop at 1,000 / 500), the reader password
  needs 10 characters, withdrawn expected deliveries are cleared, inside Home Assistant there is a
  link to open the web UI in its own tab.
- Amazon "Refund on order …" emails are recognised (rules 2.0.0-dev.10).

## 2.0.0-dev.20261124.3

App only, same Open Parcels commit (`10d7e31`).

- Home Assistant stops the app for a few seconds while it makes a backup, so the database copy is
  always consistent.
- Home Assistant restarts the app when the server stops answering.
- The **Parcels** panel is explicitly limited to Home Assistant administrators (it already was by
  default).
- The image is built on a Node base image pinned by digest.
- The documentation explains which value wins when an option is also saved on the Settings page,
  and that the first start inside Home Assistant needs no setup code.

## 2.0.0-dev.20261124.2

Open Parcels `10d7e31`.

- Home Assistant downloads a prebuilt image instead of building Open Parcels on the host. Installs
  and updates take seconds instead of up to 15 minutes on a Raspberry Pi.
- Returns: a Returns page, a returns section on each order and return-by dates in the calendar.

## 2.0.0-dev.20261124

Open Parcels `5a60118` (77 commits after `6a5a505`). Security-relevant and behaviour changes:

- **Reader and admin passwords.** Without a reader password, anyone who can reach port 3000 can
  read every parcel, order and address. The port stays closed unless you open it; if you do, set a
  reader password first (**Settings → Security**).
- Content security policy and security headers for the web UI; session cookies are Secure over
  HTTPS.
- The app announces itself to the Open Parcels integration (one-click setup), and the token it
  hands over now survives restarts.
- Many settings can be changed on the Settings page; a value saved there wins over the app's
  option (see the documentation).
- Data is kept until you delete it: deleting archived parcels is off by default (**Settings →
  Retention**), and a new **Data** page deletes by hand.
- Parcels and orders of disabled connections are hidden until a connection that reported them is
  enabled again.
- Inbox fixes: STARTTLS is required, and an unreadable inbox no longer stops the server.
- App: caches and database copies are kept out of Home Assistant backups, the public address is
  checked in the options form.

## 2.0.0-dev.6a5a505

Open Parcels `6a5a505`.

## 2.0.0-dev.2d5bd33

Open Parcels `2d5bd33`. Pictures load inside the Home Assistant panel.

## 2.0.0-dev.af09814

First version: Open Parcels `af09814`, built on the Home Assistant host.

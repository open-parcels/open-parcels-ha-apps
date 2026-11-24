# Changelog

Home Assistant shows this file when an update is offered. Each version names the Open Parcels
commit it runs; the upstream history between two versions is on GitHub
(`https://github.com/open-parcels/open-parcels/compare/<old>...<new>`).

## Unreleased

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

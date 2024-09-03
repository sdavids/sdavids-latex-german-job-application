<!--
SPDX-FileCopyrightText: © 2024 Sebastian Davids <sdavids@gmx.de>
SPDX-License-Identifier: Apache-2.0
-->

# Security Policy

## Supported Versions

This project will not provide security fixes.

## Reporting a Vulnerability

In case you think to have found a security issue with
_sdavids-latex-german-job-application_, please do not open a public issue.

Instead, you can report the issue to [Sebastian Davids](mailto:sdavids@gmx.de).

You can use my public keys to send me an encrypted and/or signed message.

### age

```shell
$ curl https://sdavids.de/sdavids.age | age -R - -a in.txt > out.txt.age
```

### GPG

```shell
$ curl https://sdavids.de/sdavids.gpg | gpg --import
$ gpg --fingerprint sdavids@gmx.de
```

My fingerprint: `3B05 1F8E AA0B 63D1 7220 168C 99A9 7C77 8DCD F19F`

```shell
$ gpg -esar sdavids@gmx.de -o out.txt.asc in.txt
```

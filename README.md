<a href="https://weblate.org/"><img alt="Weblate" src="https://s.weblate.org/cdn/Logo-Darktext-borders.png" height="80px" /></a>

**Weblate is a copylefted libre software web-based continuous localization system,
used by over 2500 libre projects and companies in more than 165 countries.**

# Weblate Locale Linter

Linter for localization files powered by Weblate.

_This project is in beta. The interface, features, supported formats are subject to change without any intent to keep backward compatibility._

[![Website](https://img.shields.io/badge/website-weblate.org-blue.svg)](https://weblate.org/)
[![Translation status](https://hosted.weblate.org/widgets/weblate/-/svg-badge.svg)](https://hosted.weblate.org/engage/weblate/?utm_source=widget)
[![CII Best Practices](https://bestpractices.coreinfrastructure.org/projects/552/badge)](https://bestpractices.coreinfrastructure.org/projects/552)
[![Docker Layers](https://images.microbadger.com/badges/image/weblate/locale_lint.svg)](https://microbadger.com/images/weblate/locale_lint)
[![PyPI package](https://img.shields.io/pypi/v/locale_lint.svg)](https://pypi.org/project/locale_lint/)
[![Documenation](https://readthedocs.org/projects/weblate/badge/)](https://docs.weblate.org/en/latest/locale_lint.html)

## Using manually

The Python module can be installed from the PyPI:

    pip install locale_lint

Run to lint current directory:

    locale_lint lint

## Using as GitHub action

Paste following snippet to your workflow YaML:

      - name: Weblate Locale Linter
        uses: WeblateOrg/locale_lint@v0.1

## Using as pre-commit hook

Paste following snippet to your pre-commit configuration YAML:

    - repo: https://github.com/WeblateOrg/locale_lint
      rev: v0.1
      hooks:
      - id: locale_lint

## Supported formats

All [file formats supported by
Weblate](https://docs.weblate.org/en/latest/formats.html) will be supported. We will gradualy add support for more formats during the beta.

- Android resource strings
- GNU Gettext PO files

#
# Copyright © 2012–2022 Michal Čihař <michal@cihar.com>
#
# This file is part of Locale Lint <https://github.com/WeblateOrg/locale_lint>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
#

import click
from translation_finder import discover


@click.group()
@click.version_option(prog_name="locale_lint", package_name="locale_lint")
def locale_lint():
    pass


@locale_lint.command()
@click.option("--directory", default=".")
@click.option("--source-language", default="en")
@click.option("--eager", is_flag=True, default=False)
def lint(directory: str, source_language: str, eager: bool):
    for result in discover(
        directory,
        source_language=source_language,
        eager=eager,
    ):
        click.echo(result)


if __name__ == "__main__":
    locale_lint()

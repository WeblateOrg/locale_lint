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
from click.testing import CliRunner

from .cli import locale_lint


def test_version():
    runner = CliRunner()
    result = runner.invoke(locale_lint, ["--version"])
    assert result.exit_code == 0
    assert "locale_lint" in result.output


def test_lint():
    runner = CliRunner()
    result = runner.invoke(locale_lint, ["lint"])
    assert result.exit_code == 0
    assert "Locale lint summary: 0 passed, 0 failures, 0 skipped\n" == result.output

<!--
  Copyright (C) Indrajit Roy <eendroroy@gmail.com>

  SPDX-License-Identifier: AGPL-3.0-or-later

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU Affero General Public License as
  published by the Free Software Foundation, either version 3 of the
  License, or (at your option) any later version.
-->

# dotfiles
 
## Installation

### Using the installer

```shell
curl -s 'https://raw.githubusercontent.com/eendroroy/gitter/refs/heads/master/installer.sh' | bash
```

### Manually

Clone the repo:

```bash
git clone https://github.com/eendroroy/gitter.git ~/.gitter
```

Add below line to your shell configuration file (`~/.bashrc`, `~/.zshrc`, etc.):

```shell
export PATH="$HOME/.gitter/bin:$PATH"
export fpath=("${fpath[@]}" "${HOME}/.gitter/completions")
```

## Usage

```shell
gitter help
```

## License

The project is available as open source under the terms of the [AGPL3 License](https://www.fsf.org/licensing/licenses/agpl.html).

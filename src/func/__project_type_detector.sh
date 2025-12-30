#!/usr/bin/env bash

# Copyright (C) Indrajit Roy <eendroroy@gmail.com>
#
# SPDX-License-Identifier: AGPL-3.0-or-later
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.

function __project_type() {
  local dir="$1"
  local project_type="$2"

  case $project_type in
    springboot)
      if [[ -f "${dir}/pom.xml" ]]; then
        if grep -q "org.springframework.boot" "${dir}/pom.xml"; then
            return 0  # True
        fi
      elif [[ -f "${dir}/build.gradle" ]]; then
        if grep -q "org.springframework.boot" "${dir}/build.gradle"; then
            return 0  # True
        fi
      elif [[ -f "${dir}/build.gradle.kts" ]]; then
        if grep -q "org.springframework.boot" "${dir}/build.gradle.kts"; then
            return 0  # True
        fi
      elif find "${dir}" -name "*.java" -exec grep -q "@SpringBootApplication" {} \; ; then
        return 0
      elif find "${dir}" -name "*.kt" -exec grep -q "@SpringBootApplication" {} \; ; then
        return 0
      else
        return 1
      fi
      ;;
    maven)
      if [[ -f "${dir}/.mvn/wrapper/maven-wrapper.jar" || -f "${dir}/mvnw" || -f "${dir}/mvnw.cmd" || -f "${dir}/pom.xml" ]]; then
        return 0
      else
        return 1
      fi
      ;;
    gradle)
      if [[ -f "${dir}/build.gradle" || -f "${dir}/build.gradle.kts" ]]; then
        return 0
      else
        return 1
      fi
      ;;
    nodejs)
      if [[ -f "${dir}/package.json" ]]; then
        return 0
      else
        return 1
      fi
      ;;
    python)
      if [[ -f "${dir}/setup.py" || -f "${dir}/pyproject.toml" || -f "${dir}/requirements.txt" ]]; then
        return 0
      else
        return 1
      fi
      ;;
    ruby)
      if [[ -f "${dir}/Gemfile" ]]; then
        return 0
      else
        return 1
      fi
      ;;
    go)
      if [[ -f "${dir}/go.mod" ]]; then
        return 0
      else
        return 1
      fi
      ;;
    rust)
      if [[ -f "${dir}/Cargo.toml" ]]; then
        return 0
      else
        return 1
      fi
      ;;
    php)
      if [[ -f "${dir}/composer.json" ]]; then
        return 0
      else
        return 1
      fi
      ;;
    dotnet)
      for f in "${dir}"/*.csproj "${dir}"/*.fsproj "${dir}"/*.vbproj; do
        [[ -f "$f" ]] && return 0
      done
      return 1
      ;;
    any)
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}

#!/usr/bin/env bash

# Copyright (C) Indrajit Roy <eendroroy@gmail.com>
#
# SPDX-License-Identifier: AGPL-3.0-or-later
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.

__project_type() {
  local d="$1" t="$2"
  [[ ! -d "$d" ]] && return 1

  _has() { for f in "$@"; do [[ -f "$d/$f" ]] && return 0; done; return 1; }
  _grep() { grep -q "$1" "$d/$2" 2>/dev/null; }
  _find_ext() { find "$d" -maxdepth 2 -name "*.$1" | grep -q . ; }

  case "$t" in
    # 1. Frameworks & Meta-Frameworks
    android)    _has "app/build.gradle" "settings.gradle" && _has "app/src/main/AndroidManifest.xml" ;;
    angular)    _has "angular.json" || _grep "@angular/core" "package.json" ;;
    angularjs)  _has "bower.json" || _grep "angular.js" "package.json" || (_has "index.html" && _grep "ng-app" "index.html") ;;
    flutter)    _has "pubspec.yaml" && _grep "sdk: flutter" "pubspec.yaml" ;;
    nextjs)     _grep "\"next\"" "package.json" ;;
    react)      _grep "\"react\"" "package.json" || _has "src/App.jsx" "src/App.tsx" ;;
    springboot) _has "pom.xml" "build.gradle" "build.gradle.kts" && grep -q "org.springframework.boot" "$d"/{pom.xml,build.gradle*} 2>/dev/null || grep -rq --max-depth=2 "@SpringBootApplication" "$d" --include="*.{java,kt}" 2>/dev/null ;;
    svelte)     _has "svelte.config.js" || _grep "\"svelte\"" "package.json" ;;
    vue)        _grep "\"vue\"" "package.json" || _has "src/App.vue" ;;

    # 2. Build Systems & Package Managers
    gradle)     _has "build.gradle" "build.gradle.kts" "gradlew" ;;
    maven)      _has "pom.xml" "mvnw" ".mvn/wrapper/maven-wrapper.jar" ;;
    nodejs)     _has "package.json" "yarn.lock" "pnpm-lock.yaml" ;;
    php)        _has "composer.json" ;;
    rust)       _has "Cargo.toml" ;;

    # 3. Generic Languages & Scripts
    bash)       _find_ext "bash" ;;
    c)          _find_ext "c" ;;
    cpp)        ls "$d"/*.{cpp,cc,cxx,hpp,h} &>/dev/null ;;
    dotnet)     ls "$d"/*.{csproj,fsproj,sln} &>/dev/null ;;
    go)         _has "go.mod" ;;
    python)     _has "setup.py" "pyproject.toml" "requirements.txt" ;;
    ruby)       _has "Gemfile" ;;
    shell)      _find_ext "sh" ;;
    zsh)        _has ".zshrc" ".zprofile" || ls "$d"/*.zsh &>/dev/null || _grep "^#!/bin/zsh" "shell.sh" ;;

    # 4. Infrastructure
    docker)     _has "Dockerfile" "docker-compose.yml" "docker-compose.yaml" ;;
    terraform)  _has ".terraform" || ls "$d"/*.tf &>/dev/null ;;

    any)        return 0 ;;
    *)          return 1 ;;
  esac
}

# Wrapper for automatic detection
__detect_project() {
  local target_dir="${1:-.}"
  # Sorted to prioritize specific frameworks over generic languages
  local types=(springboot nextjs react angular angularjs vue svelte flutter android maven gradle nodejs php rust bash zsh c cpp dotnet go python ruby shell docker terraform)

  for type in "${types[@]}"; do
    if __project_type "$target_dir" "$type"; then
      echo "$type"
      return 0
    fi
  done

  echo "unknown"
  return 1
}
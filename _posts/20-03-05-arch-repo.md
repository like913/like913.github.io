---
layout: project
title: "arch-repo"
description: "Пользовательский репозиторий Arch linux."
date: 05-03-2020
categories: 
- project
tags:
- project
- arch
- repo
- bash
---

Репозиторий Arch Linux.
Скрипт обновления пользовательского репозитория с пакетами Arch Linux.

`aur.x86_64`       - Перечислены пакеты которуе будут скачаны и собраны из **AUR**<br />
`packages.x86_x64` - Перечислены пакеты которые будут скачани из официального репозитория

В результате выполнения скрипта будут собраны 2 репозитория

`pkg/packages/x86_64/` - Репозиторий с локальными пакетами включает так же пакеты из **AUR**, данный репозиторий включем в дистрибутин [Arch-Live](https://github.com/like913/arch-live)<br />
`pkg/aur/x86_64/`      - Репозиторий с пакетами собраными из **AUR**

**arch-repo** - скрипт сборки репозитория для ***Arch Linux***

Copyright &copy; 2020 Ermolaev P.

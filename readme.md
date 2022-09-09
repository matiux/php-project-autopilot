PHP Project Autopilot
===

Move scripts into project by adding cp command in composer.json file

```json
{
  "scripts": {
    "post-install-cmd": [
      "bash vendor/matiux/php-project-autopilot/tool/configure.sh"
    ],
    "post-update-cmd": [
      "bash vendor/matiux/php-project-autopilot/tool/configure.sh"
    ]
  }
}
```

After installation, if necessary, customize `check_all`, `setup` functions and the list of supported operations by
overriding `custom.sh` file.

```bash
cp tools/bin/project/custom.template.sh tools/bin/project/custom.sh
```

You can also override existing functions:

```bash
cp tools/bin/project/override.template.sh tools/bin/project/override.sh
```
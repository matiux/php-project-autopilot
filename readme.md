PHP Project Autopilot
===

Move scripts into project by adding cp command in composer.json file

```json
{
  "scripts": {
    "post-install-cmd": [
      "bash vendor/matiux/php-project-autopilot/src/configure.sh"
    ],
    "post-update-cmd": [
      "bash vendor/matiux/php-project-autopilot/src/configure.sh"
    ]
  }
}
```

After installation, if necessary, customize `check_all`, `setup` functions and the list of supported operations by
editing `my_config.sh` file.

You can also override existing functions:

```bash
cp tools/bin/project/override.template.sh tools/bin/project/override.sh
```
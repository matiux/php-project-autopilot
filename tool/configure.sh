#! /bin/bash

# If dir exists, delete all files with prefix 'func_*'
if [ -d "tools/bin/project" ]; then
  find tools/bin/project -maxdepth 1 -type f -name 'func_*' -delete
fi

rm -f tools/bin/project/my_config.template.sh
rm -f tools/bin/project/override.template.sh
rm -f tools/bin/project/project

cp -R vendor/matiux/php-project-autopilot/tool/project tools/bin
cp vendor/matiux/php-project-autopilot/tool/.gitignore.tpl tools/bin/project/.gitignore

if [ ! -f "tools/bin/project/my_config.sh" ]; then
  cp vendor/matiux/php-project-autopilot/tool/project/my_config.template.sh tools/bin/project/my_config.sh
fi
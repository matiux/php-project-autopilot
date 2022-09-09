#! /bin/bash

# If dir exists, delete all files with prefix 'func_*'
if [ -d "tools/bin/project" ]; then
  #find tools/bin/project -maxdepth 1 -type f -name 'func_*' -delete
  rm -fr tools/bin/project/functions
  rm -fr tools/bin/project/tpl
  rm -f tools/bin/project/project
fi

cp -R vendor/matiux/php-project-autopilot/src/project tools/bin
cp vendor/matiux/php-project-autopilot/src/.gitignore.tpl tools/bin/project/.gitignore

if [ ! -f "tools/bin/project/my_config.sh" ]; then
  cp vendor/matiux/php-project-autopilot/src/project/tpl/my_config.template.sh tools/bin/project/my_config.sh
fi
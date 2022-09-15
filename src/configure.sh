#! /bin/bash

###################
# Tool project
###################

# If dir exists, delete all files with prefix 'func_*'
if [ -d "tools/bin/project" ]; then
  #find tools/bin/project -maxdepth 1 -type f -name 'func_*' -delete
  rm -fr tools/bin/project/functions
  rm -fr tools/bin/project/tpl
  rm -f tools/bin/project/project
fi

cp -R vendor/matiux/php-project-autopilot/src/project tools/bin
cp vendor/matiux/php-project-autopilot/src/project/tpl/.gitignore.tpl tools/bin/project/.gitignore

if [ ! -f "tools/bin/project/my_config.sh" ]; then
  cp vendor/matiux/php-project-autopilot/src/project/tpl/my_config.template.sh tools/bin/project/my_config.sh
fi

###################
# Git hooks
###################


mkdir -p scripts/git-hooks

cp vendor/matiux/php-project-autopilot/src/git-hooks/pre-commit-functions.sh scripts/git-hooks

if [ ! -f "scripts/git-hooks/commit-msg" ]; then
  cp vendor/matiux/php-project-autopilot/src/git-hooks/tpl/commit-msg.template scripts/git-hooks/commit-msg
fi

if [ ! -f "scripts/git-hooks/pre-commit" ]; then
  cp vendor/matiux/php-project-autopilot/src/git-hooks/tpl/pre-commit.template scripts/git-hooks/pre-commit
fi

#cp vendor/matiux/php-project-autopilot/src/git-hooks/tpl/override.template.sh scripts/git-hooks/override.sh

cp vendor/matiux/php-project-autopilot/src/git-hooks/tpl/.gitignore.tpl scripts/git-hooks/.gitignore
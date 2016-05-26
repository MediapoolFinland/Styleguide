Mediapool Styleguide
====================

1. Individual layout elements isolated into small, independent code blocks.
2. HTML structure is rendered from .twig -files
3. CSS compiled from individual .scss-files, 1 file per layout element
4. All elements are combined in the styleguide.php -file, which can contain links to pages that compile elements that need to be used only once per page
5. SCSS-files must be used as base files, all site-specific modifications have to be added in separate files that override necessary rules.

Installation:
-------------

1. Install Vagrant
2. Clone this repo to a folder
3. Open terminal, navigate to folder
4. Run "vagrant up" 
5. Coming up

Usage:
------

1. Add new element template files to /twig. Use specific, BEM-style naming.
2. Add the corresponding scss-file to /assets/scss/layouts, with a similar name as the .twig -file plus an underscore as suffix (eq: **row--pretty.twig** & **_row--pretty.scss**)
3. Link the twig-file to the layouts/index.php -file. Give each element an h2-level title + description paragraph. Use the render() -function to print out the actual element.
4. The render-function takes two parameters, the name of the twig-file and an array containing the variables used in the twig templates.
5. Open the layouts/index.php -file on your server and check the layout.

Notes:
------

* We use Foundation 6 as the base CSS framework.
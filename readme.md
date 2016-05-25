Mediapool Styleguide

1. Individual layout elements isolated into small, independent code blocks.
2. HTML structure is rendered from .twig -files
3. CSS compiled from individual .scss-files, 1 file per layout element
4. All elements are combined in the styleguide.php -file, which can contain links to pages that compile elements that need to be used only once per page
5. SCSS-files must be used as base files, all site-specific modifications have to be added in separate files that override necessary rules.

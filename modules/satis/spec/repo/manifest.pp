node default {

  class {'satis':
    hostname => 'example.com',
  }

  satis::repo{'foo':
    content => '{
      "name": "foo",
      "homepage": "http://example.com/foo",
      "require": {"twig/twig": "v1.14.2"},
      "repositories": [{"type": "composer", "url": "https://packagist.org"}]
    }',
  }

  satis::repo{'bar':
    content => '{
      "name": "bar",
      "homepage": "http://example.com/bar",
      "require": {"twig/twig": "v1.14.2"},
      "archive": {"directory": "dist"},
      "require-dependencies": true,
      "repositories": [{"type": "composer", "url": "https://packagist.org"}]
    }',
  }
}

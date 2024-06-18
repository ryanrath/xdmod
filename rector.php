<?php

declare(strict_types=1);

use Rector\Config\RectorConfig;
use Rector\Php70\Rector\MethodCall\ThisCallOnStaticMethodToStaticCallRector;
use Rector\Php70\Rector\StaticCall\StaticCallOnNonStaticToInstanceCallRector;
use Rector\Php70\Rector\Ternary\TernaryToNullCoalescingRector;
use Rector\TypeDeclaration\Rector\ClassMethod\AddVoidReturnTypeWhereNoReturnRector;

return RectorConfig::configure()
    ->withPaths([
        __DIR__ . '/background_scripts',
        __DIR__ . '/classes',
        __DIR__ . '/configuration',
        __DIR__ . '/html',
        __DIR__ . '/libraries',
        __DIR__ . '/open_xdmod',
        __DIR__ . '/tests',
        __DIR__ . '/tools',
    ])
    // uncomment to reach your current PHP version
    ->withPhpVersion(\Rector\ValueObject\PhpVersion::PHP_82)
    ->withSkip([
        __DIR__ . '/html/gui/lib'
    ])
    ->withPreparedSets(true,true);
    /*->withRules([
        AddVoidReturnTypeWhereNoReturnRector::class,
        StaticCallOnNonStaticToInstanceCallRector::class,
        TernaryToNullCoalescingRector::class,
        ThisCallOnStaticMethodToStaticCallRector::class
    ]);*/

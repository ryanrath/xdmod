var path = require('path');
var fs = require('fs');
var ini = require('ini');
var gutil = require('gulp-util');

var configDir = path.resolve(__dirname);
var assetPath = path.resolve(configDir, 'assets.d');

var AssetReader = require('./asset_reader');

/**
 * Main Asset management 'class'. It's main data store looks like:
 * assets: {
 *   <feature>: {
 *     <section>: [ './path/to/asset.json']
 *   }
 * };
 * or as an example:
 * assets: {
 *   jobviewer: {
 *     css:     ['./path/to/css.json'],
 *     libs:    ['./path/to/lib.json'],
 *     scripts: ['./path/to/scripts.json']
 *   }
 * };
 **/
var Assets = function() {

    var _assets = {};

    var addAsset = function(feature, type, section, asset, overwrite) {
        if (typeof section !== 'string' && typeof feature !== 'string') {
            return {
                success: false,
                message: 'You must provide a feature and section of type string.'
            };
        }
        overwrite = overwrite !== undefined ? overwrite : false;

        if (! _assets.hasOwnProperty(feature)) {
            _assets[feature] = {};
        }

        if (! _assets[feature].hasOwnProperty(type)) {
            _assets[feature][type] = {}
        }

        if (! _assets[feature][type].hasOwnProperty(section)) {
            _assets[feature][type][section] = [];
        }

        if (_assets[feature][type][section].indexOf(asset) >= 0 && overwrite === true ||
        _assets[feature][type][section].indexOf(asset) < 1) {

            _assets[feature][type][section] = asset;
            return true;
        }

        return false;
    };

    var addAssets = function(feature, type, section, assets) {
        if (typeof section !== 'string' && typeof feature !== 'string') {
            return {
                success: false,
                message: 'You must provide a feature and section of type string.'
            };
        }

        if (! _assets.hasOwnProperty(feature)) {
            _assets[feature] = {};
        }

        if (! _assets[feature].hasOwnProperty(type)) {
            _assets[feature][type] = {};
        }

        if (! _assets[feature][type].hasOwnProperty(section)) {
            _assets[feature][type][section] = [];
        }

        if (Array.isArray(assets)) {
            _assets[feature][type][section] = _assets[feature][type][section].concat(assets);
            return true;
        }

        return false;
    };

    var indexOfAsset = function(feature, section, asset) {
        return _assets.hasOwnProperty(feature) && _assets[feature].hasOwnProperty(section) && Array.isArray(_assets[feature][section]) && _assets[feature][section].indexOf(asset);
    };

    var deleteAsset = function(feature, section, asset) {
        var index = indexOfAsset(feature, section, asset);
        if (index >= 0) {
            _assets[feature][section].splice(index, 1);
        }
    };

    var deleteSection = function(feature, section) {
        if (_assets.hasOwnProperty(feature) && _assets[feature].hasOwnProperty(section)) {
            delete _assets[section];
            return true;
        }
        return false;
    };

    var deleteAllSections = function(feature) {
        if (_assets.hasOwnProperty(feature)) {
            var keys = Object.keys(_assets[feature]);
            for ( var key in keys) {
                delete _assets[feature][key];
            }
            return true;
        }
        return false;
    };

    var getAssets = function() {
        return _assets;
    };

    return {

        _init: function() {

            // Retrieve the current portal_settings file so that we can see which features we're dealing with.
            var config = ini.parse(fs.readFileSync(path.resolve(configDir, 'portal_settings.ini'), 'UTF-8'));

            var features = Object
            .keys(config.features)
            .filter(function(element) {
                return config.features[element] === 'off';
            });

            // Process the files in the assetPath...
            // Could also be reading nested directories instead of files with names that are '_' delimited.
            try {
                var reader = new AssetReader({
                    type: 'directory',
                    //type: 'file',
                    features: features,
                    basePath: assetPath,
                    filterBy: function(fileParts) {
                        var feature = this.files.feature(fileParts);
                        return this.features.indexOf(feature) >= 0;
                    },
                    fn: this.addAssets
                });

                reader.read();

            } catch (error) {
                gutil.log(gutil.colors.red('error'), error.message);
            }

            return this;
        },

        addAsset: addAsset,
        addAssets: addAssets,
        indexOfAsset: indexOfAsset,
        deleteAsset: deleteAsset,
        deleteSection: deleteSection,
        deleteAllSections: deleteAllSections,
        getAssets: getAssets,
        reader: function(){
            return new AssetReader(arguments);
        }
    }._init(arguments);
};



module.exports = Assets;

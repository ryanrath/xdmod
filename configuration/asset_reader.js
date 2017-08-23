var path = require('path');
var fs = require('fs');
var extend = require('util')._extend;

/**
 * Encapsulates the responsibility of how and which files are included for asset
 * bundling. It does this via a config object passed as the one and only
 * parameter during construction.
 * Ex. var reader = new AssetReader(
 *   {
 *     type: 'file' | 'directory',
 *
 *     basePath: '<path that will be used to look for asset files>',
 *
 *     filterBy(fileParts): A function that will be used during 'file' type
 *     operation to ensure only the desired files are included.
 *
 *     fn(type, section, [files]): The function that will be called after the
 *     processing for each file is complete and it's 'files' property has been
 *     retrieved.
 *
 *     files: an object used to provide helper functions for 'file' type
 *     operation.
 *
 *     files.delim: the delimiter to be used when splitting the file name.
 *
 *     files.feature(fileParts): a function that accepts the results of the file
 *     name split by files.delim and returns the 'feature' portion of the name.
 *
 *     files.type(fileParts): a function that accepts the results of the file
 *     name split by files.delim and returns the 'type' portion of the name.
 *
 *     files.section(fileParts): a function that accepts the results of the file
 *     name split by files.delim and returns the 'section' portion of the name.
 *
 *     directories: an object used to provide helper functions for 'directory'
 *     type operation.
 *
 *     directories.section(fileName): a function that accepts the file name and
 *     returns the 'section' portion of the name.
 *   }
 * );
 */
var AssetReader = function() {
    var args = Array.prototype.slice.call(arguments);

    // we only care about the first argument, and it should be an object.
    if (args[0] !== undefined &&
    typeof args[0] === 'object') {
        extend(this, args[0]);
    }

    /**
     * The only public function that the AssetReader provides. When called, the
     * reader will proceed to either read from the 'basePath' process the
     * files / folders there based on the 'type' provided during the initial
     * configuration. Ultimately, each file that is found / passes filtering
     * is required(...) and the 'files' property provided to the 'fn' function
     * provided during configuration.
     */
    this.read = function() {
        if (this.type === 'file') {
            return this._readFiles();
        } else if (this.type === 'directory') {
            var base = path.resolve(this.basePath, 'base');
            var modules = path.resolve(this.basePath, 'modules');
            this._readDirectories(base);
            this._readDirectories(modules);
        }
        return true;
    };

    /**
     * A helper method that just verifies that we start out with valid data.
     * If any of the validations fail then an object w/ a 'message' attribute
     * is thrown.
     *
     * @private
     **/
    this._verifyConfiguration = function() {
        if (this.basePath !== undefined && typeof this.basePath !== 'string') {
            throw {
                message: 'basePath parameter must be of type string or not defined.'
            };
        }
        if (!this.basePath) {
            throw {
                message: 'basePath must be specified as part of the configuration object.'
            };
        }

        if (this.type !== undefined && typeof this.type !== 'string' ) {
            throw {
                message: 'type parameter must be of type string or not defined.'
            };
        }

        if (this.files !== undefined && typeof this.files !== 'object') {
            throw new {
                message: 'files parameter must be of type object or not defined.'
            };
        }
    };

    /**
     * A helper function that takes care of setting all of the default values for
     * a newly constructed instance.
     *
     * @private
     **/
    this._setDefaults = function() {

        if (this.type === undefined) {
            this.type = 'file';
        }

        if (this.filterBy === undefined) {
            this.filterBy = function(/* fileParts */) {
                return true;
            };
        }

        if (this.fn === undefined) {
            this.fn = function(/* type, section, files */) { };
        }

        if (this.type === 'file' && this.files === undefined) {
            this.files = {
                delim: '_',
                feature: function(parts) {
                    return parts[0];
                },
                type: function(parts) {
                    return parts[1];
                },
                section: function(parts) {
                    return parts[2].substring(0, parts[2].indexOf('.'));
                }
            };
        }

        if (this.features === undefined) {
            this.features = [];
        }

        if (this.type === 'directory' && this.directories === undefined) {
            this.directories = {
                section: function(fileName) {
                    return fileName.substring(0, fileName.indexOf('.'));
                }
            };
        }
    };

    /**
     * Responsible for the 'file' type operation. Reads all the files in
     * 'basePath'. Files are expected to be in the following format:
     * 'feature_type_section.json'. The delimiter used between each section is
     * defined by the 'files.delimiter' property.
     *
     * @private
     **/
    this._readFiles = function() {
        var assetPath = this.basePath;
        var files = this._getFiles(assetPath);
        for ( var i = 0; i < files.length; i++) {
            var file = files[i];
            var filePath = path.resolve(assetPath, file);
            var name = path.basename(file);
            var parts = name.split(this.files.delim);
            if (this.filterBy(parts)) {
                var type = this.files.type(parts);
                var section = this.files.section(parts);

                var assets = require(filePath).files;

                this.fn(type, section, assets);
            }
        }
    };

    /**
     * Responsible for the 'directory' type operation. Directories are expected to
     * be laid out in the following format: feature/type/section.json.
     *
     * @private
     **/
    this._readDirectories = function(dirPath) {

        var features = this._getDirectories(dirPath);
        for ( var i = 0; i < features.length; i++) {
            var feature = features[i];
            if (this.features.indexOf(feature) >= 0) {
                continue;
            }

            var featurePath = path.resolve(dirPath, feature);
            var featureTypes = this._getDirectories(featurePath);
            for ( var j = 0; j < featureTypes.length; j++) {

                var type = featureTypes[j];
                var featureTypeSectionPath = path.resolve(featurePath, type);
                var featureTypeSections = this._getFiles(featureTypeSectionPath);
                for (var k = 0; k < featureTypeSections.length; k++) {

                    var section = this.directories.section(featureTypeSections[k]);
                    var sectionPath = path.resolve(featureTypeSectionPath, section);
                    var files = require(sectionPath).files;
                    this.fn(feature, type, section, files);
                }
            }
        }
    };

    /**
     * A helper function that returns all of the files in the provided 'dirPath'.
     *
     * @return {Array} files
     * @private
     **/
    this._getFiles = function(dirPath) {
        return fs.readdirSync(dirPath)
        .filter(function(file) {
            return fs.statSync(path.resolve(dirPath, file)).isFile();
        });
    };

    /**
     * Just a helper function that will scan the provided 'dirPath' and return all
     * the sub-directories ( non-recursive ).
     *
     * @return {Array} directories
     * @private
     **/
    this._getDirectories = function(dirPath) {
        return fs.readdirSync(dirPath)
        .filter(function(file) {
            return fs.statSync(path.resolve(dirPath, file)).isDirectory();
        });
    };


    // Make sure that we verify / set defaults before returning from the
    // constructor.
    this._verifyConfiguration();
    this._setDefaults();

    return this;
};

module.exports = AssetReader;

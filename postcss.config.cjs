const postcssPresetEnv = require('postcss-preset-env');
const postcssLogical = require('postcss-logical');

module.exports = {
    plugins: [
        postcssLogical(),
        postcssPresetEnv({
            stage: 2,
            features: {
                'nesting-rules': true
            }
        })
    ]
}

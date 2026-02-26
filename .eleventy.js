module.exports = function(eleventyConfig) {
  // Pass through copy for static assets
  eleventyConfig.addPassthroughCopy("src/css");
  eleventyConfig.addPassthroughCopy("src/js");
  eleventyConfig.addPassthroughCopy("src/images");

  // Set up template formats
  eleventyConfig.setTemplateFormats("njk", "md", "html");

  // Add layout alias
  eleventyConfig.addLayoutAlias("base", "src/_includes/layouts/base.njk");

  // BrowserSync for local development (optional)
  let browserSyncConfig = {
    server: {
      baseDir: "_site"
    }
  };

  // Return config
  return {
    dir: {
      input: "src",
      output: "_site",
      includes: "_includes",
      layouts: "_includes/layouts"
    },
    templateFormats: ["njk", "md", "html"],
    markdownTemplateEngine: "njk",
    htmlTemplateEngine: "njk",
    dataTemplateEngine: "njk",
    passthroughFileCopy: true,
    // Enable watch mode in development
    watch: true,
    // BrowserSync configuration
    browserSyncConfig: browserSyncConfig
  };
};

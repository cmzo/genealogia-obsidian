import { QuartzConfig } from "./quartz/cfg"
import * as Plugin from "./quartz/plugins"

/**
 * Quartz 4 Configuration - Genealogía Clemenzo
 *
 * See https://quartz.jzhao.xyz/configuration for more information.
 */
const config: QuartzConfig = {
  configuration: {
    pageTitle: "Genealogía Clemenzo",
    pageTitleSuffix: " - Investigación Familiar",
    enableSPA: true,
    enablePopovers: true,
    analytics: {
      provider: "plausible",
    },
    locale: "es-ES",
    baseUrl: "cmzo.github.io/genealogia-obsidian",
    ignorePatterns: ["private", "templates", ".obsidian", "carpetas-privadas"],
    defaultDateType: "modified",
    theme: {
      fontOrigin: "googleFonts",
      cdnCaching: true,
      typography: {
        header: "Schibsted Grotesk",
        body: "Source Sans Pro",
        code: "IBM Plex Mono",
      },
      colors: {
        lightMode: {
          light: "#faf7f2",
          lightgray: "#e8e0d0",
          gray: "#8b7355",
          darkgray: "#5d4e37",
          dark: "#2c2416",
          secondary: "#8b4513",
          tertiary: "#cd853f",
          highlight: "rgba(139, 69, 19, 0.15)",
          textHighlight: "#f5deb3",
        },
        darkMode: {
          light: "#2c2416",
          lightgray: "#5d4e37",
          gray: "#8b7355",
          darkgray: "#e8e0d0",
          dark: "#faf7f2",
          secondary: "#daa520",
          tertiary: "#cd853f",
          highlight: "rgba(218, 165, 32, 0.15)",
          textHighlight: "#f5deb3",
        },
      },
    },
  },
  plugins: {
    transformers: [
      Plugin.FrontMatter(),
      Plugin.CreatedModifiedDate({
        priority: ["frontmatter", "git", "filesystem"],
      }),
      Plugin.SyntaxHighlighting({
        theme: {
          light: "github-light",
          dark: "github-dark",
        },
        keepBackground: false,
      }),
      Plugin.ObsidianFlavoredMarkdown({ enableInHtmlEmbed: false }),
      Plugin.GitHubFlavoredMarkdown(),
      Plugin.TableOfContents(),
      Plugin.CrawlLinks({ markdownLinkResolution: "shortest" }),
      Plugin.Description(),
      Plugin.Latex({ renderEngine: "katex" }),
    ],
    filters: [Plugin.RemoveDrafts()],
    emitters: [
      Plugin.AliasRedirects(),
      Plugin.ComponentResources(),
      Plugin.ContentPage(),
      Plugin.FolderPage(),
      Plugin.TagPage(),
      Plugin.ContentIndex({
        enableSiteMap: true,
        enableRSS: true,
      }),
      Plugin.Assets(),
      Plugin.Static(),
      Plugin.Favicon(),
      Plugin.NotFoundPage(),
      // Comment out CustomOgImages to speed up build time
      Plugin.CustomOgImages(),
    ],
  },
}

export default config

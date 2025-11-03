# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Typst-based presentation template for Chinese University of Geosciences (CUG) using the Touying presentation framework. It provides a modern PPT template for academic presentations with support for Chinese and English text, mathematical equations, code highlighting, and various slide layouts.

## Build Commands

Since this is a Typst project, presentations are compiled using the Typst compiler:

```bash
# Compile a specific presentation file
typst compile Courses/ch00_课程介绍.typ

# Compile with watch mode for live preview
typst watch Courses/ch00_课程介绍.typ

# Compile to PDF (default output)
typst compile Reports/20250913_西安水论坛.typ

# Compile presentations in different directories
typst compile Courses/*.typ
typst compile Reports/*.typ
```

## Architecture and Structure

### Core Theme Files (`src/`)
- **`my-theme.typ`**: Main theme definition with custom slide types:
  - `title-slide`: Title slides with background image support
  - `centered-slide`: Centered content slides
  - `blank-slide`: Blank slides for full-page content
  - `new-section-slide`: Section divider slides with CUG branding
  - `L3-slide`: Level 3 heading slides
  - `my-theme`: Main theme function with text, math, figure, and code styling

- **`simple.typ`**: Simplified theme based on Touying framework:
  - `slide`: Standard slide function with customizable composer and layout
  - `focus-slide`: Emphasis slides with colored backgrounds
  - `simple-theme`: Theme configuration with aspect ratios and color schemes

- **`H2-slide.typ`**: Specialized Level 2 heading slides with custom headers and blue line dividers

- **`boxes.typ`**: Custom beamer-style blocks for content highlighting

- **`table.typ`**: Custom table styling functions

### Content Directories
- **`Courses/`**: Academic course presentations (e.g., `ch00_课程介绍.typ`)
- **`Reports/`**: Conference and research presentations (e.g., `20250913_西安水论坛.typ`)
- **`images/`**: Image assets including CUG logo and background images

### Key Dependencies
- `@preview/touying:0.6.1`: Core presentation framework
- `@preview/cuti:0.3.0`: Chinese font enhancement (fake bold)
- `@preview/codly:1.3.0`: Code syntax highlighting
- `@preview/mitex:0.2.5`: Mathematical typesetting
- `@preview/physica:0.9.4`: Physics symbols and units
- `@preview/mannot:0.3.0`: Additional formatting tools

## Typography Configuration

The theme uses mixed fonts for Chinese-English content:
- Chinese: `SimHei`, `FangSong`, `Microsoft YaHei`
- English: `Times New Roman`
- Code: `consolas`, `Microsoft Yahei`, `SimSun`

## Slide Types Usage

- Use `title-slide[]` for presentation titles
- Use `slide[]` for standard content slides
- Use `H2-slide[]` for Level 2 section slides
- Use `blank-slide[]` for full-page content (images, diagrams)
- Use `new-section-slide[]` for major section transitions

## Common Patterns

Presentations typically follow this structure:
1. Title slide with author information
2. Section slides using `= Level 1` headings
3. Content slides using `== Level 2` headings
4. Subsection content using `=== Level 3` headings

Mathematical equations are supported through mitex and physica packages for complex scientific notation.